//
//  ContentView.swift
//  iExpense
//
//  Created by Om Preetham Bandi on 5/21/24.
//

import SwiftData
import SwiftUI

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
    @Environment(\.modelContext) var modelContext
    @Query var expenses: [Expense]
    
    @State private var showingAddExpense = false
    
    @State private var sortOrder: [SortDescriptor<Expense>] = []
    
    @State private var filterType = "All"
    @State private var types = ["All", "Personal", "Business"]


    var body: some View {
        NavigationStack {
            Picker("Filter", selection: $filterType) {
                ForEach(types, id: \.self) {
                    Text($0)
                }
            }
            .padding()
            .pickerStyle(.palette)
            
            ExpensesView(type: filterType, sortOrder: sortOrder)
            
            .navigationTitle("iExpense")
            .listStyle(.plain)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        showingAddExpense.toggle()
                    }) {
                        Label("New Expense", systemImage: "plus")
                    }
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    Menu {
                        Picker("Sort", selection: $sortOrder) {
                            Text("Sort by Name")
                                .tag([SortDescriptor(\Expense.name), SortDescriptor(\Expense.amount)])
                            
                            Text("Sort by Amount")
                                .tag([SortDescriptor(\Expense.amount), SortDescriptor(\Expense.name)])
                        }
                    } label: {
                        Label("Sort", systemImage: "arrow.up.arrow.down")
                    }
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddExpense()
            }
        }
    }
}

#Preview {
    ContentView()
}
