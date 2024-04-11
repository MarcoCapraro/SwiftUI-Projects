/*
ContentView.swift
WeConvert

Created by Marco Capraro on 4/11/24.

WeConvert is an application that can handle unit conversions:
 
Temperature conversion: users choose Celsius, Fahrenheit, or Kelvin.
Length conversion: users choose meters, kilometers, feet, yards, or miles.
Time conversion: users choose seconds, minutes, hours, or days.
Volume conversion: users choose milliliters, liters, cups, pints, or gallons.
 
Ex: source unit = meters, output unit = feet, input = 10, output = 32.81
*/

import SwiftUI

struct ContentView: View {
    @State private var measurement = "Temperature"
    @State private var inputUnit = ""
    @State private var outputUnit = ""
    @State private var amount = 0.0
    
    let measurements = ["Temperature", "Length", "Time", "Volume"]
    let tempUnits = ["Celsius", "Farenheit", "Kelvin"]
    let lengthUnits = ["Meters", "Kilometers", "Feet", "Yards", "Miles"]
    let timeUnits = ["Seconds", "Minutes", "Hours", "Days"]
    let volumeUnits = ["Milliliters", "Liters", "Cups", "Pints", "Gallons"]
    
    var convertedValue: Double {
        var convertedOutput: Double = 0.0
        switch measurement {
        case "Temperature":
            convertedOutput = tempConversion(from: inputUnit, to: outputUnit)
        case "Length":
            convertedOutput = lengthConversion(from: inputUnit, to: outputUnit)
        case "Time":
            convertedOutput = timeConversion(from: inputUnit, to: outputUnit)
            break
        default:
            convertedOutput = volumeConversion(from: inputUnit, to: outputUnit)
            break
        }
        
        inputUnit = ""
        outputUnit = ""
        return convertedOutput
    }
    
    func tempConversion(from inputUnit: String, to outputUnit: String) -> Double {
        let originalValue: Double = amount
        var currentValue: Double = amount

        // Convert input to celsius
        if(inputUnit == "Farenheit") {
            currentValue = ((currentValue - 32)*5) / 9
        } else if(inputUnit == "Kelvin") {
            currentValue = currentValue - 273.15
        }
        
        // Convert to output from celsius
        if(outputUnit == "Farenheit") {
            currentValue = ((currentValue * 9)/5) + 32
        } else if(outputUnit == "Kelvin") {
            currentValue = currentValue + 273.15
        }
        
        if(inputUnit == "" || outputUnit == "") {
            currentValue = originalValue
        }
        
        return currentValue
    }
    
    func lengthConversion(from inputUnit: String, to outputUnit: String) -> Double {
        let originalValue: Double = amount
        var currentValue: Double = amount

        // Convert input to meters
        if(inputUnit == "Kilometers") {
            currentValue = currentValue * 1000
        } else if(inputUnit == "Feet") {
            currentValue = currentValue * 0.3048
        } else if(inputUnit == "Yards") {
            currentValue = currentValue * 0.9144
        } else if(inputUnit == "Miles") {
            currentValue = currentValue * 1609.344
        }
        
        // Convert to output from meters
        if(outputUnit == "Kilometers") {
            currentValue = currentValue / 1000
        } else if(outputUnit == "Feet") {
            currentValue = currentValue / 0.3048
        } else if(outputUnit == "Yards") {
            currentValue = currentValue / 0.9144
        } else if(outputUnit == "Miles") {
            currentValue = currentValue / 1609.344
        }
        
        if(inputUnit == "" || outputUnit == "") {
            currentValue = originalValue
        }
        
        return currentValue
    }
    
    func timeConversion(from inputUnit: String, to outputUnit: String) -> Double {
        let originalValue: Double = amount
        var currentValue: Double = amount

        // Convert input to seconds
        if(inputUnit == "Minutes") {
            currentValue = currentValue * 60
        } else if(inputUnit == "Hours") {
            currentValue = currentValue * 3600
        } else if(inputUnit == "Days") {
            currentValue = currentValue * 86400
        }
        
        // Convert to output from seconds
        if(outputUnit == "Minutes") {
            currentValue = currentValue / 60
        } else if(outputUnit == "Hours") {
            currentValue = currentValue / 3600
        } else if(outputUnit == "Days") {
            currentValue = currentValue / 86400
        }
        
        if(inputUnit == "" || outputUnit == "") {
            currentValue = originalValue
        }
        
        return currentValue
    }
    
    func volumeConversion(from inputUnit: String, to outputUnit: String) -> Double {
        let originalValue: Double = amount
        var currentValue: Double = amount

        // Convert input to milliliters
        if(inputUnit == "Liters") {
            currentValue = currentValue * 1000
        } else if(inputUnit == "Cups") {
            currentValue = currentValue * 236.588
        } else if(inputUnit == "Pints") {
            currentValue = currentValue * 473.176473
        } else if(inputUnit == "Gallons") {
            currentValue = currentValue * 3785.41
        }
        
        // Convert to output from milliliters
        if(outputUnit == "Liters") {
            currentValue = currentValue / 1000
        } else if(outputUnit == "Cups") {
            currentValue = currentValue / 236.588
        } else if(outputUnit == "Pints") {
            currentValue = currentValue / 473.176473
        } else if(outputUnit == "Gallons") {
            currentValue = currentValue / 3785.41
        }
        
        if(inputUnit == "" || outputUnit == "") {
            currentValue = originalValue
        }
        
        return currentValue
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Picker("Measurement:", selection: $measurement) {
                        ForEach(measurements, id: \.self) {
                            Text("\($0)")
                        }
                    }
                }
                
                Section("Input Unit -> Output Unit") {
                    switch measurement {
                    case "Temperature":
                        Picker("Input Unit:", selection: $inputUnit) {
                            ForEach(tempUnits, id: \.self) {
                                Text("\($0)")
                            }
                        }
                        .pickerStyle(.segmented)
                        Picker("Output Unit:", selection: $outputUnit) {
                            ForEach(tempUnits, id: \.self) {
                                Text("\($0)")
                            }
                        }
                        .pickerStyle(.segmented)
                    case "Length":
                        Picker("Input Unit:", selection: $inputUnit) {
                            ForEach(lengthUnits, id: \.self) {
                                Text("\($0)")
                            }
                        }
                        .pickerStyle(.segmented)
                        Picker("Output Unit:", selection: $outputUnit) {
                            ForEach(lengthUnits, id: \.self) {
                                Text("\($0)")
                            }
                        }
                        .pickerStyle(.segmented)
                    case "Time":
                        Picker("Input Unit:", selection: $inputUnit) {
                            ForEach(timeUnits, id: \.self) {
                                Text("\($0)")
                            }
                        }
                        .pickerStyle(.segmented)
                        Picker("Output Unit:", selection: $outputUnit) {
                            ForEach(timeUnits, id: \.self) {
                                Text("\($0)")
                            }
                        }
                        .pickerStyle(.segmented)
                    default:
                        Picker("Input Unit:", selection: $inputUnit) {
                            ForEach(volumeUnits, id: \.self) {
                                Text("\($0)")
                            }
                        }
                        .pickerStyle(.segmented)
                        Picker("Output Unit:", selection: $outputUnit) {
                            ForEach(volumeUnits, id: \.self) {
                                Text("\($0)")
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                }
                
                Section("Enter a value") {
                    TextField("Amount", value: $amount, format: .number)
                }
                
                Section("Converted Value") {
                    Text("\(convertedValue.formatted())")
                }
                
            }
            .navigationTitle("WeConvert")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ContentView()
}
