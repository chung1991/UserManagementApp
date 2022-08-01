//
//  HomeViewController.swift
//  UserManagementApp
//
//  Created by Chung Nguyen on 6/6/22.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {
    
    lazy var viewModelDI: ViewModelDI = ViewModelDIImpl.shared
    lazy var viewModel: HomeViewModel = viewModelDI.makeHomeViewModel()
    lazy var dispatchQueue: DispatchQueueProtocol = DispatchQueue.main
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
