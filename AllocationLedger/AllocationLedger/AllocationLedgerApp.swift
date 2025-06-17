//
//  AllocationLedgerApp.swift
//  AllocationLedger
//
//  Created by Jason Sanchez on 6/11/25.
//

import SwiftUI

@main
struct AllocationLedgerApp: App {
    let provider: CoreDataProvider
    let tagSeeder: TagsSeeder
    
    init() {
        provider = CoreDataProvider()
        tagSeeder = TagsSeeder(context: provider.context)
    }
    
    var body: some Scene {
        WindowGroup {
            AllocationView()
                .onAppear {
                    let hasSeededData = UserDefaults.standard.bool(forKey: "hasSeedData")
                    if !hasSeededData {
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
                        do {
                            try tagSeeder.seed(commonTags)
                            UserDefaults.standard.setValue(true, forKey: "hasSeedData")
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                }
                .environment(\.managedObjectContext, provider.context)
        }
    }
}
