//
//  Viewcontroller+Test.swift
//  BreakingBadTests
//
//  Created by Suman Chatterjee on 11/01/2020.
//  Copyright © 2020 Suman Chatterjee. All rights reserved.
//

import UIKit
import Quick
import Nimble

extension UIViewController {
  func preloadView() {
    _ = view
  }
  
  func appearInWindow() -> UIWindow {
      let window = UIWindow(frame: UIScreen.main.bounds)
      window.rootViewController = self
      window.makeKeyAndVisible()
      
      _ = self.view
      expect(self.isViewLoaded).toEventually(beTrue(), pollInterval: 0.3)
      
      return window
  }
  
  @discardableResult
  func appearInWindowTearDown() -> (window: UIWindow, tearDown: () -> ()) {
      let window = appearInWindow()
      
      let tearDown = {
          window.rootViewController = nil
      }
      
      return (window: window, tearDown: tearDown)
  }

}

