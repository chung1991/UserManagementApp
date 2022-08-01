//
//  MainCoordinator.swift
//  UserManagementApp
//
//  Created by Chung Nguyen on 6/3/22.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    var navigationViewController: UINavigationController
    
    init(_ navigationViewController: UINavigationController) {
        self.navigationViewController = navigationViewController
    }
    
    func start() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController else {
            return
        }
        vc.delegate = self
        navigationViewController.pushViewController(vc, animated: true)
    }
    
    func findViewController<T>(_ vcType: T.Type) -> T? {
        for vc in navigationViewController.viewControllers {
            if type(of: vc) == vcType {
                return vc as? T
            }
            
            // find 1 level of presented VC
            guard let pvc = vc.presentedViewController else {
                continue
            }
            if type(of: pvc) == vcType {
                return pvc as? T
            }
        }
        return nil
    }
    
    func topPresentedViewController() -> UIViewController? {
        let topVc = navigationViewController.topViewController
        var presentedViewController = topVc?.presentedViewController
        while presentedViewController?.presentedViewController != nil {
            presentedViewController = presentedViewController?.presentedViewController
        }
        return presentedViewController ?? topVc
    }
}
