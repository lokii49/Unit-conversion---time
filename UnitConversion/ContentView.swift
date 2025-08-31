//
//  ContentView.swift
//  UnitConversion
//
//  Created by Lokesh Pudari on 31/08/25.
//

import SwiftUI

struct ContentView: View {
    @State private var inputValue = 0
    @State private var inputUnit = "mins"
    @State private var outputUnit = "sec"
    @FocusState private var inputValueSelected: Bool
    
    var timeUnits = ["days","hours", "mins", "sec"]
    
    var inputInSec: Double {
        var result = 0.0
        let input = Double(inputValue)
        switch inputUnit {
        case "days":
            result = ((input * 60.0) * 60.0) * 24.0
        case "hours":
            result = (input * 60.0) * 60.0
        case "mins":
            result = input * 60.0
        default:
            result = input
        }
        return result
    }
    
    var outputValue: Double {
        var result = 0.0
        switch outputUnit {
        case "days":
            result = ((inputInSec/24.0)/60.0)/60.0
        case "hours":
            result = ((inputInSec)/60.0)/60.0
        case "mins":
            result = (inputInSec)/60.0
        default:
            result = inputInSec
        }
        return result
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Input Units") {
                    Picker("units", selection: $inputUnit) {
                        ForEach(timeUnits, id: \.self){
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Input Value") {
                    TextField("input value", value: $inputValue, format: .number)
                }
                .keyboardType(.numberPad)
                .focused($inputValueSelected)
                
                Section("Output Units") {
                    Picker("outputUnits", selection: $outputUnit) {
                        ForEach(timeUnits, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Output Value") {
                    Text(outputValue, format: .number)
                }
                
            }
            .navigationTitle("Time Conversion")
            .toolbar {
                if inputValueSelected {
                    Button("Done") {
                        inputValueSelected = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
