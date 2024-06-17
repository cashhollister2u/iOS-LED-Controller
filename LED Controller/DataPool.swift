//
//  DataPool.swift
//  LED Controller
//
//  Created by Cash Hollister on 6/16/24.
//

import SwiftUI
import Combine

class DataModel: ObservableObject {
    @Published var stockSymbol: String
    @Published var zipCode: String
    
    init() {
        // Initialize with values from UserDefaults or provide default values
        self.stockSymbol = UserDefaults.standard.string(forKey: "stock_symbol") ?? "VOO"
        self.zipCode = UserDefaults.standard.string(forKey: "zip_code") ?? "10019"
    }
    
    // Method to update UserDefaults if values change
    func saveDefaults() {
        UserDefaults.standard.set(stockSymbol, forKey: "stock_symbol")
        UserDefaults.standard.set(zipCode, forKey: "zip_code")
    }
}
