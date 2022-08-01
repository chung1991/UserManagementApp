//
//  MainCoordinator+RegisterViewController.swift
//  UserManagementApp
//
//  Created by Chung Nguyen on 6/5/22.
//

import Foundation
import UIKit

extension MainCoordinator: RegisterViewControllerDelegate {
    func registerViewController(didNavigate data: Any?) {
        guard let email = data as? String else { return }
        guard let loginViewController = findViewController(LoginViewController.self) else {
            return
        }
        loginViewController.updateEmailField(email)
    }
    
    func registerViewController(didSucceed succeed: Bool, title: String, message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { [weak self] _ in
            if succeed {
                guard let registerVc = self?.findViewController(RegisterViewController.self) else {
                    return
                }
                registerVc.dismiss(animated: true, completion: nil)
            }
        }))
        guard let topPresentedVc = topPresentedViewController() else {
            return
        }
        topPresentedVc.present(alert, animated: true, completion: nil)
    }
}
