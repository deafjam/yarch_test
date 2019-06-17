//
//  FlowCoordinator.swift
//  test_mvvm
//
//  Created by Евгений Котовщиков on 13/06/2019.
//  Copyright © 2019 Евгений Котовщиков. All rights reserved.
//

import UIKit

class FlowCoordinator: Coordinator {
  
  unowned let navigationController: UINavigationController
  
  required init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func setupNavController() {
    navigationController.navigationBar.isHidden = false
  }
  
  func start() {
    guard let controller = MainSceneBuilder().build() as? MainSceneViewController else {
      fatalError("Couldn't cast view controller to MainSceneViewController :(")
    }
    controller.coordinator = self
    navigationController.show(controller, sender: nil)
    setupNavController()
  }
}

extension FlowCoordinator {
  func goToChooseAvatar() {
    guard let controller = ChooseAvatarSceneBuilder()
      .build() as? ChooseAvatarSceneViewController else {
      fatalError("Couldn't cast view controller to ChooseAvatarSceneViewController :(")
    }
    controller.coordinator = self
    navigationController.show(controller, sender: nil)
  }

  func goToProfile() {
    guard let controller = ProfileBuilder()
      .build() as? ProfileViewController else {
      fatalError("Couldn't cast view controller to ProfileViewController :(")
    }
    controller.coordinator = self
    navigationController.show(controller, sender: nil)
  }

  func goToMain() {
    guard let controller = MainSceneBuilder()
      .build() as? MainSceneViewController else {
      fatalError("Couldn't cast view controller to MainSceneViewController :(")
    }
    controller.coordinator = self
    navigationController.show(controller, sender: nil)
  }

  func goToRoot() {
    navigationController.popToRootViewController(animated: true)
  }
}
