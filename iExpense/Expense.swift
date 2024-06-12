//
//  Expense.swift
//  iExpense
//
//  Created by Om Preetham Bandi on 6/12/24.
//

import Foundation
import SwiftData

@Model
class Expense {
    var id = UUID()
    let name: String
    let amount: Double
    let type: String

    init(id: UUID = UUID(), name: String, amount: Double, type: String) {
        self.id = id
        self.name = name
        self.amount = amount
        self.type = type
    }
}
