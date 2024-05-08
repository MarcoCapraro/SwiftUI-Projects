//
//  ContentView.swift
//  iExpense
//
//  Created by Marco Capraro on 5/8/24.
//

import Observation
import SwiftUI

@Observable
class User {
    var firstName = "Marco"
    var lastName = "Capraro"
}

struct ContentView: View {
    @State private var user = User()
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            VStack {
                Image(systemName: "15.circle")
                    .font(.largeTitle)
                    .background(.white)
                
                VStack {
                    Text("Your name is \(user.firstName) \(user.lastName)")
                    TextField("First Name", text: $user.firstName)
                    TextField("Last Name", text: $user.lastName)
                }
                .background(.white)
            }
        }
    }
}

#Preview {
    ContentView()
}
