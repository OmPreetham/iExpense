//
//  ExpensesView.swift
//  iExpense
//
//  Created by Om Preetham Bandi on 6/12/24.
//

import SwiftData
import SwiftUI

struct ExpensesView: View {
    @Query var expenses: [Expense]
    
    var body: some View {
        List(expenses) { expense in
            HStack {
                VStack(alignment: .leading) {
                    Text(expense.name)
                        .font(.headline)
                        .fontWeight(.semibold)
                    Text(expense.type)
                }
                Spacer()
                Text("\(expense.amount.formatted())")
                    .fontWeight(.medium)
            }
            .padding()
            .applyExpensesModifier(amount: expense.amount)
            .clipShape(RoundedRectangle(cornerRadius: 10.0))
        }
    }
    
    init(type: String, sortOrder: [SortDescriptor<Expense>]) {
        _expenses = Query(filter: #Predicate<Expense> { expense in
            if type == "All" {
                return true
            } else {
                return expense.type == type
            }
        }, sort: sortOrder)
    }
}

#Preview {
    ExpensesView(type: "Personal", sortOrder: [SortDescriptor(\Expense.name)])
        .modelContainer(for: Expense.self)
}
