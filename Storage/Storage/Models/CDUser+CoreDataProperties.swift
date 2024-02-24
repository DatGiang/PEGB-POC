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

    @NSManaged public var username: String?
    @NSManaged public var password: String?

}
