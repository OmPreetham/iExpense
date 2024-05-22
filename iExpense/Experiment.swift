//
//  Experiment.swift
//  iExpense
//
//  Created by Om Preetham Bandi on 5/21/24.
//

import SwiftUI

struct SecondView: View {
    @Environment(\.dismiss) var dismiss
    
    var name: String
    var body: some View {
        Text("Hello \(name)")
        Button("Dismiss") {
            dismiss()
        }
    }
}

struct User: Codable {
    let userName: String
    let school: String
}

struct Experiment: View {
    @State private var isShowing = false
    
    @State private var numbers = [Int]()
    @State private var currentNumber = 1
    
    @AppStorage("tap") private var tapCount = 0
    
    @State private var user = User(userName: "OmPreetham", school: "Texas")
    
    var body: some View {
        NavigationStack {
            HStack {
                Button("Sheet") {
                    isShowing.toggle()
                }
                .sheet(isPresented: $isShowing, content: {
                    SecondView(name: "@OmPreetham")
                })
                Spacer()
                Button("Tap Count \(tapCount)") {
                    tapCount += 1
                }
                Spacer()
                Button("Save Data") {
                    let encoder = JSONEncoder()
                    
                    if let data = try? encoder.encode(user) {
                        UserDefaults.standard.set(data, forKey: "UserData")
                    }
                }
                Spacer()
                Button("Add New") {
                    numbers.append(currentNumber)
                    currentNumber += 1
                }
            }
            .padding()
            
            VStack {
                List {
                    ForEach(numbers, id: \.self) {
                        Text("\($0)")
                    }
                    .onDelete(perform: { indexSet in
                        removeRows(at: indexSet)
                    })
                }
            }
            .toolbar(content: {
                EditButton()
            })
        }
    }
    
    func removeRows(at offsets: IndexSet) {
        numbers.remove(atOffsets: offsets)
    }
}

#Preview {
    Experiment()
}
