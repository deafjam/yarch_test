//
//  Coordinator.swift
//  test_mvvm
//
//  Created by Евгений Котовщиков on 13/06/2019.
//  Copyright © 2019 Евгений Котовщиков. All rights reserved.
//

import UIKit

public protocol Coordinator: class {
//  var childCoordinators: [Coordinator] { get set }
  
  init(navigationController: UINavigationController)
  func start()
}
