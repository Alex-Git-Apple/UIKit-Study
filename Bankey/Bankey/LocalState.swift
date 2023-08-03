//
//  LocalState.swift
//  Bankey
//
//  Created by Pin Lu on 8/5/23.
//

import Foundation

public class LocalState {
    
    private enum keys: String {
        case hasOnboarded
    }
    
    public static var hasOnboarded: Bool {
        get {
            UserDefaults.standard.bool(forKey: keys.hasOnboarded.rawValue)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: keys.hasOnboarded.rawValue)
        }
    }
}
