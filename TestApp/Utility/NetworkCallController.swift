//
//  NetworkCallController.swift
//  ImageLoadingDemo
//
//  Created by Vanita on 10/25/17.
//  Copyright © 2017 Tixdo. All rights reserved.
//

import Foundation

/// the type for received response
enum ResponseType {
    case success
    case failure
    case failedToConnect
    case requestTimedOut
}

///specifies the type of request ot http method type
enum HTTPMethodType: String {
    case GET
    case POST
    case PATCH
    case PUT
    case DELETE
}

/// the custom response structure for storing the response data, code and custom response type
struct Response {
    var responseType: ResponseType?
    var responseCode: Int?
    var data: Data?
}

typealias NetWorkCallManagerCompletionHandler = (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void

class NetworkCallManager {
    /**
    this will fire request
    - Parameter request: the url in string format
    - Parameter httpMethod: the type of http method e.g get, post etc. Default get
    - Parameter headers: the optional header fields if no header available either skip the value or send nil. Default nil
     - Parameter parameters: the optional parameters, if any. if no parameter, either skip or send nil. Default nil
    - Returns: void
    
    */
    public func request(request: String,
                httpMethod:HTTPMethodType = .GET,
                 headers: [String: Any]? = nil,
                 parameters: [String: Any]? = nil,
                 netWorkCallManagerCompletionHandler: @escaping NetWorkCallManagerCompletionHandler) {
        guard let url = URL.init(string: request) else {
            return
        }
        let urlRequest = NSMutableURLRequest(url: url)
        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest.configureParameters(parameters: parameters, for: httpMethod)
        // set up the session
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        // make the request
        let task = session.dataTask(with: urlRequest as URLRequest, completionHandler: { (data, response, error) in
            // do stuff with response, data & error here
            netWorkCallManagerCompletionHandler(data, response, error)
        })
        task.resume()
    }
    
    
}

extension NSMutableURLRequest {
    fileprivate func configureParameters(parameters:[String: Any?]?, for httpMethod: HTTPMethodType) {
        guard let parameters = parameters else {
            return
        }
        switch httpMethod {
        case .GET:
            var inlineParameters = "?"
            var index = 0
            for (key, value) in parameters.reversed() {
                if index == 0 {
                    inlineParameters = inlineParameters + "\(key)=\(String(describing: value!))"
                    index += 1
                } else {
                    inlineParameters = inlineParameters + "&\(key)=\(String(describing: value!))"
                }
            }
            let newUrl = (self.url?.absoluteString)! + inlineParameters.trimmingCharacters(in: CharacterSet.init(charactersIn: "&"))
            
            self.url = URL.init(string: newUrl)
            break
        case .POST:
            break
        default:
            break
        }
    }
}


