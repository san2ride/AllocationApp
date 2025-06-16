//
//  AllocationCellView.swift
//  AllocationLedger
//
//  Created by Jason Sanchez on 6/16/25.
//

import SwiftUI

struct AllocationCellView: View {
    let allocation: Allocation
    
    var body: some View {
        HStack {
            Text(allocation.title ?? "")
            Spacer()
            Text(allocation.limit, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
        }
    }
}
