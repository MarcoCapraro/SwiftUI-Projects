//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Marco Capraro on 5/31/24.
//

import SwiftUI

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
    
    var body: some View {
        List(results, id: \.trackId) { result in
            VStack(alignment: .leading) {
                Text(result.trackName)
                    .font(.headline)
                Text(result.collectionName)
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
}

#Preview {
    ContentView()
}
