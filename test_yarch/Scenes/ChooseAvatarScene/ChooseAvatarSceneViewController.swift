//
//  ChooseAvatarScene module
//  Created by Евгений Котовщиков on 17/06/2019.
//

import UIKit

protocol ChooseAvatarSceneDisplayLogic: class {
  func displaySomething(viewModel: ChooseAvatarScene.Image.ViewModel)
}

class ChooseAvatarSceneViewController: UIViewController {
  
  weak var coordinator: FlowCoordinator?
  
  let imagePickerHelper: ImagePickerHelper
  
  let interactor: ChooseAvatarSceneBusinessLogic
  var state: ChooseAvatarScene.ViewControllerState
  
  @IBAction func getFromDisk(sender: UIButton) {
    imagePickerHelper.presentImagePickerController(in: self)
  }
  
  @IBAction func makePhotoHandler(sender: UIButton) {
    
    imagePickerHelper.presentCameraPickerController(in: self)
  }
  
  init(interactor: ChooseAvatarSceneBusinessLogic,
       initialState: ChooseAvatarScene.ViewControllerState = .loading,
       imagePickerHelper: ImagePickerHelper = ImagePickerHelper()) {
    self.interactor = interactor
    self.state = initialState
    self.imagePickerHelper = imagePickerHelper
    super.init(nibName: "ChooseAvatarSceneViewController", bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: View lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configure(imagePicker: imagePickerHelper)
  }
  
  private func configure(imagePicker: ImagePickerHelper) {
    imagePicker.delegate = self
  }

}

extension ChooseAvatarSceneViewController: ImagePickerProtocol {
  func imagePicked(image: UIImage) {
    if let imageData = image.pngData() {
      let request = ChooseAvatarScene.Image.Save(data: imageData)
      interactor.saveImageToDisk(data: request)
    }
  }
}

extension ChooseAvatarSceneViewController: ChooseAvatarSceneDisplayLogic {
  func displaySomething(viewModel: ChooseAvatarScene.Image.ViewModel) {
    display(newState: viewModel.state)
  }
  
  func display(newState: ChooseAvatarScene.ViewControllerState) {
    state = newState
    switch state {
    case .loading:
      print("loading...")
    case let .error(message):
      print("error \(message)")
    case let .result(items):
      print("result: \(items)")
      coordinator?.goToRoot()
    }
  }
}
