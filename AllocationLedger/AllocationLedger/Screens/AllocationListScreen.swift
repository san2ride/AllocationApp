//
//  AllocationListScreen.swift
//  AllocationLedger
//
//  Created by Jason Sanchez on 6/11/25.
//

import SwiftUI

struct AllocationListScreen: View {
    @FetchRequest(sortDescriptors: []) private var allocations: FetchedResults<Allocation>
    @State private var isPresented: Bool = false
    
    var body: some View {
        VStack {
            List(allocations) { allocation in
                AllocationCellView(allocation: allocation)
            }
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
    }.environment(\.managedObjectContext, CoreDataProvider.preview.context)
}
