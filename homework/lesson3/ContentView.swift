//
//  ContentView.swift
//  lesson3
//
//  Created by Tiiviu on 14/12/25.
//

import SwiftUI

struct ContentView: View {
    @State private var items = ["sasha", "4p", "hủngy", "idk", "help"]
    @State private var newItem = ""
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Enter", text: $newItem)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button("Add") {
                        items.append(newItem)
                        newItem = ""
                    }
                    .disabled(newItem.isEmpty)
                }
                .padding()
                
                List {
                    Section(header: Text("My bababa")) {
                        ForEach(items, id: \.self) { item in
                            NavigationLink(destination: EditView(item: binding(for: item))) {
                                Text(item)
                            }
                        }
                        .onDelete(perform: deleteItem)
                    }
                }
            }
            .navigationTitle("Shopping List")
        }
    }
    
    func deleteItem(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
    }
    
    func binding(for item: String) -> Binding<String> {
        guard let index = items.firstIndex(of: item) else {
            fatalError("sasha not found")
        }
        return $items[index]
    }
}

struct EditView: View {
    @Binding var item: String
    @State private var editedItem = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Current: \(item)")
                .font(.headline)
            
            TextField("Edit item", text: $editedItem)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .onAppear {
                    editedItem = item
                }
            
            Button("Save") {
                item = editedItem
            }
            .disabled(editedItem.isEmpty)
        }
        .padding()
        .navigationTitle("Edit")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



