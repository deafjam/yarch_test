//
//  MainScene module
//  Created by Евгений Котовщиков on 17/06/2019.
//

import UIKit

class MainSceneBuilder: ModuleBuilder {

    var initialState: MainScene.ViewControllerState?

    func set(initialState: MainScene.ViewControllerState) -> MainSceneBuilder {
        self.initialState = initialState
        return self
    } 

    func build() -> UIViewController {
        let presenter = MainScenePresenter()
        let interactor = MainSceneInteractor(presenter: presenter)
        let controller = MainSceneViewController(interactor: interactor)

        presenter.viewController = controller
        return controller
    }
}
