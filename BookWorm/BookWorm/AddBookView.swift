//
//  AddBookView.swift
//  BookWorm
//
//  Created by Marco Capraro on 7/9/24.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var author = ""
    @State private var genre = ""
    @State private var review = ""
    @State private var rating = 3
    
    let genres = ["", "Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]

    var body: some View {
        NavigationStack {
            Form {
                Section("Book Details") {
                    TextField("Title", text: $title)
                    TextField("Author", text: $author)
                    
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section("Write a Review") {
                    TextEditor(text: $review)
                    RatingView(rating: $rating)
                }
                
                Section("Finalize BookWorm") {
                    Button("Save") {
                        let newBook = validateBook(title: title, author: author, genre: genre, review: review, rating: rating)
                        modelContext.insert(newBook)
                        dismiss()
                    }
                }
            }
            .navigationTitle("Add Book")
        }
    }
    
    func validateBook(title: String, author: String, genre: String, review: String, rating: Int) -> Book {
        let title = title.isEmpty ? "N/A" : title
        let author = author.isEmpty ? "N/A" : author
        let genre = genre.isEmpty ? "Invalid Genre" : genre
        let review = review.isEmpty ? "No review provided" : review
        
        return Book(title: title, author: author, genre: genre, review: review, rating: rating)
    }
}

#Preview {
    AddBookView()
}
