//
//  AddView.swift
//  iExpense
//
//  Created by Om Preetham Bandi on 5/21/24.
//

import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var name = "Name of Expense"
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
                TextField("Amount", value: $amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle($name)
            .navigationBarTitleDisplayMode(.inline)
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
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    AddView(expenses: Expenses())
}
