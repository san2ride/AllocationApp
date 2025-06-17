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
    @State private var selectedTags: Set<Tag> = []
    
    @FetchRequest(sortDescriptors: []) private var expenses: FetchedResults<Expense>
    
    init(allocation: Allocation) {
        self.allocation = allocation
        _expenses = FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "allocation == %@", allocation))
    }
    
    private var isFormValid: Bool {
        !title.isEmptyOrWhitespace && amount != nil && Double(amount!) > 0 && !selectedTags.isEmpty
    }
    
    private var total: Double {
        return expenses.reduce(0) { result, expense in
            expense.amount + result
        }
    }
    
    private var remaining: Double {
        allocation.limit - total
    }
    
    private func addExpense() {
        let expense = Expense(context: context)
        expense.title = title
        expense.amount = amount ?? 0
        expense.dateCreated = Date()
        expense.tags = NSSet(array: Array(selectedTags))
        
        allocation.addToExpenses(expense)
        
        do {
            try context.save()
            title = ""
            amount = nil
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func deleteExpense(_ indexSet: IndexSet) {
        indexSet.forEach { index in
            let expense = expenses[index]
            context.delete(expense)
        }
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    var body: some View {
        VStack {
            Text(allocation.limit, format: .currency(code: Locale.currencyCode))
                .frame(maxWidth: .infinity, alignment: .top)
                .font(.largeTitle)
                .padding()
        }
        Form {
            Section("New expense") {
                TextField("Title", text: $title)
                TextField("Amount", value: $amount, format: .number)
                    .keyboardType(.numberPad)
                TagsView(selectedTags: $selectedTags)
                Button(action: {
                    addExpense()
                }, label: {
                    Text("Save")
                        .frame(maxWidth: .infinity)
                }).buttonStyle(.borderedProminent)
                    .disabled(!isFormValid)
            }
            Section("Expenses") {
                List {
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Total")
                            Spacer()
                            Text(total, format: .currency(code: Locale.currencyCode))
                        }
                        HStack {
                            Text("Remaining")
                            Spacer()
                            Text(remaining, format: .currency(code: Locale.currencyCode))
                                .foregroundStyle(remaining < 0 ? .red : .green)
                        }
                    }
                    ForEach(expenses) { expense in
                        ExspenseCellView(expense: expense)
                    }.onDelete(perform: deleteExpense)
                }
            }
        }.navigationTitle(allocation.title ?? "")
    }
}

struct AllocationDetailScreenContainer: View {
    @FetchRequest(sortDescriptors: []) private var allocation: FetchedResults<Allocation>
    
    var body: some View {
        AllocationDetailsScreen(allocation: allocation.first(where: { $0.title == "Groceries" })!)
    }
}

#Preview {
    AllocationDetailScreenContainer()
        .environment(\.managedObjectContext, CoreDataProvider.preview.context)
}
