//
//  FeatureFlagService.swift
//  MyPracticeApp
//
//  Created by Sachin Srivastava on 17/03/23.
//

import Foundation

public protocol FeatureFlagService {
    
    func loadAllFlags()
    
    func refresh(flag: String)
    
    func boolValueFor(flag: String) -> Bool
    
    func intValueFor(flag: String) -> Int
    
    func stringValueFor(flag: String) -> String
}

public final class FeatureFlagServiceImpl: FeatureFlagService {
    
    public func loadAllFlags() {
        
    }
    
    public func refresh(flag: String) {
        
    }
    
    public func boolValueFor(flag: String) -> Bool {
        guard let stringValue = FlagsCache.shared.valueFor(flag: flag),
              let boolValue = Bool(stringValue) else {
            return false
        }
        
        return boolValue
    }
    
    public func intValueFor(flag: String) -> Int {
        guard let stringValue = FlagsCache.shared.valueFor(flag: flag),
              let intValue = Int(stringValue) else {
            return 0
        }
        
        return intValue
    }
    
    public func stringValueFor(flag: String) -> String {
        guard let stringValue = FlagsCache.shared.valueFor(flag: flag) else {
            return ""
        }
        
        return stringValue
    }
    
}
