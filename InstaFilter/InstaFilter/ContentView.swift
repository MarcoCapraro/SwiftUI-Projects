//
//  ContentView.swift
//  InstaFilter
//
//  Created by Marco Capraro on 7/19/24.
//

import StoreKit
import CoreImage
import CoreImage.CIFilterBuiltins
import PhotosUI
import SwiftUI

struct ContentView: View {
    @AppStorage("filterCount") var filterCount = 0
    @Environment(\.requestReview) var requestReview
    
    @State private var selectedItem: PhotosPickerItem?
    @State private var processedImage: Image?
    @State private var filterIntensity = 0.5
    @State private var filterRadius = 0.5
    @State private var filterScale = 0.5
    @State private var showFilters = false
    
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    let context = CIContext()
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                PhotosPicker(selection: $selectedItem) {
                    if let processedImage {
                        processedImage
                            .resizable()
                            .scaledToFit()
                    } else {
                        ContentUnavailableView("No picture", systemImage: "photo.badge.plus", description: Text("Tap to import a photo"))
                    }
                }
                .onChange(of: selectedItem, loadImage)
            
                
                Spacer()
                
                VStack {
                    HStack {
                        Text("Intensity")
                        // Intensity Slider 0-1
                        Slider(value: $filterIntensity)
                            .onChange(of: filterIntensity, applyProcessing)
                    }
                    
                    HStack {
                        Text("Radius")
                        Slider(value: $filterRadius)
                            .onChange(of: filterRadius, applyProcessing)
                    }
                    
                    HStack {
                        Text("Scale")
                        Slider(value: $filterScale)
                            .onChange(of: filterScale, applyProcessing)
                    }
                }
                .disabled(processedImage == nil ? true : false)
                .padding()
                

                
                HStack {
                    Button("Change Filter", action: changeFilter)
                        .confirmationDialog("Change Filter", isPresented: $showFilters) {
                            // Buttons
                            Button("Pixellate") { setFilter(.pixellate()) }
                            Button("Crystallize") { setFilter(.crystallize()) }
                            Button("Gaussian Blur") { setFilter(.gaussianBlur()) }
                            Button("Edges") { setFilter(.edges()) }
                            Button("Sepia Tone") { setFilter(.sepiaTone()) }
                            Button("Unsharp Mask") { setFilter(.unsharpMask()) }
                            Button("Vignette") { setFilter(.vignette()) }
                            Button("Noir") { setFilter(.photoEffectNoir())}
                            Button("Bloom") { setFilter(.bloom())}
                            Button("Comic") { setFilter(.comicEffect())}
                            Button("Cancel", role: .cancel) {}

                        }
                        .disabled(processedImage == nil ? true : false)
                    
                    Spacer()
                    
                    // Sharing Button
                    if let processedImage {
                        ShareLink(item: processedImage, preview: SharePreview("InstaFilter Image", image: processedImage))
                    }
                    
                }
            }
            .padding([.horizontal, .bottom])
            .navigationTitle("InstaFilter")
        }
    }
    
    func loadImage() {
        Task {
            guard let imageData = try await selectedItem?.loadTransferable(type: Data.self) else { return }
            guard let inputImage = UIImage(data: imageData) else { return }
            
            // more code to come
            let beginImage = CIImage(image: inputImage)
            currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
            applyProcessing()
        }
    }
    
    func applyProcessing() {
        let inputKeys = currentFilter.inputKeys
        
    
        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
        }
        
        if inputKeys.contains(kCIInputRadiusKey) {
            currentFilter.setValue(filterRadius * 200, forKey: kCIInputRadiusKey)
        }
        
        if inputKeys.contains(kCIInputScaleKey) {
            currentFilter.setValue(filterScale * 10, forKey: kCIInputScaleKey)
        }

        
        guard let outputImage = currentFilter.outputImage else { return }
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return }
        
        let uiImage = UIImage(cgImage: cgImage)
        processedImage = Image(uiImage: uiImage)
    }
    
    @MainActor func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        filterCount += 1
        loadImage()
        
        if filterCount >= 1000 {
            requestReview()
        }
    }
    
    func changeFilter() {
        showFilters = true
    }
}

#Preview {
    ContentView()
}
