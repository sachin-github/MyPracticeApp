//
//  FlagsCache.swift
//  MyPracticeApp
//
//  Created by Sachin Srivastava on 17/03/23.
//

import Foundation

struct FlagDO {
    var id: String
    var value: String
    var lastSynced: Date
}

final class FlagsCache {
    
    
    private let queue = DispatchQueue(label: "flagsQueue", attributes: .concurrent)
    private var cachedData: [String: FlagDO] = [:]
    
    static let shared = FlagsCache()
    
    func valueFor(flag: String) -> String? {
        return queue.sync {
            cachedData[flag]?.value
        }
    }
    
    func load(flags: [String : FlagDO]) {
        queue.async(flags: .barrier) { [weak self] in
            guard let self = self else { return }
            self.cachedData = flags
        }
    }
    
    func addFlag(_ flag: String, value: String) {
        queue.async(flags: .barrier) { [weak self] in
            guard let self = self else { return }
            let newFlag = FlagDO(id: flag, value: value, lastSynced: Date())
            self.cachedData[flag] = newFlag
        }
    }
    
    func updateFlag(_ flag: String, value: String) {
        addFlag(flag, value: value)
    }
    
}
