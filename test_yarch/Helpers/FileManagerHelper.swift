//
//  FileManagerHelper.swift
//  test_mvvm
//
//  Created by Евгений Котовщиков on 12/06/2019.
//  Copyright © 2019 Евгений Котовщиков. All rights reserved.
//

import UIKit

struct FileManagerHelper {
  func saveImage(data: Data, completion: @escaping (Bool) -> Void) {
    return FileManager.default.write(name: "ProfileImage", data: data, completion: completion)
  }
  
  func readImage(completion: @escaping (UIImage?) -> Void) {
    return FileManager.default.read(name: "ProfileImage", completion: completion)
  }
  
  func removeImage() {
    FileManager.default.remove(name: "ProfileImage")
  }
  
  func saveData(user: UserModel, completion: @escaping (Bool) -> Void) {
    return FileManager.default.write(name: "User", data: user, completion: completion)
  }
  
  func readData<T: Codable>(completion: @escaping (T?) -> Void) {
    return FileManager.default.read(name: "User", as: T.self, completion: completion)
  }
}
