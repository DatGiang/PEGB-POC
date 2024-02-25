//
//  CoreDataRepository.swift
//  Storage
//
//  Created by Dat Giang on 24/02/2024.
//

import CoreData
import Foundation

public enum RepositoryError: Error {
    case objectNotFound
}

public class CoreDataRepository<Entity: NSManagedObject> {
    let context: NSManagedObjectContext

    public init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    /// Performs a CoreData fetch request for the given generic Entity
    /// - Parameters:
    ///   - sortDescriptors: The [NSSortDescriptor] to be used when sorting the data, default is []
    ///   - predicate: the NSPredicate to be used in the fetch request, default is nil
    public func fetch(
        sortDescriptors: [NSSortDescriptor] = [],
        predicate: NSPredicate? = nil,
        completion: (Result<[Entity], Error>) -> Void
    ) {
        context.performAndWait { [weak self] in
            guard let self else { return }
            let request = Entity.fetchRequest()
            request.sortDescriptors = sortDescriptors
            request.predicate = predicate
            do {
                let results = try self.context.fetch(request) as? [Entity] ?? []
                if results.isEmpty {
                    completion(.failure(RepositoryError.objectNotFound))
                } else {
                    completion(.success(results))
                }
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    /// Adds a new NSManagedObject Entity in the database.
    /// Provides the caller with the ability to apply changes to the object prior to persisting it
    public func add(
        _ body: @escaping (inout Entity) -> Void,
        completion: (Result<Entity, Error>) -> Void
    ) {
        context.performAndWait {
            var entity = Entity(context: context)
            body(&entity)
            do {
                try context.save()
                completion(.success(entity))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    /// Deletes the NSManagedObject Entity in the database.
    public func delete(_ entity: Entity, completion: (Result<Void, Error>) -> Void) {
        context.performAndWait {
            do {
                context.delete(entity)
                try context.save()
                completion(.success(()))
            } catch {
                completion(.failure(error))
            }
        }
    }
}
