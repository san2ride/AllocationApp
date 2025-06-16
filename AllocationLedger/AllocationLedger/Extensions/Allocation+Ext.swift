//
//  Allocation+Ext.swift
//  AllocationLedger
//
//  Created by Jason Sanchez on 6/16/25.
//

import Foundation
import CoreData

extension Allocation {
    
    static func exists(context: NSManagedObjectContext, title: String) -> Bool {
        let request = Allocation.fetchRequest()
        request.predicate = NSPredicate(format: "title == %@", title)
        
        do {
            let results = try context.fetch(request)
            return !results.isEmpty
        } catch {
            return false
        }
    }
}
