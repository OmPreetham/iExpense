//
//  AddView.swift
//  iExpense
//
//  Created by Om Preetham Bandi on 5/21/24.
//

import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var amount = 0.0
    @State private var type = "Personal"
    
    let types = ["Personal", "Business"]
    
    var expenses: Expenses
    
    var body: some View {
        NavigationStack {
            Picker("Select Expense Type", selection: $type) {
                ForEach(types, id: \.self) {
                    Text($0)
                }
            }
            .padding()
            .pickerStyle(.segmented)
            
            Form {
                TextField("Name of Expense", text: $name)
                
                TextField("Amount", value: $amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Add New Expense")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        if name.isEmpty || amount.isZero {
                            dismiss()
                            return
                        }
                        
                        let items = ExpenseItem(name: name, amount: amount, type: type)
                        expenses.items.append(items)
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    AddView(expenses: Expenses())
}
