//
//  ChooseAvatarScene module
//  Created by Евгений Котовщиков on 17/06/2019.
//

protocol ChooseAvatarSceneBusinessLogic {
  
  func saveImageToDisk(data: ChooseAvatarScene.Image.Save)
}

/// Класс для описания бизнес-логики модуля ChooseAvatarScene
class ChooseAvatarSceneInteractor: ChooseAvatarSceneBusinessLogic {
  let presenter: ChooseAvatarScenePresentationLogic
  let fileManager: FileManagerHelper
  
  init(presenter: ChooseAvatarScenePresentationLogic,
       fileManager: FileManagerHelper = FileManagerHelper()) {
    self.presenter = presenter
    self.fileManager = fileManager
  }
  
  func saveImageToDisk(data: ChooseAvatarScene.Image.Save) {
    fileManager.saveImage(data: data.data) { [weak self] (result) in
      let resultOfSaving: ChooseAvatarScene.Image.Response = .init(result: result)
      self?.presenter.presentSavingStatus(response: resultOfSaving)
    }
  }
}
