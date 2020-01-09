//
//  Character.swift
//  BreakingBad
//
//  Created by Suman Chatterjee on 09/01/2020.
//  Copyright © 2020 Suman Chatterjee. All rights reserved.
//

import Foundation

struct Character: Decodable {
  let charId:Int
  let name:String
  let occupation:[String]
  let img:String
  let status: String
  let nickname: String
  let appearance:[Int]
}

