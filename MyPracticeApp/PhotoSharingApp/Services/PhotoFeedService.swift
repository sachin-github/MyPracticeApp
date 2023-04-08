//
//  PhotoFeedService.swift
//  MyPracticeApp
//
//  Created by Sachin Srivastava on 10/03/23.
//

import Combine

protocol PhotoFeedService {
    
    func fetchFeed() -> AnyPublisher<[FeedData]?, Never>
}

class PhotoFeedServiceImpl: PhotoFeedService {
    
    private let feedRepo: PhotoSharingRepo
    
    init(feedRepo: PhotoSharingRepo = PhotoSharingDependencyResolver.makeRepo()) {
        self.feedRepo = feedRepo
    }
    
    func fetchFeed() -> AnyPublisher<[FeedData]?, Never> {
        
        let num1 = "20"
        let num2 = "30"
        print(">>> Test run: \(Solution().multiply(num1, num2))")
        
        return feedRepo.fetchFeed()
            .catch { _ in Empty(completeImmediately: false) }
            .map{ $0 }
            .eraseToAnyPublisher()
    }
}

class Solution {
    func multiply(_ num1: String, _ num2: String) -> String {
        let arr1 = Array(num1)
        let arr2 = Array(num2)
        
        var result = [Int](repeating: 0, count: arr1.count + arr2.count)
        var subResultOffset = 0
        
        for i in stride(from: arr1.count-1, through: 0, by: -1) {
            let multiplier: Int = Int(String(arr1[i])) ?? 0
            var carryBit = 0
            var subResult = [Int](repeating: 0, count: arr1.count + arr2.count)
            var subResultIndex = subResult.count - 1 - subResultOffset
            
            for j in stride(from: arr2.count-1, through: 0, by: -1) {
                let currNum: Int = Int(String(arr2[j])) ?? 0
                
                let product = carryBit + (currNum * multiplier)
                let productBit = product % 10
                carryBit = product / 10
                
                subResult[subResultIndex] = productBit
                subResultIndex -= 1
            }
            
            subResult[subResultIndex] = carryBit
            addArrays(result: &result, subResult: subResult, minSubResultIndex: subResultIndex)
            
            subResultOffset += 1
        }
        
        let stringResult = result.map { String($0) }.joined()
        return stringResult
    }
    
    private func addArrays(result: inout [Int], subResult: [Int], minSubResultIndex: Int) {
        var resultIndex = result.count - 1
        var subResultIndex = subResult.count - 1
        var carryBit = 0
        
        while subResultIndex >= minSubResultIndex {
            let resultBit = result[resultIndex]
            let subResultBit = subResult[subResultIndex]
            let sum = resultBit + subResultBit + carryBit
            let sumBit = sum % 10
            carryBit = sum / 10
            result[resultIndex] = sumBit
            
            resultIndex -= 1
            subResultIndex -= 1
        }
        
        while carryBit > 0 {
            let resultBit = result[resultIndex]
            let sum = resultBit + carryBit
            let sumBit = sum % 10
            carryBit = sum / 10
            result[resultIndex] = sumBit
            
            resultIndex -= 1
        }
    }
}
