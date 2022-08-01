//
//  Coordinator.swift
//  UserManagementApp
//
//  Created by Chung Nguyen on 6/3/22.
//

import Foundation
import UIKit

protocol Coordinator {
    var navigationViewController: UINavigationController { get set }
    func start()
}

