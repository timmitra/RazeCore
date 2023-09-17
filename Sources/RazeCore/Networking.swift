//
//  Networking.swift
//  
//
//  Created by Tim Mitra on 9/17/23.
//

import Foundation

protocol NetworkSession {
    func get(from url: URL, completionHandler: @escaping (Data?, Error?) -> Void)
}

extension URLSession: NetworkSession {
    func get(from url: URL, completionHandler: @escaping (Data?, Error?) -> Void) {
        let task = dataTask(with: url) { data, _, error in
            completionHandler(data, error)
        }
        task.resume()
    }
}

extension RazeCore {
    
    public class Networking {
        
        /// Responsible for all networking calls
        /// - Warning: Must be created beofre any public APIs
        public class Manager {
            public init() {}
            
            internal var session: NetworkSession = URLSession.shared
            
            /// Call to live internet to retrieve Data from a specific location
            /// - Parameters:
            ///   - url: The location to get the data from
            ///   - completionHandler: Returns a result which signifies the status of the request
            public func loadData(from url: URL, completionHandler: @escaping(NetworkResult<Data>) -> Void) {
                session.get(from: url) { data, error in
                    // does data variable passed in to the closure,
                    // properly identify as a data object in NetworkResult
                    // otherwise return an error
                    let result = data.map(NetworkResult<Data>.success) ?? .failure(error)
                    // pass the result into the completionHander and let dev to the rest
                    completionHandler(result)
                }
            }
        }
        public enum NetworkResult<Value> {
            case success(Value)
            case failure(Error?)
        }
    }
}
