//
//  LoginViewController.swift
//  MySafeSpace
//
//  Created by user217582 on 4/17/22.
//

import UIKit
import SwiftUI
import RealmSwift
import FBSDKLoginKit

class LoginViewController: UIViewController {
    
    @IBOutlet var label: UILabel!
    @IBOutlet var emailField: UITextField!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var emailErrorLabel: UILabel!
    @IBOutlet var passwordErrorLabel: UILabel!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var fbLoginView: UIView!
    
    let realm = try! Realm()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        emailField?.attributedPlaceholder = NSAttributedString(
            string: "Email address",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
        
        passwordField?.attributedPlaceholder = NSAttributedString(
            string: "Password",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
        
        emailErrorLabel?.isHidden = true
        passwordErrorLabel?.isHidden = true
        
        let fbLoginButton = FBLoginButton(frame: fbLoginView.frame, permissions: ["public_profile", "email"])
        fbLoginButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(fbLoginButton)
        
        fbLoginButton.topAnchor.constraint(equalTo: fbLoginView.topAnchor, constant: 0).isActive = true
        fbLoginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        fbLoginButton.widthAnchor.constraint(equalTo: fbLoginView.widthAnchor, constant: 0).isActive = true
        fbLoginButton.heightAnchor.constraint(equalTo: fbLoginView.heightAnchor, constant: 0).isActive = true
        
        if let token = AccessToken.current, !token.isExpired {
            let token = token.tokenString
            
            let request = FBSDKLoginKit.GraphRequest(graphPath: "me", parameters: ["fields": "email, name"], tokenString: token, version: nil, httpMethod: .get)
            request.start(completion: {completion, result, error in
                if result != nil, error == nil {
                    let viewController = self.storyboard?.instantiateViewController(withIdentifier: "homePageVC") as! HomePageViewController
                    viewController.modalTransitionStyle = .crossDissolve
                    viewController.modalPresentationStyle = .fullScreen
                    self.present(viewController, animated: true)
                }
            })
        }
    }
    
    private func setEmailErrorLabelText(errorText: String) {
        emailErrorLabel.text = errorText
    }
    
    private func setPasswordErrorLabelText(errorText: String) {
        passwordErrorLabel.text = errorText
    }
    
    @IBAction func didTapSignInButton() {
        var isAnyFieldEmpty: Bool = false
        let email = emailField.text!
        let password = passwordField.text!
        
        if !email.isEmpty {
            emailField.layer.borderWidth = 0.0
            emailErrorLabel.isHidden = true
        } else {
            emailField.layer.cornerRadius = 10.0
            emailField.layer.borderColor = UIColor.red.cgColor
            emailField.layer.borderWidth = 1.0
            emailErrorLabel.isHidden = false
            isAnyFieldEmpty = true
            setEmailErrorLabelText(errorText: "Email cannot be empty")
        }
        if !password.isEmpty {
            passwordField.layer.borderWidth = 0.0
            passwordErrorLabel.isHidden = true
        } else {
            passwordField.layer.cornerRadius = 10.0
            passwordField.layer.borderColor = UIColor.red.cgColor
            passwordField.layer.borderWidth = 1.0
            passwordErrorLabel.isHidden = false
            isAnyFieldEmpty = true
            setPasswordErrorLabelText(errorText: "Password cannot be empty")
        }
        
        if(!isAnyFieldEmpty) {
            let user = realm.object(ofType: User.self, forPrimaryKey: email)
            if(user != nil) {
                if(password == user?.password) {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "homePageVC") as! HomePageViewController
                        viewController.modalTransitionStyle = .crossDissolve
                        viewController.modalPresentationStyle = .fullScreen
                        self.present(viewController, animated: true)
                    })
                } else {
                    let alert = UIAlertController(title: "Invalid login credentials", message: "Incorrect password. Please try again.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { action in
                        self.passwordField.text = ""
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
            } else {
                let alert = UIAlertController(title: "Invalid login credentials", message: "No existing account for the email \(email)", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { action in
                    self.passwordField.text = ""
                    self.emailField.text = ""
                }))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func didTapSignUpButton() {
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "signupVC") as! SignUpViewController
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

