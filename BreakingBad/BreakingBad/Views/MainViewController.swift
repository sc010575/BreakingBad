//
//  ViewController.swift
//  BreakingBad
//
//  Created by Suman Chatterjee on 09/01/2020.
//  Copyright © 2020 Suman Chatterjee. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    
    let breakingApiService = BreakingBadApiService()
    breakingApiService.retrieveModel { (results) in
      switch results {
      case .success(let charecters):
        print (charecters)
      default:
        break
      }
    }
  }
}

