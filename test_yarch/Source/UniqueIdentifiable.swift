//
//  UniqueIdentifiable.swift
//  test_yarch
//
//  Created by Евгений Котовщиков on 16/06/2019.
//  Copyright © 2019 Евгений Котовщиков. All rights reserved.
//

import Foundation

typealias UniqueIdentifier = String

protocol UniqueIdentifiable {
  var uid: UniqueIdentifier { get }
}
