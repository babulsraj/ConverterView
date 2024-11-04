//
//  ConverterView.swift
//  ReusableSwiftUI
//
//  Created by Babul Raj on 06/09/23.
//

import SwiftUI

public struct ConverterViewModel {
    var title: String
    var subTitle: String
    var itemsToConvert:[String]
    var convertedResult:String
}

protocol ConverterViewDataProvider:ObservableObject {
    func start(_ completion:((Bool)->())?)
    func convert(value:String?,amount:String)
    var convertItemModel:ConverterViewModel {get}
    var isLoading: Bool {get}
    var error: Error?{get set}
    var screenTitle: String{get set}
    var backGroundColour: Color {get set}
}

struct ConverterView<T:ConverterViewDataProvider>: View where T: ObservableObject {
    @ObservedObject var presenter: T
    @State private var selection:String = ""
    @State private var amount = ""
    @FocusState private var amountIsFocused: Bool
    
    var body: some View {
        if presenter.isLoading {
            ProgressView("fetching data")
        } else {
            VStack {
                Text(presenter.screenTitle).padding()
                VStack {
                    HStack {
                        VStack(alignment:.leading) {
                            CustomPicker(title: presenter.convertItemModel.title, selection: $selection, items: presenter.convertItemModel.itemsToConvert)
                                .frame(height: 100)
                                .cornerRadius(20)
                            HStack {
                                Text("\(presenter.convertItemModel.subTitle):")
                                    .foregroundColor(.black )
                                    .font(.subheadline)
                                TextField("", text: $amount)
                                    .focused($amountIsFocused)
                                    .textFieldStyle(.roundedBorder)
                                    .keyboardType(.decimalPad)
                            }
                        }
                        .padding()
                        
                        Spacer()
                        Button("Convert") {
                            amountIsFocused = false
                            presenter.convert(value: selection, amount: amount)
                        }.background {
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
                
                Text("value: \(presenter.convertItemModel.convertedResult)")
            }
        }
    }
}

