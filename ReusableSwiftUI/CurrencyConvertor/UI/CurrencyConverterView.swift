//
//  ContentView.swift
//  ReusableSwiftUI
//
//  Created by Babul Raj on 06/09/23.
//

import SwiftUI

struct CurrencyConverterView: View {
    @ObservedObject var presenter = CurrencyConverterPresenter()
    @State private var selection:String = ""
    @State private var amount = ""

    var body: some View {
        if presenter.isLoading {
            ProgressView("fetching data")
        } else {
            VStack {
                Text(presenter.screenTitle).padding()
                VStack {
                    HStack {
                        VStack(alignment:.leading) {
                            CustomPicker(title: presenter.title, selection: $selection, items: presenter.itemsToConvert)
                                .frame(height: 100)
                                .cornerRadius(20)
                            HStack {
                                Text("\(presenter.subTitle):")
                                TextField("", text: $amount)
                                    .textFieldStyle(.roundedBorder)
                                    .keyboardType(.decimalPad)
                            }
                        }
                        .padding()
                        Button("Convert") {
                            presenter.convert(value: selection, amount: amount)
                        }
                        .background {
                            Color.secondary
                        }
                        .foregroundColor(.white)
                        .buttonStyle(.bordered)
                        .cornerRadius(10)
                    }.padding()
                }.errorAlert(error: $presenter.error)
                    .onAppear(perform: {
                        presenter.start(nil)
                    })
                    .background(presenter.backGroundColour)
                    .cornerRadius(10)
                Text("Value: \(presenter.convertedResult)")
                    
            }
        }
    }
}









