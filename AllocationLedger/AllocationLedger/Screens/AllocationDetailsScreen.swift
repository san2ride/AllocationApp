//
//  AllocationDetailsScreen.swift
//  AllocationLedger
//
//  Created by Jason Sanchez on 6/16/25.
//

import SwiftUI

struct AllocationDetailsScreen: View {
    let allocation: Allocation
    
    @State private var title: String = ""
    @State private var amount: Double?
    
    private var isFormValid: Bool {
        !title.isEmptyOrWhitespace && amount != nil && Double(amount!) > 0
    }
    
    var body: some View {
        Form {
            Section("New expense") {
                TextField("Title", text: $title)
                TextField("Amount", value: $amount, format: .number)
                    .keyboardType(.numberPad)
                Button(action: {
                    
                }, label: {
                    Text("Save")
                        .frame(maxWidth: .infinity)
                }).buttonStyle(.borderedProminent)
                    .disabled(!isFormValid)
            }
        }.navigationTitle(allocation.title ?? "")
    }
}

struct AllocationDetailScreenContainer: View {
    @FetchRequest(sortDescriptors: []) private var allocation: FetchedResults<Allocation>
    
    var body: some View {
        AllocationDetailsScreen(allocation: allocation[0])
    }
}

#Preview {
    AllocationDetailScreenContainer()
        .environment(\.managedObjectContext, CoreDataProvider.preview.context)
}
