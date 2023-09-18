//
//  Networking.swift
//  
//
//  Created by Tim Mitra on 9/17/23.
//

import Foundation

protocol NetworkSession {
    func get(from url: URL, completionHandler: @escaping (Data?, Error?) -> Void)
    func post(with request: URLRequest, completionHandler: @escaping (Data?, Error?) -> Void)
}

extension URLSession: NetworkSession {
    func post(with request: URLRequest, completionHandler: @escaping (Data?, Error?) -> Void) {
        let task = dataTask(with: request) { data, _, error in
            completionHandler(data, error)
        }
        task.resume()
    }
    
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
            
            /// Call to live internet to send data to a specific location
            /// - Warning: Make sure the URL can accept a POST route
            /// - Parameters:
            ///   - url: The location you want to send data to
            ///   - body: The object you wsih to send over the network
            ///   - completionHandler: Returns a result which signifies the status of the request
            public func sendData<I: Codable>(to url: URL, body: I, completionHandler: @escaping (NetworkResult<Data>) -> Void) {
                var request = URLRequest(url: url)
                do {
                    let httpBody = try JSONEncoder().encode(body)
                    request.httpBody = httpBody
                    request.httpMethod = "POST"
                    session.post(with: request) { data, error in
                        let result = data.map(NetworkResult<Data>.success) ?? .failure(error)
                        completionHandler(result)
                    }
                } catch {
                    return completionHandler(.failure(error))
                }
            }
        }
        public enum NetworkResult<Value> {
            case success(Value)
            case failure(Error?)
        }
    }
}
