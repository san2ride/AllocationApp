//
//  Locale+Ext.swift
//  AllocationLedger
//
//  Created by Jason Sanchez on 6/16/25.
//

import Foundation

extension Locale {
    static var currencyCode: String {
        Locale.current.currency?.identifier ?? "USD"
    }
}
