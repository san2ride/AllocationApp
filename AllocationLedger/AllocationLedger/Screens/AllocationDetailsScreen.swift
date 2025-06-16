//
//  AllocationDetailsScreen.swift
//  AllocationLedger
//
//  Created by Jason Sanchez on 6/16/25.
//

import SwiftUI

struct AllocationDetailsScreen: View {
    @Environment(\.managedObjectContext) private var context
    let allocation: Allocation
    
    @State private var title: String = ""
    @State private var amount: Double?
    
    @FetchRequest(sortDescriptors: []) private var expenses: FetchedResults<Expense>
    
    init(allocation: Allocation) {
        self.allocation = allocation
        _expenses = FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "allocation == %@", allocation))
    }
    
    private var isFormValid: Bool {
        !title.isEmptyOrWhitespace && amount != nil && Double(amount!) > 0
    }
    
    private func addExpense() {
        let expense = Expense(context: context)
        expense.title = title
        expense.amount = amount ?? 0
        expense.dateCreated = Date()
        
        allocation.addToExpenses(expense)
        
        do {
            try context.save()
            title = ""
            amount = nil
        } catch {
            print(error.localizedDescription)
        }
    }
    
    var body: some View {
        Form {
            Section("New expense") {
                TextField("Title", text: $title)
                TextField("Amount", value: $amount, format: .number)
                    .keyboardType(.numberPad)
                Button(action: {
                    addExpense()
                }, label: {
                    Text("Save")
                        .frame(maxWidth: .infinity)
                }).buttonStyle(.borderedProminent)
                    .disabled(!isFormValid)
            }
            Section("Expenses") {
                List(expenses) { expense in
                    HStack {
                        Text(expense.title ?? "")
                        Spacer()
                        Text(expense.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    }
                }
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
