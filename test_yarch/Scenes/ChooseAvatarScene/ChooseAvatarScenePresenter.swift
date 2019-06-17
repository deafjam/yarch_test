//
//  ChooseAvatarScene module
//  Created by Евгений Котовщиков on 17/06/2019.
//

import UIKit

protocol ChooseAvatarScenePresentationLogic {
    func presentSavingStatus(response: ChooseAvatarScene.Image.Response)
}

/// Отвечает за отображение данных модуля ChooseAvatarScene
class ChooseAvatarScenePresenter: ChooseAvatarScenePresentationLogic {
    weak var viewController: ChooseAvatarSceneDisplayLogic?

    func presentSavingStatus(response: ChooseAvatarScene.Image.Response) {
        var viewModel: ChooseAvatarScene.Image.ViewModel
        
        switch response.result {
        case true:
          viewModel = ChooseAvatarScene.Image.ViewModel(state: .result(message: "Сохранено"))
        case false:
          viewModel = ChooseAvatarScene.Image.ViewModel(state: .error(message: "Ошибка"))
        }
        viewController?.displaySomething(viewModel: viewModel)
    }
}
