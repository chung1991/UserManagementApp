//
//  RegisterViewController.swift
//  UserManagementApp
//
//  Created by Chung Nguyen on 6/5/22.
//

import Foundation
import UIKit

protocol RegisterViewControllerDelegate: AnyObject {
    func registerViewController(didSucceed succeed: Bool, title: String, message: String)
    func registerViewController(didNavigate data: Any?)
}

class RegisterViewController: UIViewController {
    
    @IBOutlet var emailTextfield: UITextField!
    @IBOutlet var passwordTextfield: UITextField!
    @IBOutlet var reTypePasswordTextfield: UITextField!
    @IBOutlet var registerButton: UIButton!
    
    weak var delegate: RegisterViewControllerDelegate?
    
    lazy var viewModelDI: ViewModelDI = ViewModelDIImpl.shared
    lazy var viewModel: RegisterViewModel = viewModelDI.makeRegisterViewModel()
    lazy var dispatchQueue: DispatchQueueProtocol = DispatchQueue.main
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        emailTextfield.layer.borderColor = UIColor.black.withAlphaComponent(0.25).cgColor
        emailTextfield.layer.shadowOffset = CGSize(width: 0, height: 3)
        emailTextfield.layer.shadowColor = UIColor.black.cgColor
        emailTextfield.disableAutoFill()
        
        passwordTextfield.layer.borderColor = UIColor.black.withAlphaComponent(0.25).cgColor
        passwordTextfield.layer.shadowOffset = CGSize(width: 0, height: 3)
        passwordTextfield.layer.shadowColor = UIColor.black.cgColor
        passwordTextfield.isSecureTextEntry = true
        passwordTextfield.disableAutoFill()
        
        reTypePasswordTextfield.layer.borderColor = UIColor.black.withAlphaComponent(0.25).cgColor
        reTypePasswordTextfield.layer.shadowOffset = CGSize(width: 0, height: 3)
        reTypePasswordTextfield.layer.shadowColor = UIColor.black.cgColor
        reTypePasswordTextfield.isSecureTextEntry = true
        reTypePasswordTextfield.disableAutoFill()
        
        registerButton.tintColor = .systemGreen
    }
    
    @IBAction func submitButtonTapped() {
        let email = emailTextfield.text ?? ""
        let password = passwordTextfield.text ?? ""
        let retypePassword = reTypePasswordTextfield.text ?? ""
        
        viewModel.register(email, password, retypePassword) { [weak self] error in
            guard let self = self else { return }
            self.dispatchQueue.async {
                guard let error = error else {
                    self.delegate?.registerViewController(didSucceed: true,
                                                           title: "Login Succeed",
                                                           message: "Account is created successfully")
                    self.delegate?.registerViewController(didNavigate: email)
                    return
                }
                self.delegate?.registerViewController(didSucceed: false,
                                                       title: "Login Failed",
                                                       message: error.localizedDescription)
            }
        }
    }
}
