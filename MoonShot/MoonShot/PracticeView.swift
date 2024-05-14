//
//  PracticeView.swift
//  MoonShot
//
//  Created by Marco Capraro on 5/13/24.
//

import SwiftUI

struct CustomText: View {
    var text: String
    
    var body: some View {
        Text(text)
    }
    
    init(text: String) {
        print("Creating new CustomText")
        self.text = text
    }
}

struct User: Codable {
    let name: String
    let address: Address
}

struct Address: Codable {
    let street: String
    let city: String
}

struct PracticeView: View {
    let layout = [
        GridItem(.adaptive(minimum: 80, maximum: 120))
    ]
    
    var body: some View {
        NavigationStack {
            Image(.tron)
                .resizable()
                .scaledToFit()
                .containerRelativeFrame(.horizontal) { size, axis in
                    size * 0.8
                }
            
            List(0..<100) { row in
                NavigationLink("Row \(row)") {
                    ScrollView {
                        LazyVGrid(columns: layout) {
                            ForEach(0..<1000) {
                                Text("Item \($0)")
                            }
                        }
                    }
                }
            }
            .navigationTitle("SwiftUI")
            
            ScrollView(.horizontal) {
                LazyHStack {
                    ForEach(0..<100) {
                        CustomText(text: "Item \($0)")
                            .font(.title)
                    }
                }
            }
            
            Button("Decode JSON") {
                // JSON String to test with
                let input = """
                {
                    "name": "Marco Capraro",
                    "address": {
                        "street": "555, Marco Capraro Avenue",
                        "city": "Nashville"
                    }
                }
                """
                
                let data = Data(input.utf8)
                let decoder = JSONDecoder()
                
                if let user = try? decoder.decode(User.self, from: data) {
                    print(user.address.street)
                }
            }
        }
        
        
        
        
        
    }
}

#Preview {
    PracticeView()
}
