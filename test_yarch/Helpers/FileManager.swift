//
//  FileManager+UIImage.swift
//  test_mvvm
//
//  Created by Евгений Котовщиков on 12/06/2019.
//  Copyright © 2019 Евгений Котовщиков. All rights reserved.
//

import UIKit

extension FileManager {
  
  func write(name: String, data: Data, completion: @escaping (Bool) -> Void) {
    
    let path = documentsPath(for: name)
    
    do {
      try data.write(to: path, options: .atomic)
      completion(true)
    } catch let error {
      completion(false)
      debugPrint("object '" + name + "' writed with error:", error)
    }
  }
  
  func write<T: Encodable>(name: String, data: T, completion: @escaping (Bool) -> Void) {
    
    let path = documentsPath(for: name)
    let encoder = JSONEncoder()
    
    guard let data = try? encoder.encode(data) else {
      return
    }
    
    do {
      try data.write(to: path, options: .atomic)
      completion(true)
    } catch let error {
      completion(false)
      debugPrint("object '" + name + "' writed with error:", error)
    }
  }
  
  func read(name: String, completion: @escaping (UIImage?) -> Void) {
    let path = documentsPath(for: name)
    
    if let image = UIImage(contentsOfFile: path.path) {
      completion(image)
    }
    completion(nil)
  }
  
  func read<T: Decodable>(name: String, as type: T.Type, completion: @escaping (T?) -> Void) {
    
    let path = documentsPath(for: name)
    let decoder = JSONDecoder()
    
    if let data = FileManager.default.contents(atPath: path.path) {
      do {
        let model = try decoder.decode(type, from: data)
        completion(model)
      } catch {
        debugPrint("object '" + name + "' decode with error:", error)
      }
    }
    completion(nil)
  }

  
  func remove(name: String) {
    let path = documentsPath(for: name)
    
    do {
      try self.removeItem(at: path)
      print("Image '" + name + "' removed" )
    } catch let error {
      print("Image '" + name + "' removed with error:", error)
    }
  }
  
  func documentsPath(for name: String) -> URL {
    let paths = self.urls(for: .documentDirectory, in: .userDomainMask)
    let puth = paths[0].appendingPathComponent(name)
    return puth
  }
}
