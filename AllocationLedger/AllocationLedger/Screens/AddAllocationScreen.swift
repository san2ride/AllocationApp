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
    
    private var isFormValid: Bool {
        !title.isEmptyOrWhitespace && limit != nil && Double(limit!) > 0
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
                // action
            } label: {
                Text("Save")
                .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .disabled(!isFormValid)
            .presentationDetents([.medium])
        }
    }
}

#Preview {
    AddAllocationScreen()
        .environment(\.managedObjectContext, CoreDataProvider.init(inMemory: true).context)
}
