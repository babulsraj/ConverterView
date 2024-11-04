//
//  CurrencyConverterPresenter.swift
//  ReusableSwiftUI
//
//  Created by Babul Raj on 06/09/23.
//

import Foundation
import SwiftUI

class CurrencyConverterPresenter:ObservableObject {
    
    @Published var isLoading:Bool = false
    @Published var itemsToConvert:[String] = []
    @Published var error:Error? = nil
    @Published var convertedResult: String = ""
    
    var title:String = "Convert"
    var subTitle:String = "Quantity"
    var backGroundColour: Color = .yellow
    var screenTitle = "Convert to Dollar"
    
    func start(_ completion:((Bool)->())?) {
        // make API call and get items  to convert
        self.itemsToConvert = ["Rupees","Pound", "Euro","Yen"]
    }
    
    func convert(value: String?, amount: String) {
        if let _ = value, let intVal = Int(amount) {
            let resultVal = intVal * 80
            convertedResult = "\(resultVal)"
        }
    }
}
