//
//  ContentView.swift
//  InstaFilter
//
//  Created by Marco Capraro on 7/19/24.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct ContentView: View {
    @State private var image: Image?
    
    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()
        }
        .onAppear(perform: loadImage)
    }
    
    func loadImage() {
        let inputImage = UIImage(resource: .example)
        let beginImage = CIImage(image: inputImage)
        
        // more code to come
        let context = CIContext()
        // let currentFilter = CIFilter.sepiaTone()
        // let currentFilter = CIFilter.crystallize()
        let currentFilter = CIFilter.pixellate()
        
        currentFilter.inputImage = beginImage
        let amount = 4
        
        let inputKeys = currentFilter.inputKeys
        if inputKeys.contains(kCIInputScaleKey) { currentFilter.setValue(amount, forKey: kCIInputScaleKey)}
        if inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(amount * 10, forKey: kCIInputRadiusKey)}
        if inputKeys.contains(kCIInputIntensityKey) { currentFilter.setValue(amount / 2, forKey: kCIInputIntensityKey)}
        
        // Read output image from filter (CIImage) -> ?
        guard let outputImage = currentFilter.outputImage else { return }
        // Ask context to convert CGImage form output -> ?
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return }
        // CGImage to a UIImage then UIImage to SwiftUI Image
        let uiImage = UIImage(cgImage: cgImage)
        image = Image(uiImage: uiImage)
    }
}

#Preview {
    ContentView()
}
