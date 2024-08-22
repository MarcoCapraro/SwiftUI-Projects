//
//  ContentView.swift
//  BucketList
//
//  Created by Marco Capraro on 7/29/24.
//

import MapKit
import SwiftUI

struct ContentView: View {
    @Environment(\.dismiss) var dismiss
    @State private var viewModel = ViewModel()
    
    let startPosition = MapCameraPosition.region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 56, longitude: -3), span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)))
    
    var body: some View {
        if viewModel.isUnlocked {
            ZStack {
                MapReader { proxy in
                    Map(initialPosition: startPosition) {
                        ForEach(viewModel.locations) { location in
                            Annotation(location.name, coordinate: location.coordinate) {
                                Image(systemName: "star.circle")
                                    .resizable()
                                    .foregroundStyle(.red)
                                    .frame(width: 44, height: 44)
                                    .background(.white)
                                    .clipShape(.circle)
                                    .onLongPressGesture {
                                        viewModel.selectedPlace = location
                                    }
                            }
                        }
                    }
                    .mapStyle(viewModel.isHybrid ? .hybrid : .standard)
                    .onTapGesture { position in
                        if let coordinate = proxy.convert(position, from: .local) {
                            viewModel.addLocation(at: coordinate)
                        }
                    }
                    .sheet(item: $viewModel.selectedPlace) { place in
                        EditView(location: place) {
                            viewModel.updateLocation(location: $0)
                        }
                    }
                }
                
                VStack {
                    Spacer()
                    
                    HStack {
                        Spacer()
                        Toggle("Hybrid View", isOn: $viewModel.isHybrid)
                            .frame(maxWidth: 200)
                            .padding()
                            .background(.black)
                            .foregroundStyle(.white)
                            .clipShape(.capsule)
                        Spacer()
                    }
                    .padding()
                }
            }
        } else {
            Button("Unlock Places", action: viewModel.authenticate)
                .padding()
                .background(.blue)
                .foregroundStyle(.white)
                .clipShape(.capsule)
                .alert(isPresented: $viewModel.showAlert) {
                    Alert(title: Text("Face ID Biometrics Error"), message: Text("Try Enrolling"),
                          primaryButton: .destructive(Text("Cancel")) { dismiss()},
                          secondaryButton: .default(Text("Ok")) { dismiss()}
                    )
                }
        }
    }
}


#Preview {
    ContentView()
}
