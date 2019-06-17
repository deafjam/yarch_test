//
//  UserModel.swift
//  test_mvvm
//
//  Created by Евгений Котовщиков on 13/06/2019.
//  Copyright © 2019 Евгений Котовщиков. All rights reserved.
//

import Foundation

struct UserModel: Codable {
  var name: String?
  var birthDate: String?
  
  init(name: String? = "",
       birthDate: String? = "") {
    self.name = name
    self.birthDate = birthDate
  }
}
