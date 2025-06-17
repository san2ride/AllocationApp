//
//  ExpenseCellView.swift
//  AllocationLedger
//
//  Created by Jason Sanchez on 6/16/25.
//

import SwiftUI

struct ExspenseCellView: View {
    let expense: Expense
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(expense.title ?? "")
                Spacer()
                Text(expense.amount, format: .currency(code: Locale.currencyCode))
            }
            ScrollView(.horizontal) {
                HStack {
                    ForEach(Array(expense.tags as? Set<Tag> ?? [])) { tag in
                        Text(tag.name ?? "")
                            .font(.caption)
                            .padding(6)
                            .foregroundStyle(.white)
                            .background(.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    }
                }
            }
        }
    }
}

struct ExpenseCellViewContainer: View {
    @FetchRequest(sortDescriptors: []) private var expenses: FetchedResults<Expense>
    
    var body: some View {
        ExspenseCellView(expense: expenses[0])
    }
}

#Preview {
    ExpenseCellViewContainer()
        .environment(\.managedObjectContext, CoreDataProvider.preview.context)
}
