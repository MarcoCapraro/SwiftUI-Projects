//
//  ContentView.swift
//  InstaFilter
//
//  Created by Marco Capraro on 7/19/24.
//

import PhotosUI
import SwiftUI

struct ContentView: View {
    @State private var processedImage: Image?
    @State private var filterIntensity = 0.5
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                if let processedImage {
                    processedImage
                        .resizable()
                        .scaledToFit()
                } else {
                    ContentUnavailableView("No picture", systemImage: "photo.badge.plus", description: Text("Tap to import a photo"))
                }
            
                
                Spacer()
                
                HStack {
                    Text("Intensity")
                    // Intensity Slider 0-1
                    Slider(value: $filterIntensity)
                }
                
                HStack {
                    Button("Change Filter", action: changeFilter)
                    
                    Spacer()
                    
                    // Sharing Button

                }
            }
            .padding([.horizontal, .bottom])
            .navigationTitle("InstaFilter")
        }
    }
    
    func changeFilter() {
        
    }
}

#Preview {
    ContentView()
}
