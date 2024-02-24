//
//  CDNews+CoreDataProperties.swift
//  Storage
//
//  Created by Dat Giang on 25/02/2024.
//
//

import Foundation
import CoreData


extension CDNews {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDNews> {
        return NSFetchRequest<CDNews>(entityName: "CDNews")
    }

    @NSManaged public var author: String?
    @NSManaged public var title: String?
    @NSManaged public var desc: String?
    @NSManaged public var url: String?
    @NSManaged public var imageUrl: String?
    @NSManaged public var publishedAt: Date?
    @NSManaged public var content: String?

}
