//
//  MainScene module
//  Created by Евгений Котовщиков on 17/06/2019.
//

protocol MainSceneBusinessLogic {
  func retriveAvarar(request: MainScene.Avatar.Request)
}

/// Класс для описания бизнес-логики модуля MainScene
class MainSceneInteractor: MainSceneBusinessLogic {
  let presenter: MainScenePresentationLogic
  let fileManager: FileManagerHelper
  
  init(presenter: MainScenePresentationLogic,
       fileManager: FileManagerHelper = FileManagerHelper()) {
    self.presenter = presenter
    self.fileManager = fileManager
  }
  
  func retriveAvarar(request: MainScene.Avatar.Request) {
    fileManager.readImage { [weak self] (result) in
      let resultOfAvatarRetrive: MainScene.Avatar.Response = .init(result: result)
      self?.presenter.presentRetriveAvatar(response: resultOfAvatarRetrive)
    }
  }
}
