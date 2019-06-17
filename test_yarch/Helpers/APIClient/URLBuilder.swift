//
//  URLBuilder.swift
//  test_mvvm
//
//  Created by Евгений Котовщиков on 16/06/2019.
//  Copyright © 2019 Евгений Котовщиков. All rights reserved.
//

import Foundation

class URLBuilder {
  var components = URLComponents()
  var path = ""
  
  init() {
    components.scheme = "http"
    components.percentEncodedHost = "test.com"
  }
  
  func set(scheme: String) -> URLBuilder {
    components.scheme = scheme
    
    return self
  }
  
  func set(host: String) -> URLBuilder {
    components.percentEncodedHost = host
    
    return self
  }
  
  func set(path: String) -> URLBuilder {
    self.path = path
    components.path = self.path
    
    return self
  }
  
  func add(path: String) -> URLBuilder {
    self.path.append(path)
    components.path = self.path
    
    return self
  }
  
  func buildURL() -> URL? {
    return components.url
  }
  
  func buildString() -> String {
    guard let string = components.string else { return "" }
    return string
  }
}
