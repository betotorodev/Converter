//
//  ContentView.swift
//  unitConvertions
//
//  Created by Beto Toro on 28/06/22.
//

import SwiftUI

struct ContentView: View {

  @State var inputValue = 0.0
  @State var inputUnit = UnitTemperature.celsius
  @State var outputUnit = UnitTemperature.fahrenheit
  @FocusState private var inputValueIsFocused: Bool
  
  var unitList: [UnitTemperature] = [.celsius, .fahrenheit, .kelvin]
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
          Picker("From", selection: $inputUnit) {
            ForEach(unitList, id: \.self) { unit in
              Text(formater.string(from: unit).capitalized)
            }
          }
          .pickerStyle(.automatic)
        } header: {
          Text("Choose your unit input")
        }
        
        Section {
          Picker("To", selection: $outputUnit) {
            ForEach(unitList, id: \.self) { unit in
              Text(formater.string(from: unit).capitalized)
            }
          }
          .pickerStyle(.automatic)
        } header: {
          Text("Choose your unit output")
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
