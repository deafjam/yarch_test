//
//  AppDelegate.swift
//  test_yarch
//
//  Created by Евгений Котовщиков on 16/06/2019.
//  Copyright © 2019 Евгений Котовщиков. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  var coordinator: FlowCoordinator?
  
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    let fileManagerHelper = FileManagerHelper()
    fileManagerHelper.removeImage()
    
    launch(with: window)
    
    return true
    
  }
}

extension AppDelegate {
  
  func launch(with window: UIWindow?) {
    
    let navController = UINavigationController()
    coordinator = FlowCoordinator(navigationController: navController)
    coordinator?.start()
    
    self.window = UIWindow(frame: UIScreen.main.bounds)
    window?.backgroundColor = UIColor.white
    
    self.window?.rootViewController = navController
    self.window?.makeKeyAndVisible()
    
  }
}

