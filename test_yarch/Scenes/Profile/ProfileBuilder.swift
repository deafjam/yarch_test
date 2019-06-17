//
//  Profile module
//  Created by Евгений Котовщиков on 16/06/2019.
//

import UIKit

class ProfileBuilder: ModuleBuilder {

    var initialState: Profile.ViewControllerState?

    func set(initialState: Profile.ViewControllerState) -> ProfileBuilder {
        self.initialState = initialState
        return self
    } 

    func build() -> UIViewController {
        let presenter = ProfilePresenter()
        let interactor = ProfileInteractor(presenter: presenter)
        let controller = ProfileViewController(interactor: interactor)

        presenter.viewController = controller
        return controller
    }
}
