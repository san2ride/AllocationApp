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
    
    init() {
        provider = CoreDataProvider()
    }
    
    var body: some Scene {
        WindowGroup {
            AllocationView()
                .environment(\.managedObjectContext, provider.context)
        }
    }
}
