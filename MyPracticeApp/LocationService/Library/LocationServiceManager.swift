//
//  LocationServiceManager.swift
//  MyPracticeApp
//
//  Created by Sachin Srivastava on 14/03/23.
//

import CoreLocation
import Foundation

public enum LocationServiceConsumer: Int {
    
    case rider
    case driver
    case driverOnTrip
}

public typealias LocationData = CLLocation

public protocol LocationServiceManager {
    
//    func setDelegate(_ delegate: LocationServiceSearchResult)
    
    func searchLocation(consumer: LocationServiceConsumer)
}

public protocol LocationServiceSearchResult {
    
    func handleSearchResult(location: LocationData)
}

public class LocationServiceManagerImpl: LocationServiceManager {
    
//    private var delegate: LocationServiceSearchResult?
    
//    public func setDelegate(_ delegate: LocationServiceSearchResult) {
//        self.delegate = delegate
//    }
    
    public func searchLocation(consumer: LocationServiceConsumer) {
        
    }
}
