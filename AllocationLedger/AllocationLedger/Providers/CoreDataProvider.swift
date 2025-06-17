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
    
    static var preview: CoreDataProvider = {
        let provider = CoreDataProvider(inMemory: true)
        let context = provider.context
        
        let entertainment = Allocation(context: context)
        entertainment.title = "Entertainment"
        entertainment.limit = 200
        entertainment.dateCreated = Date()
        
        let groceries = Allocation(context: context)
        groceries.title = "Groceries"
        groceries.limit = 500
        groceries.dateCreated = Date()
        
        let milk = Expense(context: context)
        milk.title = "Milk"
        milk.amount = 6.49
        milk.dateCreated = Date()
        
        let chips = Expense(context: context)
        chips.title = "Chips"
        chips.amount = 4.99
        chips.dateCreated = Date()
        
        groceries.addToExpenses(milk)
        groceries.addToExpenses(chips)
        
        // insert tags
        let commonTags = ["Food",
                          "Groceries",
                          "Dining",
                          "Health",
                          "Travel",
                          "Education",
                          "Entertainment",
                          "Shopping",
                          "Transportation",
                          "Utilities"]
        for commonTag in commonTags {
            let tag = Tag(context: context)
            tag.name = commonTag
        }
        
        do {
            try context.save()
        } catch {
            print(error)
        }
        return provider
    }()
    
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
