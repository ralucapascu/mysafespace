//
//  ChangePasswordViewController.swift
//  MySafeSpace
//
//  Created by user217582 on 5/7/22.
//

import UIKit
import RealmSwift

class ChangePasswordViewController: UIViewController {

	@IBOutlet weak var confirmPassword: UITextField!
	@IBOutlet weak var newPassword: UITextField!
	@IBOutlet weak var oldPassword: UITextField!
	
	let realm = try! Realm()
	var currentUser: User = User()
	
	override func viewDidLoad() {
        super.viewDidLoad()

		oldPassword?.attributedPlaceholder = NSAttributedString(
			string: "Old password",
			attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
		)
		
		newPassword?.attributedPlaceholder = NSAttributedString(
			string: "New password",
			attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
		)
		
		confirmPassword?.attributedPlaceholder = NSAttributedString(
			string: "Confirm password",
			attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
		)
    }
	
	@IBAction func didTapChangePassButton(_ sender: Any) {
		let oldPassword = self.oldPassword.text!
		let newPassword = self.newPassword.text!
		let confirmPassword = self.confirmPassword.text!
		
		if oldPassword.isEmpty || newPassword.isEmpty || confirmPassword.isEmpty {
			let alert = UIAlertController(title: "Empty fields", message: "All fields must be completed.", preferredStyle: .alert)
			alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
			self.present(alert, animated: true, completion: nil)
			return
		}
		
		if oldPassword != currentUser.password {
			let alert = UIAlertController(title: "Incorrect password", message: "The old password is incorect.", preferredStyle: .alert)
			alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
			self.present(alert, animated: true, completion: nil)
			return
		}
		
		if newPassword != confirmPassword {
			let alert = UIAlertController(title: "Incorrect password", message: "The new password is written incorrectly. Please check it and try again.", preferredStyle: .alert)
			alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
			self.present(alert, animated: true, completion: nil)
			return
		}
		
		try! realm.write {
			// update the user with the new password
			currentUser.password = newPassword
		}
		
		let viewController = self.storyboard?.instantiateViewController(withIdentifier: "loginNavController") as! UINavigationController
		viewController.modalTransitionStyle = .crossDissolve
		viewController.modalPresentationStyle = .fullScreen
		self.present(viewController, animated: true)
	}
}
