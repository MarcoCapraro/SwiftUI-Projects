//
//  ContentView.swift
//  BookWorm
//
//  Created by Marco Capraro on 6/6/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query var books: [Book]
    @State private var showAddBookView: Bool = false
    
    var body: some View {
        NavigationStack {
            
            Text("Count: \(books.count)")
                .navigationTitle("BookWorm")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Add Book", systemImage: "plus") {
                            showAddBookView.toggle()
                        }
                    }
                }
                .sheet(isPresented: $showAddBookView) {
                    AddBookView()
                }
        }
        
    }
}

#Preview {
    ContentView()
}
