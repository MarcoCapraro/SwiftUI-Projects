//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Marco Capraro on 5/31/24.
//

import SwiftUI

@Observable
class User: Codable {
    enum CodingKeys: String, CodingKey {
        case _name = "name"
    }
    
    var name = "Taylor"
}

struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}

struct ContentView: View {
    @State private var results = [Result]()
    @State private var username = ""
    @State private var email = ""
    
    var disableForm: Bool {
        return username.count < 5 || email.count < 5
    }
    
    var body: some View {
        
        AsyncImage(url: URL(string: "https://hws.dev/img/logo.png")) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .scaledToFit()
            } else if phase.error != nil {
                Text("There was an error loading the image")
            } else {
                ProgressView()
            }
        }
        .frame(width: 200, height: 200)
        
        Form {
            Section {
                TextField("Username", text: $username)
                TextField("Email", text: $email)
            }
            
            Section {
                Button("Create Account") {
                    print("Creating new account")
                }
                .disabled(disableForm)
            }
            
            Section {
                Button("Encode Taylor", action: encodeTaylor)
            }
            
            List {
                ForEach(results, id: \.trackId) { result in
                    VStack(alignment: .leading) {
                        Text(result.trackName)
                            .font(.headline)
                        Text(result.collectionName)
                    }
                }
            }
        }
        .task {
            await loadData()
        }
    }
    
    // async keyword tells swift function might sleep before finishing
    func loadData() async {
        // 1.Create URL to read
        guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else {
            print("Invalid URL")
            return
        }
        
        // 2. Fetch data from that URL
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            // 3. Decode result into response struct
            if let decodedData = try? JSONDecoder().decode(Response.self, from: data) {
                results = decodedData.results
            }
        } catch {
            print("Invalid Data")
        }
    }
    
    func encodeTaylor() {
        let data = try! JSONEncoder().encode(User())
        let str = String(decoding: data, as: UTF8.self)
        print(str)
    }
}

#Preview {
    ContentView()
}
