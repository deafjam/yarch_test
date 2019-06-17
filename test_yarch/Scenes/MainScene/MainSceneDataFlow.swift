//
//  MainScene module
//  Created by Евгений Котовщиков on 17/06/2019.
//
import UIKit

enum MainScene {
  // MARK: Use cases
  enum Avatar {
    struct Request {
    }
    
    struct Response {
      var result: UIImage?
    }
    
    struct ViewModel {
      var state: ViewControllerState
    }
  }
  
  enum ViewControllerState {
    case loading
    case result(UIImage)
    case empty
  }
  
  enum MainSceneError: Error {
    case someError(message: String)
  }
}
