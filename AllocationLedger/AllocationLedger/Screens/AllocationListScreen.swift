//
//  AllocationListScreen.swift
//  AllocationLedger
//
//  Created by Jason Sanchez on 6/11/25.
//

import SwiftUI

struct AllocationListScreen: View {
    @State private var isPresented: Bool = false
    
    var body: some View {
        VStack {
            Text("Allocations will be displayed here...")
        }.navigationTitle("Allocation")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add") {
                        isPresented = true
                    }
                }
            }
            .sheet(isPresented: $isPresented, content: {
                AddAllocationScreen()
            })
    }
}

#Preview {
    NavigationStack {
        AllocationListScreen()
    }
}
