//
//  ErrorTrigger.swift
//  BreakingBad
//
//  Created by Suman Chatterjee on 11/01/2020.
//  Copyright © 2020 Suman Chatterjee. All rights reserved.
//

import UIKit

struct ErrorMessage {
    var title: String
    var message: String
}

// MARK: - Fallbacks
extension ErrorMessage {

    static var fallbackLostConnectionError: ErrorMessage {
        return ErrorMessage(title: "Lost connection", message: "We appear to have lost connection. Please check your network settings and try again.")
    }

    static var fallbackGenericErrorMessage: ErrorMessage {
        return ErrorMessage(title: "There seems to be a problem", message: "We are experiencing a few problems. Please try refreshing the app, or come back in a couple of minutes.")
    }
}

protocol ErrorTrigger {
    func displayErrorMessage(error: ErrorMessage)
}

extension ErrorTrigger {
    func displayErrorMessage(error: ErrorMessage) {
        guard
            let appDelegate = UIApplication.shared.delegate as? AppDelegate,
            let rootVC = appDelegate.window?.rootViewController as? UINavigationController
            else {
                print("⚠️ Could not retrieve NavController to present error message.")
                return
        }

        let alert = UIAlertController(title: error.title, message: error.message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okAction)
        rootVC.present(alert, animated: true, completion: nil)
    }
}


