//
//  String+Ext.swift
//  AllocationLedger
//
//  Created by Jason Sanchez on 6/11/25.
//

import Foundation

extension String {
    var isEmptyOrWhitespace: Bool {
        trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
