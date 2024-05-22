//
//  ContentView.swift
//  iExpense
//
//  Created by Om Preetham Bandi on 5/21/24.
//

import Observation
import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let amount: Double
    let type: String
}

@Observable
class Expenses {
    var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }

        items = []
    }
}

struct ExpensesModifier: ViewModifier {
    let amount: Double
    
    @ViewBuilder
    func body(content: Content) -> some View {
        if amount < 10 {
            content
                .background(Color.yellow)
        } else if amount < 100 {
            content
                .background(Color.orange)
        } else {
            content
                .background(Color.red)
        }
    }
}

extension View {
    func applyExpensesModifier(amount: Double) -> some View {
        self.modifier(ExpensesModifier(amount: amount))
    }
}

struct ContentView: View {
    @State private var expenses = Expenses()
    
    @State private var showingAddNewExpense = false
    
    @State private var selectedType = "All"
    
    let types = ["All", "Personal", "Business"]
    
    var filteredExpenses: [ExpenseItem] {
        if selectedType == "All" {
            return expenses.items
        } else {
            return expenses.items.filter { $0.type == selectedType }
        }
    }

    
    var body: some View {
        NavigationStack {
            Picker("Select Expense Type", selection: $selectedType) {
                ForEach(types, id: \.self) {
                    Text($0)
                }
            }
            .pickerStyle(.segmented)
            .padding()
            
            List {
                ForEach(filteredExpenses) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }
                        
                        Spacer()
                        
                        Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    }
                    .padding()
                    .applyExpensesModifier(amount: item.amount)
                    .cornerRadius(10.0)
                }
                .onDelete(perform: { indexSet in
                    removeItems(at: indexSet)
                })
            }
            .navigationTitle("iExpense")
            .toolbar(content: {
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add Expense", systemImage: "plus") {
                        showingAddNewExpense = true
                    }
                }
            })
            .sheet(isPresented: $showingAddNewExpense, content: {
                AddView(expenses: expenses)
            })
            .listStyle(.plain)
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

#Preview {
    ContentView()
}
