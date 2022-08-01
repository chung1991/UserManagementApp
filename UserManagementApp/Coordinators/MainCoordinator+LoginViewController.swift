//
//  MainCoordinator+LoginViewController.swift
//  UserManagementApp
//
//  Created by Chung Nguyen on 6/3/22.
//

import Foundation
import UIKit


extension MainCoordinator: LoginViewControllerDelegate {
    func loginViewController(didSucceed succeed: Bool, title: String, message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        navigationViewController.topViewController?.present(alert,
                                                            animated: true,
                                                            completion: nil)
    }
    
    func loginViewController(didNavigate data: Any?) {
        if let credential = data as? Credential {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            guard let vc = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController else {
                return
            }
            vc.viewModel.setCredential(credential)
            navigationViewController.pushViewController(vc, animated: true)
        } else {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            guard let vc = storyboard.instantiateViewController(withIdentifier: "RegisterViewController") as? RegisterViewController else {
                return
            }
            vc.delegate = self
            vc.modalPresentationStyle = .formSheet
            navigationViewController.topViewController?.present(vc,
                                                                animated: true,
                                                                completion: nil)
        }
    }
}
