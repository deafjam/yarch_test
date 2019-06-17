//
//  ChooseAvatarScene module
//  Created by Евгений Котовщиков on 17/06/2019.
//

import Foundation

enum ChooseAvatarScene {
  // MARK: Use cases
  enum Image {
    struct Save {
      let data: Data
    }
    
    struct Response {
      var result: Bool
    }
    
    struct ViewModel {
      var state: ViewControllerState
    }
  }
  
  enum ViewControllerState {
    case loading
    case result(message: String)
    case error(message: String)
  }
  
  enum ChooseAvatarSceneError: Error {
    case someError(message: String)
  }
}
