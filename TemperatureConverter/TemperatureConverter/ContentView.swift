//
//  ContentView.swift
//  TemperatureConverter
//
//  Created by Harsh Pailkar on 21/10/22.
//

import SwiftUI

struct ContentView: View {
    @State private var tempValue = 0.0
    @State private var tempFromScale = "C"
    @State private var tempToScale = "F"
    @FocusState private var tempIsFocused: Bool
    
    let tempScales = ["C", "F", "K"]
    
    
    var tempConverted: Double{
        var convertedValue = 0.0
        
        if tempFromScale == "C"{
            if tempToScale == "F"{
                convertedValue = (tempValue * 1.8) + 32
            }
            else if tempToScale == "K"{
                convertedValue = tempValue + 273.15
            }
            else {
                convertedValue = tempValue
            }
        }
        
        else if tempFromScale == "F"{
            if tempToScale == "C"{
                convertedValue = ((tempValue - 32) * 5)/9
            }
            else if tempToScale == "K"{
                convertedValue = (((tempValue - 32) * 5)/9) + 273.15
            }
            else {
                convertedValue = tempValue
            }
        }
        else{
            if tempToScale == "C"{
                convertedValue = tempValue - 273.15
                
            }
            else if tempToScale == "F"{
                convertedValue = ((tempValue - 273.15) * 1.8) + 32
                
            }
            else {
                convertedValue = tempValue
            }
        }
        
        return convertedValue
    }
    
    var body: some View {
        NavigationView{
            Form{
                Section{
                    TextField("Temperature", value: $tempValue, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($tempIsFocused)
                } header: {
                    Text("Temperature Value")
                }
                
                Section{
                    
                    Picker("FromTemp", selection: $tempFromScale){
                        ForEach(tempScales, id:\.self){
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                } header: {
                    Text("Convert From Scale")
                }
                
                Section{
                    
                    Picker("ToTemp", selection: $tempToScale){
                        ForEach(tempScales, id:\.self){
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                } header: {
                    Text("Convert To Scale")
                }
                
                Section{
                    Text(tempConverted, format: .number)
                }
                
            }
            .navigationTitle("TempCon")
            .toolbar{
                ToolbarItemGroup(placement: .keyboard){
                    Spacer()
                    
                    Button("Done"){
                        tempIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
