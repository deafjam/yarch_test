//
//  APIClient.swift
//  test_mvvm
//
//  Created by Евгений Котовщиков on 16/06/2019.
//  Copyright © 2019 Евгений Котовщиков. All rights reserved.
//

import Alamofire

//enum Result<T> {
//  case success(T)
//  case failure(APIErrorModel)
//}

class APIClient {
  private static func performRequest<T: Decodable>(route: APIRouter,
                                                   decoder: JSONDecoder = JSONDecoder(),
                                                   completion: @escaping (AFResult<T>) -> Void) -> DataRequest {
    
    return AF.request(route).validate().responseDecodable(decoder: decoder, completionHandler: { (response: DataResponse<T>) in
      completion(response.result)
    })
  }
  
  static func postTest(name: String, birthDate: String, completion: @escaping (AFResult<UserModel>) -> Void) {
   
    performRequest(route: .test(name: name, birthDate: birthDate), completion: completion)
  }
}
