//
//  Profile module
//  Created by Евгений Котовщиков on 16/06/2019.
//

enum Profile {
  // MARK: Use cases
  enum Data {
    struct Save {
      var user: UserModel
    }
    
    struct Retrive {
    }
    
    struct Response {
      var result: Bool
    }
    
    struct ResponseData {
      let result: UserModel
    }
    
    struct ViewModel {
      var state: ViewControllerState
    }
  }
  
  enum ViewControllerState {
    case loading
    case result(message: String)
    case error(message: String)
    case data(data: UserModel)
  }
  
  enum ProfileError: Error {
    case someError(message: String)
  }
}
