//
//  NavigationPathsView.swift
//  Navigation
//
//  Created by Marco Capraro on 5/17/24.
//

import SwiftUI

@Observable
class PathStore {
    var path: NavigationPath {
        didSet {
            save()
        }
    }
    
    private let savePath = URL.documentsDirectory.appending(path: "SavedPath")
    
    init() {
        // Find Path Records on Disc
        if let data = try? Data(contentsOf: savePath) {
            // Decode Path Records and set path
            if let decoded = try? JSONDecoder().decode(NavigationPath.CodableRepresentation.self, from: data) {
                path = NavigationPath(decoded)
                return
            }
        }
        
        path = NavigationPath()
    }
    
    func save() {
        guard let representation = path.codable else { return }
        
        do {
            let data = try JSONEncoder().encode(representation)
            try data.write(to: savePath)
        } catch {
            fatalError("Failed to save navigation path")
        }
    }
    
}

struct DetailView: View {
    var number: Int
    @Binding var path: NavigationPath
        
    var body: some View {
        NavigationLink("Go to Random Number", value: Int.random(in: 1..<1000))
            .navigationTitle("Number \(number)")
            .toolbar {
                Button("Home") {
                    path = NavigationPath()
                }
            }
    }
}

struct DetailView2: View {
    var number: Int
        
    var body: some View {
        NavigationLink("Go to Random Number", value: Int.random(in: 1..<1000))
            .navigationTitle("Number \(number)")
    }
}

struct NavigationPathsView: View {
    @State private var path1 = [Int]()
    @State private var path2 = NavigationPath()
    @State private var path3 = NavigationPath()
    @State private var pathStore = PathStore()
    
    var body: some View {
        VStack {
            NavigationStack(path: $path3) {
                DetailView(number: 0, path: $path3)
                    .navigationDestination(for: Int.self) { i in
                        DetailView(number: i, path: $path3)
                    }
            }
            
            NavigationStack(path: $pathStore.path) {
                DetailView2(number: 0)
                    .navigationDestination(for: Int.self) { i in
                        DetailView2(number: i)
                    }
            }
            
            
            NavigationStack(path: $path2) {
                List {
                    ForEach(0..<5) { i in
                        NavigationLink("Select Number \(i)", value: i)
                    }
                    
                    ForEach(0..<5) { i in
                        NavigationLink("Select String \(i)", value: String(i))
                    }
                }
                .toolbar {
                    Button("Push 556") {
                        path2.append(556)
                    }
                    
                    Button("Push Hello") {
                        path2.append("Hello")
                    }
                }

                .navigationDestination(for: Int.self) { selection in
                    Text("You selected Number \(selection)")
                }
                .navigationDestination(for: String.self) { selection in
                    Text("You selected String \(selection)")
                }
            }
            
            NavigationStack(path: $path1) {
                VStack {
                    Button("Show 32") {
                        path1 = [32]
                    }
                    
                    Button("Show 64") {
                        path1.append(64)
                    }
                    
                    Button("Show 64 then 32") {
                        path1 = [32, 64]
                    }
                }
                .navigationDestination(for: Int.self) { selection in
                    Text("You selected \(selection)")
                }
            }
        }
    }
}

#Preview {
    NavigationPathsView()
}
