//
//  AddExpense.swift
//  iExpense
//
//  Created by Om Preetham Bandi on 5/21/24.
//

import SwiftUI

struct AddExpense: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
        
    @State private var name = ""
    @State private var amount = 0.0
    @State private var type = "Personal"
    @State private var types = ["Personal", "Business"]
    
    
    var body: some View {
        NavigationStack {
            Picker("Select Type", selection: $type) {
                ForEach(types, id: \.self) {
                    Text($0)
                }
            }
            .padding()
            .pickerStyle(.palette)


            Form {
                TextField("Enter Name", text: $name)
                
                TextField("Enter Amount", value: $amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
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
                        let expense = Expense(name: name, amount: amount, type: type)
                        
                        modelContext.insert(expense)
                        dismiss()
                    }
                    .disabled(name.isEmpty || amount.isEqual(to: 0.0))
                }
            }
        }
    }
}

#Preview {
    AddExpense()
}
