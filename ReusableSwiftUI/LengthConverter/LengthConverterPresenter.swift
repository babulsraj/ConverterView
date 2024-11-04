//
//  LengthConverterPresenter.swift
//  ReusableSwiftUI
//
//  Created by Babul Raj on 06/09/23.
//

import Foundation
import SwiftUI

class LengthConverterPresenter:ObservableObject, ConverterViewDataProvider {
   @Published var convertItemModel: ConverterViewModel = 
    ConverterViewModel(title: "select Unit", subTitle: "enter length", 
                       itemsToConvert: [], convertedResult: "")
    @Published  var isLoading: Bool = false
    @Published var error: Error? = nil
    var screenTitle: String = "Convert to KM"
    var backGroundColour: Color = .red

    func start(_ completion: ((Bool) -> ())?) {
        self.convertItemModel.itemsToConvert = ["cm","m","km"]
    }
    
    func convert(value: String?, amount: String) {
        if let intVal = Int(amount) {
            self.convertItemModel.convertedResult = "\(intVal/1000)"
        }
    }
}
