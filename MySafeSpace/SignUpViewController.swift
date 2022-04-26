//
//  SignUpViewController.swift
//  MySafeSpace
//
//  Created by user217582 on 4/22/22.
//
import UIKit
import RealmSwift

class SignUpViewController: UIViewController {
    
    @IBOutlet var firstNameField: UITextField!
    @IBOutlet var lastNameField: UITextField!
    @IBOutlet var emailField: UITextField!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var confirmPasswordField: UITextField!
    @IBOutlet var errorLabel: UILabel!
    
    let realm = try! Realm()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        errorLabel?.isHidden = true
        
        firstNameField?.attributedPlaceholder = NSAttributedString(
            string: "First name",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
        
        lastNameField?.attributedPlaceholder = NSAttributedString(
            string: "Last name",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
        
        emailField?.attributedPlaceholder = NSAttributedString(
            string: "Email address",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
        
        passwordField?.attributedPlaceholder = NSAttributedString(
            string: "Password",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
        
        confirmPasswordField?.attributedPlaceholder = NSAttributedString(
            string: "Confirm password",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
    }
    
    private func setErrorLabelText(errorText: String) {
        errorLabel.text = errorText
    }
    
    @IBAction func didTapSignUpButton() {
        var isAnyFieldEmpty: Bool = false
        let firstName = firstNameField.text!
        let lastName = lastNameField.text!
        let email = emailField.text!
        let password = passwordField.text!
        let confirmPassword = confirmPasswordField.text!
        
        if !firstName.isEmpty {
            firstNameField.layer.borderWidth = 0.0
        } else {
            firstNameField.layer.cornerRadius = 10.0
            firstNameField.layer.borderColor = UIColor.red.cgColor
            firstNameField.layer.borderWidth = 1.0
            isAnyFieldEmpty = true
        }
        
        if !lastName.isEmpty {
            lastNameField.layer.borderWidth = 0.0
        } else {
            lastNameField.layer.cornerRadius = 10.0
            lastNameField.layer.borderColor = UIColor.red.cgColor
            lastNameField.layer.borderWidth = 1.0
            isAnyFieldEmpty = true
        }
        
        if !email.isEmpty {
            emailField.layer.borderWidth = 0.0
        } else {
            emailField.layer.cornerRadius = 10.0
            emailField.layer.borderColor = UIColor.red.cgColor
            emailField.layer.borderWidth = 1.0
            isAnyFieldEmpty = true
        }
        
        if !password.isEmpty {
            passwordField.layer.borderWidth = 0.0
        } else {
            passwordField.layer.cornerRadius = 10.0
            passwordField.layer.borderColor = UIColor.red.cgColor
            passwordField.layer.borderWidth = 1.0
            isAnyFieldEmpty = true
        }
        
        if !confirmPassword.isEmpty {
            confirmPasswordField.layer.borderWidth = 0.0
        } else {
            confirmPasswordField.layer.cornerRadius = 10.0
            confirmPasswordField.layer.borderColor = UIColor.red.cgColor
            confirmPasswordField.layer.borderWidth = 1.0
            isAnyFieldEmpty = true
        }
        
        if(confirmPassword != password) {
            errorLabel?.isHidden = false
            setErrorLabelText(errorText: "Password typed incorrectly.")
            return
        }
        
        // TO DO : other field validations, such as email format
        
        if(!isAnyFieldEmpty) {
            errorLabel?.isHidden = true
            let user: User = User()
            user.password = password
            user.email = email
            user.firstName = firstName
            user.lastName = lastName
                    
            realm.beginWrite()
            realm.add(user)
            try! realm.commitWrite()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                let viewController = self.storyboard?.instantiateViewController(withIdentifier: "homePageVC") as! HomePageViewController
                viewController.modalTransitionStyle = .crossDissolve
                viewController.modalPresentationStyle = .fullScreen
                self.present(viewController, animated: true)
            })

        } else {
            errorLabel?.isHidden = false
            setErrorLabelText(errorText: "All fields must be completed.")
        }
    }
}


