//
//  NetworkCallRecorder.swift
//  MyPracticeApp
//
//  Created by Sachin Srivastava on 14/03/23.
//

import Foundation

class NetworkCallRecorder {
    
    private static var callCounter = 0
    private static let queueName = "networkCallRecorderQueue"
    private static let queue = DispatchQueue(label: queueName)
    
    static func newCallRequest() {
        queue.sync {
            callCounter += 1
            print("New network call placed. Total active calls: \(callCounter)")
        }
    }
    
    static func closeExistingCallRequest() {
        queue.sync {
            callCounter -= 1
            print("Existing network call closed. Total active calls: \(callCounter)")
        }
    }
}
