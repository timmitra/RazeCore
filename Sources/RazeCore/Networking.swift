//
//  Networking.swift
//  
//
//  Created by Tim Mitra on 9/17/23.
//

import Foundation

extension RazeCore {
    
    public class Networking {
        
        /// Responsible for all networking calls
        /// - Warning: Must be created beofre any public APIs
        public class Manager {
            public init() {}
            
            private let session = URLSession.shared
            
            public func loadData(from url: URL, completionHandler: @escaping(NetworkResult<Data>) -> Void) {
                let task = session.dataTask(with: url) { data, response, error in
                    // does data variable passed in to the closure,
                    // properly identify as a data object in NetworkResult
                    // otherwise return an error
                    let result = data.map(NetworkResult<Data>.success) ?? .failure(error)
                    // pass the result into the completionHander and let dev to the rest
                    completionHandler(result)
                }
                task.resume()
            }
        }
        public enum NetworkResult<Value> {
            case success(Value)
            case failure(Error?)
        }
    }
}
