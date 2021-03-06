//
//  CurrencyManager.swift
//  CurrencyManager
//
//  Created by Jon Manning on 4/02/2015.
//  Copyright (c) 2015 Secret Lab. All rights reserved.
//

import UIKit

// BEGIN currency
class CurrencyManager {
    
    var gold : Int = 0
    
    var gems : Int {
        set(value) {
            // Set the updated count of gems in the user defaults system
            UserDefaults.standard.set(value, forKey: "gems")
        }
        
        get {
            // Ask the user defaults system for the current number of gems
            return UserDefaults.standard.integer(forKey: "gems")
        }
    }
    
    func endGame() {
        // When the game is over, reset gold but leave gems alone
        gold = 0
    }
   
}
// END currency

