//
//  Network.swift
//  NetworkLayer
//
//  Created by Q.M.S on 09/11/2021.
//

import Foundation
import UIKit

typealias NetworkManagerCompletion<E: EndpointProvider> = (NetworkResult<E.Response, E.Failure, NetworkError>)

protocol NetworkManager {
    func request<E: EndpointProvider>(_ request: E, completion: @escaping (NetworkManagerCompletion<E>) -> Void)
}

class Network {
    
    public static let shared: Network = .init()
    
    private lazy var imageDownloadManager: URLSession = {
        let config: URLSessionConfiguration = .default
        config.requestCachePolicy = .returnCacheDataElseLoad
        return URLSession(configuration: config, delegate: nil, delegateQueue: OperationQueue())
    }()
    
    /// To prevent network flooding
    private var downloadLimit: DispatchSemaphore = DispatchSemaphore(value: 2)
    
    public func request<E: EndpointProvider>(_ request: E, completion: @escaping (NetworkManagerCompletion<E>) -> Void) {
        
        let endpoint = request.endpoint
        let manager = URLSession(configuration: .default, delegate: nil, delegateQueue: .main)
        
        guard let urlRequest = try? endpoint.urlRequest() else {
            completion(.error(.requestCreation))
            return
        }
        print(urlRequest)
        let task = manager.dataTask(with: urlRequest) { data, response, error in
            var error = error
            if let response = response as? HTTPURLResponse,
                  !(200...299 ~= response.statusCode), /// check if status is between 200 to 299
                  error == nil {
                
                let message = "Bad Status: \(response.statusCode)"
                error = NSError(domain: URLError.errorDomain, code: URLError.badServerResponse.rawValue, userInfo: [NSLocalizedDescriptionKey: message])
            }
            if let error = error {
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let errorDto = try decoder.decode(E.Failure.self, from: data)
                        completion(.failure(errorDto))
                    } catch let exception {
                        completion(.error(.decoding(exception)))
                    }
                } else {
                    completion(.error(.server(error)))
                }
            } else if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let dto = try decoder.decode(E.Response.self, from: data)
                    completion(.success(dto))
                } catch let exception {
                    completion(.error(.decoding(exception)))
                }
            }
            
        }
        task.resume()
    }
    
    /// A convinience function to download an Image from a given URL using the default configuration
    public func downloadImage(from url: URL, completion: @escaping (UIImage?, Error?) -> Void) {
        DispatchQueue.global().async {
            let urlRequest = URLRequest(url: url)
            let task = self.imageDownloadManager.dataTask(with: urlRequest) { data, _, error in
                defer { self.downloadLimit.signal() }
                guard let data = data,
                      let image = UIImage(data: data) else {
                          return DispatchQueue.main.async { completion(nil, error) }
                }
                DispatchQueue.main.async { completion(image, nil) }
            }
            
            // Wait untill it is safe to make a request
            self.downloadLimit.wait()
            task.resume()
        }
    }
    
}
