//
//  StorageKey.swift
//  au.com.weatherapp
//
//  Created by Nishant Gupta on 28/4/21.
//

import Foundation

public struct StorageKey: RawRepresentable, Equatable, Hashable {
    public var rawValue: String
    public var accessControl: Access
    
    public init(rawValue: String, accessControl: Access) {
        self.rawValue = rawValue
        self.accessControl = accessControl
    }
    
    public init(rawValue: String) {
        self.init(rawValue: rawValue, accessControl: .SharedDefault)
    }
}


public enum Access {
    case SharedDefault
}
