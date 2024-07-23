//
//  ShareLinkView.swift
//  InstaFilter
//
//  Created by Marco Capraro on 7/23/24.
//

import SwiftUI

struct ShareLinkView: View {
    let example = Image(.example)
    
    var body: some View {
        
        VStack(spacing:  50) {
            ShareLink(item: URL(string: "https://www.hackingwithswift.com")!) {
                Label("Spread the word about Swift", systemImage: "swift")
            }
            
            ShareLink(item: example, preview: SharePreview("The Moon ", image: example)) {
                Label("Click to share the moon", systemImage: "swift")
            }
        }
    }
}

#Preview {
    ShareLinkView()
}
