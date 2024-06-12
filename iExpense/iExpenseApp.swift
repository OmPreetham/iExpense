//
//  iExpenseApp.swift
//  iExpense
//
//  Created by Om Preetham Bandi on 5/21/24.
//

import SwiftData
import SwiftUI

@main
struct iExpenseApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Expense.self)
    }
}
