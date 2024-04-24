//
//  ContentView.swift
//  BetterRest
//
//  Created by Marco Capraro on 4/23/24.
//

import CoreML
import SwiftUI

struct SubHeadingStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .underline()
            .font(.headline.weight(.bold))
            .foregroundStyle(.pink)
    }
}

extension View {
    func subHeadingStyle() -> some View {
        modifier(SubHeadingStyle())
    }
}

struct ContentView: View {
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    @State private var wakeUp = defaultWakeTime
    
    // @State private var alertTitle = ""
    // @State private var alertMessage = ""
    // @State private var showAlert = false
    
    // Belongs to the struct not an instance, allows for it to be read at anytime (can be used for wakeUp)
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? .now
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Section {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("When do you want to wake up?")
                                .subHeadingStyle()
                            
                            DatePicker("Please Enter a Time:", selection: $wakeUp, displayedComponents: .hourAndMinute)
                                .labelsHidden()
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Desired amount of sleep")
                            .subHeadingStyle()

                        
                        Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                    }
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Daily coffee intake")
                            .subHeadingStyle()

                        Picker("^[\(coffeeAmount) cup](inflect: true)", selection: $coffeeAmount) {
                            ForEach(0..<20) { num in
                                Text("\(num)")
                            }
                        }
                    }
                }
                .scrollDisabled(true)
                .scrollContentBackground(.hidden)
                .background(.black)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        HStack {
                            Text("BetterRest")
                                .font(.title.weight(.heavy))
                                .foregroundStyle(.pink)
                                .accessibilityAddTraits(.isHeader)
                                .padding(.top, 50)
                            Image(systemName: "moon.zzz")
                                .font(.title2)
                                .foregroundStyle(.white)
                        }
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .bottomBar) {
                        VStack {
                            Image(systemName: "zzz")
                                .font(.title2)
                                .foregroundStyle(.white)
                            
                            Image(systemName: "bed.double.fill")
                                .font(.system(size: 25, weight: .bold))
                                .foregroundStyle(.white)
                            
                            
                            Text("Estimated Bedtime: \(calculateBedTime())")
                                .frame(maxWidth: .infinity)
                                .background(.black)
                                .foregroundStyle(.pink)
                                .clipShape(.rect(cornerRadius: 200))
                                .font(.system(size: 20, weight: .bold))
                                .padding()
                            
//                            Button("Calculate", action: calculateBedTime)
//                                .frame(maxWidth: 125, maxHeight: 100)
//                                .foregroundStyle(.pink)
//                                .background(.black)
//                                .clipShape(.rect(cornerRadius: 20))
                        }
                        .padding(.bottom, 200)
                    }
                }
//                .alert(alertTitle, isPresented: $showAlert) {
//                    Button("Ok") {}
//                }message: {
//                    Text(alertMessage)
//                }
                
                LinearGradient(colors: [.black, .pink], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                
            }
            .background(.black)
        }
    }
    
    func calculateBedTime() -> String {
        var bedTime: String
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            bedTime = sleepTime.formatted(date: .omitted, time: .shortened)
            
            // alertTitle = "Your ideal bedtime is..."
            // alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
            
        } catch {
            // error: something went wrong
            bedTime = "N/A"
            
            // alertTitle = "Error"
            // alertMessage = "Sorry, there was a problem calculating your bedtime"
        }
        
        // showAlert = true
        return bedTime
    }

}

#Preview {
    ContentView()
}
