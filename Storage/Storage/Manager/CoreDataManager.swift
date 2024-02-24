//
//  CoreDataManager.swift
//  Storage
//
//  Created by Dat Giang on 24/02/2024.
//

import CoreData
import Foundation

protocol CoreDataManager {
    var backgroundManagedObjectContext: NSManagedObjectContext { get }
}
