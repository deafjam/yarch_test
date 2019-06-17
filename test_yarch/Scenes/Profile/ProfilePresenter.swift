//
//  Profile module
//  Created by Евгений Котовщиков on 16/06/2019.
//

import UIKit

protocol ProfilePresentationLogic {
  func presentSavingStatus(response: Profile.Data.Response)
  func presentRetiveUserDatat(response: Profile.Data.ResponseData)
}

/// Отвечает за отображение данных модуля Profile
class ProfilePresenter: ProfilePresentationLogic {
  weak var viewController: ProfileDisplayLogic?
  
  // MARK: Do something
  func presentSavingStatus(response: Profile.Data.Response) {
    var viewModel: Profile.Data.ViewModel
    
    switch response.result {
    case true:
      viewModel = Profile.Data.ViewModel(state: .result(message: "Сохранено"))
    case false:
      viewModel = Profile.Data.ViewModel(state: .error(message: "Ошибка"))
    }
    viewController?.displaySomething(viewModel: viewModel)
  }
  
  func presentRetiveUserDatat(response: Profile.Data.ResponseData) {
    var viewModel: Profile.Data.ViewModel
    viewModel = Profile.Data.ViewModel(state: .data(data: response.result))
    viewController?.displaySomething(viewModel: viewModel)
  }
}
