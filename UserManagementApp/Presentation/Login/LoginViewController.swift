//
//  LoginViewController.swift
//  UserManagementApp
//
//  Created by Chung Nguyen on 6/3/22.
//

import UIKit

protocol LoginViewControllerDelegate: AnyObject {
    func loginViewController(didSucceed succeed: Bool, title: String, message: String)
    func loginViewController(didTapOnLink data: Any?)
    func loginViewController(didTapOnLink data: Any?)
}

class LoginViewController: UIViewController {

    @IBOutlet var emailTextfield: UITextField!
    @IBOutlet var passwordTextfield: UITextField!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var registerButton: UIButton!
    
    lazy var viewModelDI: ViewModelDI = ViewModelDIImpl.shared
    lazy var viewModel: LoginViewModel = viewModelDI.makeLoginViewModel()
    lazy var dispatchQueue: DispatchQueueProtocol = DispatchQueue.main
    
    weak var delegate: LoginViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupDelegates()
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
        
        loginButton.tintColor = .systemGreen
    }
    
    func setupDelegates() {
        passwordTextfield.delegate = self
    }
    
    @IBAction func submitButtonTapped() {
        let email = emailTextfield.text ?? ""
        let password = passwordTextfield.text ?? ""
        
        viewModel.login(email, password) { [weak self] error in
            self?.dispatchQueue.async {
                guard let error = error else {
                    self?.delegate?.loginViewController(didNavigate: self?.viewModel.currentCredential)
                    return
                }
                self?.delegate?.loginViewController(didSucceed: false,
                                                    title: "Login Failed",
                                                    message: error.localizedDescription)
            }
            
        }
    }
    
    func updateEmailField(_ str: String) {
        dispatchQueue.async {
            self.emailTextfield.text = str
        }
    }
    
    @IBAction func registerButtonTapped() {
        dispatchQueue.async { [weak self] in
            // this time always register link, so pass nil
            self?.delegate?.loginViewController(didNavigate: nil)
        }
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        submitButtonTapped()
        return true
    }
}

