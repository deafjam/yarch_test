//
//  MainScene module
//  Created by Евгений Котовщиков on 17/06/2019.
//

import UIKit

protocol MainSceneDisplayLogic: class {
  func displaySomething(viewModel: MainScene.Avatar.ViewModel)
}

class MainSceneViewController: UIViewController {
  weak var coordinator: FlowCoordinator?
  
  @IBOutlet weak var avatarImageView: UIImageView!
  
  @IBAction func profileHandler(sender: UIButton) {
    coordinator?.goToProfile()
  }
  
  @IBAction func choosePhotoHandler(sender: UIButton) {
    coordinator?.goToChooseAvatar()
  }
  
  let interactor: MainSceneBusinessLogic
  var state: MainScene.ViewControllerState
  
  init(interactor: MainSceneBusinessLogic, initialState: MainScene.ViewControllerState = .loading) {
    self.interactor = interactor
    self.state = initialState
    super.init(nibName: "MainSceneViewController", bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    configure(avatar: avatarImageView)
    let request = MainScene.Avatar.Request()
    interactor.retriveAvarar(request: request)
  }
  
  private func configure(avatar: UIImageView) {
    avatar.layer.cornerRadius = avatar.bounds.height / 2.0
  }
}

extension MainSceneViewController: MainSceneDisplayLogic {
  func displaySomething(viewModel: MainScene.Avatar.ViewModel) {
    display(newState: viewModel.state)
  }
  
  func display(newState: MainScene.ViewControllerState) {
    state = newState
    switch state {
    case .loading:
      print("loading...")
    case let .result(image):
      avatarImageView.image = image
      avatarImageView.isHidden = false
    case .empty:
      avatarImageView.isHidden = true
    }
  }
}
