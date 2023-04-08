//
//  NetworkService.swift
//  MyPracticeApp
//
//  Created by Sachin Srivastava on 08/03/23.
//

import Combine
import Foundation

enum NetworkError: Error {
    
    case unknown
    
    case invalidUrl
    
    case fetchFailed
}

protocol NetworkService {
    
    func fetch(url: String) -> AnyPublisher<Data, NetworkError>
}

struct NetworkServiceImp: NetworkService {
    
    func fetch(url: String) -> AnyPublisher<Data, NetworkError> {
        guard let fetchUrl = URL(string: url) else {
            return Fail(error: NetworkError.invalidUrl).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: fetchUrl)
            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.global(qos: .background))
            .delay(for: .milliseconds(500), scheduler: DispatchQueue.global(qos: .background))
            .map { $0.data }
            .mapError { _ in NetworkError.fetchFailed }
            .eraseToAnyPublisher()
    }
}
