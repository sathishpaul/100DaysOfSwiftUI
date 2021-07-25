//
//  ContentView.swift
//  UnitConverter
//
//  Created by Sathish Paul Leo on 7/24/21.
//

import SwiftUI

struct ContentView: View {
    let lengthUnits: [String: UnitLength] = [
        "meters": UnitLength.meters,
        "km": UnitLength.kilometers,
        "feet": UnitLength.feet,
        "yards": UnitLength.yards,
        "miles": UnitLength.miles
    ]
    let unitStrings: [String] = ["meters", "km", "feet", "yards", "miles"]
    @State private var inputValue = ""
    @State private var selectedInputUnit = 0
    @State private var selectedOutputUnit = 0
    
    var computedResult: Double {
        let inputValue = Measurement(value: Double(self.inputValue) ?? 0, unit: lengthUnits[unitStrings[selectedInputUnit]]!)
        return inputValue.converted(to: lengthUnits[unitStrings[selectedOutputUnit]]!).value
    }
    
    var body: some View {
        Form {
            Section {
                TextField("Value", text: $inputValue)
                    .keyboardType(.decimalPad)
            }
            
            
            Section(header: Text("Select input unit")) {
                Picker("Input unit", selection: $selectedInputUnit) {
                    ForEach(0 ..< unitStrings.count) {
                        Text("\(self.unitStrings[$0])")
                    }
                }.pickerStyle(SegmentedPickerStyle())
            }
            
            Section(header: Text("Select output unit")) {
                Picker("Output unit", selection: $selectedOutputUnit) {
                    ForEach(0 ..< unitStrings.count) {
                        Text("\(self.unitStrings[$0])")
                    }
                }.pickerStyle(SegmentedPickerStyle())
            }
            
            Section(header: Text("Converted result")) {
                Text("\(self.computedResult, specifier: "%.4f")")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
