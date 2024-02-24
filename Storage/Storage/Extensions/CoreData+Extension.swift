//
//  CoreData+Extension.swift
//  Storage
//
//  Created by Dat Giang on 24/02/2024.
//

import CoreData
import Foundation

extension NSManagedObjectContext {
    /// Only performs a save if there are changes to commit.
    /// - Returns: `true` if a save was needed. Otherwise, `false`.
    @discardableResult public func saveIfNeeded() throws -> Bool {
        guard hasChanges else { return false }
        try save()
        return true
    }
}
