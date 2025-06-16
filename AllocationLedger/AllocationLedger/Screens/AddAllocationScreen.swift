//
//  AddAllocationScreen.swift
//  AllocationLedger
//
//  Created by Jason Sanchez on 6/11/25.
//

import SwiftUI

struct AddAllocationScreen: View {
    @Environment(\.managedObjectContext) private var context
    
    @State private var title: String = ""
    @State private var limit: Double?
    @State private var errorMessage: String = ""
    
    private var isFormValid: Bool {
        !title.isEmptyOrWhitespace && limit != nil && Double(limit!) > 0
    }
    
    private func saveAllocation() {
        let allocation = Allocation(context: context)
        allocation.title = title
        allocation.limit = limit ?? 0.0
        allocation.dateCreated = Date()
        
        do {
            try context.save()
            errorMessage = ""
        } catch {
            errorMessage = "Unable to save allocation"
        }
    }
    
    var body: some View {
        Form {
            Text("New Allocation")
                .font(.title)
                .font(.headline)
            TextField("Title", text: $title)
                .presentationDetents([.medium])
            TextField("Limit", value: $limit, format: .number)
                .keyboardType(.numberPad)
            Button {
                if !Allocation.exists(context: context, title: title) {
                    saveAllocation()
                } else {
                    errorMessage = "Allocation title already exists"
                }
            } label: {
                Text("Save")
                .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .disabled(!isFormValid)
            .presentationDetents([.medium])
            
            Text(errorMessage)
        }
    }
}

#Preview {
    AddAllocationScreen()
        .environment(\.managedObjectContext, CoreDataProvider.init(inMemory: true).context)
}
