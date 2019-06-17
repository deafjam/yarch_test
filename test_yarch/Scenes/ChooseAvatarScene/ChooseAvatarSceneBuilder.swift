//
//  ChooseAvatarScene module
//  Created by Евгений Котовщиков on 17/06/2019.
//

import UIKit

class ChooseAvatarSceneBuilder: ModuleBuilder {

    var initialState: ChooseAvatarScene.ViewControllerState?

    func set(initialState: ChooseAvatarScene.ViewControllerState) -> ChooseAvatarSceneBuilder {
        self.initialState = initialState
        return self
    } 

    func build() -> UIViewController {
        let presenter = ChooseAvatarScenePresenter()
        let interactor = ChooseAvatarSceneInteractor(presenter: presenter)
        let controller = ChooseAvatarSceneViewController(interactor: interactor)

        presenter.viewController = controller
        return controller
    }
}
