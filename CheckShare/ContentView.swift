//
//  ContentView.swift
//  CheckShare
//
//  Created by Narayanan V Muthuswamy on 10/24/20.
//

import SwiftUI

struct ContentView: View {
    @State private var billAmountDisplay = ""
    @State private var totalPersonsDisplay = ""
    @State private var selectedTipPercentage = 2

    private var totalPersons: Double {
        return (Double(totalPersonsDisplay) ?? 1)
    }

    let tipPercentages = [0, 10, 15, 20, 25]

    var billAmount: Double {
        return Double(billAmountDisplay) ?? 0
    }

    var tipAmount: Double {
        guard selectedTipPercentage < tipPercentages.count else { return 0 }
        return (billAmount * Double(tipPercentages[selectedTipPercentage])) / 100
    }

    var totalBillAmount: Double {
        return billAmount + tipAmount
    }

    var totalPerPerson: Double {
        guard totalPersons > 0 else { return totalBillAmount }
        return totalBillAmount / totalPersons
    }

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Enter Check Amount", text: $billAmountDisplay)
                        .keyboardType(.decimalPad)

//                    Picker("Number of people", selection: $totalPersons) {
//                        ForEach(2 ..< 21) {
//                            Text("\($0) people")
//                        }
//                    }
                    TextField("Number of people", text: $totalPersonsDisplay)
                        .keyboardType(.numberPad)
                }

                Section(header: Text("Tip Percentage")) {
                    Picker("Tip Percentage", selection: $selectedTipPercentage) {
                        ForEach(0 ..< tipPercentages.count) {
                            Text("\(tipPercentages[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }

                Section(header: Text("Totals")) {
                    HStack{
                        Text("Amount")
                        Spacer()
                        Text("$\(totalBillAmount, specifier: "%.2f")")
                    }

                    HStack{
                        Text("Share")
                        Spacer()
                        Text("$\(totalPerPerson, specifier: "%.2f")")
                    }
                }
            }
            .navigationBarTitle("Check Share")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
