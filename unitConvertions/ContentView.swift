//
//  ContentView.swift
//  unitConvertions
//
//  Created by Beto Toro on 28/06/22.
//

import SwiftUI

struct ContentView: View {

  @State var inputValue = 0.0
  @State var selectedUnits = 0
  @State var inputUnit: Dimension = UnitTemperature.celsius
  @State var outputUnit: Dimension = UnitTemperature.fahrenheit
  @FocusState private var inputValueIsFocused: Bool
  
  let conversions = ["Distance", "Mass", "Temperature", "Time"]
  let unitTypes = [
      [UnitLength.meters, UnitLength.kilometers, UnitLength.feet, UnitLength.yards, UnitLength.miles],
      [UnitMass.grams, UnitMass.kilograms, UnitMass.ounces, UnitMass.pounds],
      [UnitTemperature.celsius, UnitTemperature.fahrenheit, UnitTemperature.kelvin],
      [UnitDuration.hours, UnitDuration.minutes, UnitDuration.seconds]
  ]
  
  let unitList: [UnitTemperature] = [.celsius, .fahrenheit, .kelvin]
  let formater: MeasurementFormatter
  
  var totalValue: String {
    
    let inputMeasurement = Measurement(value: inputValue, unit: inputUnit)
    let outputMeasurement = inputMeasurement.converted(to: outputUnit)
    
    return formater.string(from: outputMeasurement)
    
  }
  
  var body: some View {
    
    NavigationView {
      Form {
        
        
        Section {
          TextField("Value", value: $inputValue, format: .number)
            .keyboardType(.decimalPad)
            .focused($inputValueIsFocused)
        } header: {
          Text("Amount to convert")
        }
        
        Section {
          Picker("Conversion", selection: $selectedUnits) {
              ForEach(0..<conversions.count) {
                  Text(conversions[$0])
              }
          }

          Picker("Convert from", selection: $inputUnit) {
              ForEach(unitTypes[selectedUnits], id: \.self) {
                  Text(formater.string(from: $0).capitalized)
              }
          }

          Picker("Convert to", selection: $outputUnit) {
              ForEach(unitTypes[selectedUnits], id: \.self) {
                  Text(formater.string(from: $0).capitalized)
              }
          }
        }
        
        Section {
          Text(totalValue)
        } header: {
          Text("Total value")
        }
        
        
      }
      .navigationTitle("Converter")
      .toolbar {
         ToolbarItemGroup(placement: .keyboard) {
           Spacer()
         
           Button("Done") {
             inputValueIsFocused = false
           }
         }
       }
      .onChange(of: selectedUnits) { newSelection in
          let units = unitTypes[newSelection]
          inputUnit = units[0]
          outputUnit = units[1]
      }
    }
  }
  
  init() {
    formater = MeasurementFormatter()
    formater.unitOptions = .providedUnit
    formater.unitStyle = .long
  }
  
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
