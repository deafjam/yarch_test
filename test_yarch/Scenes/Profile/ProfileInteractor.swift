//
//  Profile module
//  Created by Евгений Котовщиков on 16/06/2019.
//

protocol ProfileBusinessLogic {
  //    func doSomething(request: Profile.Something.Request)
  func saveProfileData(request: Profile.Data.Save)
  func retriveProfileData(request: Profile.Data.Retrive)
}

/// Класс для описания бизнес-логики модуля Profile
class ProfileInteractor: ProfileBusinessLogic {
  
  let presenter: ProfilePresentationLogic
  let fileManager: FileManagerHelper
  
  init(presenter: ProfilePresentationLogic,
       fileManager: FileManagerHelper = FileManagerHelper()) {
    self.presenter = presenter
    self.fileManager = fileManager
  }
  
  func saveProfileData(request: Profile.Data.Save) {
    fileManager.saveData(user: request.user) { [weak self] (result) in
      let resultOfSaving: Profile.Data.Response = .init(result: result)
      self?.presenter.presentSavingStatus(response: resultOfSaving)
    }
  }
  
  func retriveProfileData(request: Profile.Data.Retrive) {
    fileManager.readData { [weak self] (result: UserModel?) in
      if let result = result {
        let resultOfRetriveData: Profile.Data.ResponseData = .init(result: result)
        self?.presenter.presentRetiveUserDatat(response: resultOfRetriveData)
      }
    }
    
  }
}
