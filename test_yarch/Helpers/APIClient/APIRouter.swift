//
//  APIRouter.swift
//  test_mvvm
//
//  Created by Евгений Котовщиков on 16/06/2019.
//  Copyright © 2019 Евгений Котовщиков. All rights reserved.
//

import Alamofire

enum APIRouter: URLRequestConvertible {
  
  case test(name: String, birthDate: String)
  
  // MARK: - HTTPMethod
  private var method: HTTPMethod {
    switch self {
    case .test:
      return .post
    }
  }
  
  private var path: String {
    switch self {
      
    case .test:
      return "/api/v1/test"
    }
  }
  
  // MARK: - Parameters
  var parameters: Parameters? {
    switch self {
    case .test(let name, let birthDate):
      return [
        "phone": name,
        "birthDate": birthDate
      ]
    }
  }
  
  // MARK: - URLRequestConvertible
  func asURLRequest() throws -> URLRequest {
    let url = URLBuilder().set(path: path).buildURL()!
    
    var urlRequest = URLRequest(url: url)
    urlRequest.timeoutInterval = 10
    
    // HTTP Method
    urlRequest.httpMethod = method.rawValue
    
    // Common Headers
    urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
    urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
    
    // Parameters
    if let parameters = parameters, method != .get {
      do {
        urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
      } catch {
        throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
      }
    } else {
      urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
    }
    
    return urlRequest
  }
}
