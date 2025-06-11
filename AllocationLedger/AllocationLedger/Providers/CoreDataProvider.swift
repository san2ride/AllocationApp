//
//  CoreDataProvider.swift
//  AllocationLedger
//
//  Created by Jason Sanchez on 6/11/25.
//

import Foundation
import CoreData

class CoreDataProvider {
    let persistentContainer: NSPersistentContainer
    
    var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    init(inMemory: Bool = false) {
        persistentContainer = NSPersistentContainer(name: "AllocationLedgerModel")
        
        if inMemory {
            persistentContainer.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        persistentContainer.loadPersistentStores { _, error in
            if let error {
                fatalError("Core Data store failed to initialize \(error)")
            }
        }
    }
}
