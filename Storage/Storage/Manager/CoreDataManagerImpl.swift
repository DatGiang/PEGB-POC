//
//  CoreDataManagerImpl.swift
//  Storage
//
//  Created by Dat Giang on 24/02/2024.
//

import CoreData
import Foundation
import PEGBCore

public class CoreDataManagerImpl: CoreDataManager {
    static let modelName = "DataModel"
    
    // MARK: - Properties

    private let fileManager = FileManager.default
    private let modelName: String
    private lazy var managedObjectModel: NSManagedObjectModel = {
        guard let modelURL = Bundle(for: Self.self).url(
            forResource: self.modelName,
            withExtension: "momd"
        ) else {
            fatalError("Unable to Find Data Model")
        }
        guard let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Unable to Load Data Model")
        }
        return managedObjectModel
    }()

    private lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
    }()

    /// Accessible NSManagedObjectContext which contains
    /// the privateManagedObjectContext as the parent
    /// Calling a save here will push the changes to the privateManagedObjectContext,
    ///  but it will not be persisted until saveChanges is called.
    public lazy var backgroundManagedObjectContext: NSManagedObjectContext = {
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        managedObjectContext.parent = privateManagedObjectContext
        return managedObjectContext
    }()
    
    public lazy var publishableManagedObjectContext: NSManagedObjectContext = {
        let managedObjectContext = NSManagedObjectContext(
            concurrencyType: .privateQueueConcurrencyType
        )
        managedObjectContext.parent = privateManagedObjectContext
        return managedObjectContext
    }()

    /// private NSManagedObjectContext with access to the persistent store coordinator
    private lazy var privateManagedObjectContext: NSManagedObjectContext = {
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator
        managedObjectContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return managedObjectContext
    }()
    
    public var publishableContextChangedListener: (() -> Void)?

    public static let shared = CoreDataManagerImpl(modelName: CoreDataManagerImpl.modelName)

    private init(modelName: String) {
        self.modelName = modelName
        setupCoreDataStack()

        // Add Observer from background managed context
        var notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(managedObjectContextDidSave(notification:)), name: NSNotification.Name.NSManagedObjectContextDidSave, object: backgroundManagedObjectContext)
        notificationCenter.addObserver(self, selector: #selector(privateManagedObjectContextDidSave(notification:)), name: NSNotification.Name.NSManagedObjectContextDidSave, object: privateManagedObjectContext)
        notificationCenter.addObserver(self, selector: #selector(self.publishableManagedObjectContextDidChange(notification:)), name: NSNotification.Name.NSManagedObjectContextDidSave, object: publishableManagedObjectContext)
    }

    // MARK: Notification Handling

    @objc func managedObjectContextDidSave(notification: Notification) {
        // Merged changes and saved
        privateManagedObjectContext.mergeChanges(fromContextDidSave: notification)
        saveChanges()
    }

    @objc func privateManagedObjectContextDidSave(notification: Notification) {
    }
    
    @objc func publishableManagedObjectContextDidChange(notification: Notification) {
        // Merged changes and saved
        self.privateManagedObjectContext.mergeChanges(fromContextDidSave: notification)
        self.saveChanges()
        
        publishableContextChangedListener?()
    }

    // MARK: - Functions

    /// Persists the current changes on the privateManagedObjectContext
    /// If there was no changes made, the operation will return
    func saveChanges() {
        privateManagedObjectContext.perform {
            do {
                try self.privateManagedObjectContext.saveIfNeeded()
            } catch {
                printLog("Unable to Save Changes of Private Managed Object Context")
                printLog("\(error), \(error.localizedDescription)")
            }
        }
    }
}

extension CoreDataManagerImpl {
    // MARK: - Private Functions

    private func setupCoreDataStack() {
        guard let persistentStoreCoordinator = privateManagedObjectContext.persistentStoreCoordinator
        else { fatalError("Unable to Set Up Core Data Stack") }
        addPersistentStore(to: persistentStoreCoordinator)
        DispatchQueue.main.async {
            printLog("Finished setting up Core Data")
        }
    }

    private func addPersistentStore(to persistentStoreCoordinator: NSPersistentStoreCoordinator) {
        let storeName = "\(modelName).sqlite"
        let documentsDirectoryURL = fileManager.urls(
            for: .documentDirectory,
            in: .userDomainMask
        )[0]
        let persistentStoreURL = documentsDirectoryURL.appendingPathComponent(storeName)

        do {
            let options = [
                NSMigratePersistentStoresAutomaticallyOption: true,
                NSInferMappingModelAutomaticallyOption: true,
            ]
            try persistentStoreCoordinator.addPersistentStore(
                ofType: NSSQLiteStoreType,
                configurationName: nil,
                at: persistentStoreURL,
                options: options
            )
        } catch {
            fatalError("Unable to Add Persistent Store")
        }
    }
}
