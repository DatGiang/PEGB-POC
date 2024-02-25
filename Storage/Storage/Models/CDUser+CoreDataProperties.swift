//
//  CDUser+CoreDataProperties.swift
//  Storage
//
//  Created by Dat Giang on 25/02/2024.
//
//

import Foundation
import CoreData


extension CDUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDUser> {
        return NSFetchRequest<CDUser>(entityName: "CDUser")
    }

    @NSManaged public var password: String?
    @NSManaged public var username: String?
    @NSManaged public var isLoggedIn: Bool
    @NSManaged public var savedNews: NSSet?

}

// MARK: Generated accessors for savedNews
extension CDUser {

    @objc(addSavedNewsObject:)
    @NSManaged public func addToSavedNews(_ value: CDNews)

    @objc(removeSavedNewsObject:)
    @NSManaged public func removeFromSavedNews(_ value: CDNews)

    @objc(addSavedNews:)
    @NSManaged public func addToSavedNews(_ values: NSSet)

    @objc(removeSavedNews:)
    @NSManaged public func removeFromSavedNews(_ values: NSSet)

}
