//
//  MainScene module
//  Created by Евгений Котовщиков on 17/06/2019.
//

import UIKit

protocol MainScenePresentationLogic {
  func presentRetriveAvatar(response: MainScene.Avatar.Response)
}

/// Отвечает за отображение данных модуля MainScene
class MainScenePresenter: MainScenePresentationLogic {
  weak var viewController: MainSceneDisplayLogic?
  
  func presentRetriveAvatar(response: MainScene.Avatar.Response) {
    var viewModel: MainScene.Avatar.ViewModel
    if let result = response.result {
      viewModel = MainScene.Avatar.ViewModel(state: .result(result))
    } else {
      viewModel = MainScene.Avatar.ViewModel(state: .empty)
    }
    viewController?.displaySomething(viewModel: viewModel)
  }
}
