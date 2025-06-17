//
//  TagsSeeder.swift
//  AllocationLedger
//
//  Created by Jason Sanchez on 6/17/25.
//

import Foundation
import CoreData

class TagsSeeder {
    private var context: NSManagedObjectContext
    
    /*let commonTags = ["Food",
                      "Groceries",
                      "Dining",
                      "Health",
                      "Travel",
                      "Education",
                      "Entertainment",
                      "Shopping",
                      "Transportation",
                      "Utilities"]
    */
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func seed(_ commonTags: [String]) throws {
        for commonTag in commonTags {
            let tag = Tag(context: context)
            tag.name = commonTag
            
            try context.save()
        }
    }
}
