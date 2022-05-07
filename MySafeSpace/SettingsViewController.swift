//
//  SettingsViewController.swift
//  MySafeSpace
//
//  Created by user217582 on 5/7/22.
//

import UIKit
import RealmSwift
import FBSDKLoginKit

class SettingsViewController: UIViewController {

	@IBOutlet weak var tableView: UITableView!
	
	let realm = try! Realm()
	let settingsOptions: [String] = ["Change password", "Sign out", "Delete account"]
	var currentUser: User = User()
	
	override func viewDidLoad() {
        super.viewDidLoad()

		tableView.delegate = self
		tableView.dataSource = self
		tableView.backgroundColor = .black
		
		if let token = AccessToken.current, !token.isExpired {
			let fbLoginButton = FBLoginButton(frame: CGRect(x: 0, y: 0, width: 90, height: 40), permissions: ["public_profile", "email"])
			fbLoginButton.translatesAutoresizingMaskIntoConstraints = false
			fbLoginButton.delegate = self
			view.addSubview(fbLoginButton)
			fbLoginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
			fbLoginButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
		} else {
			tableView.isHidden = false
		}
    }
	
	private func changePassword() {
		let viewController = self.storyboard?.instantiateViewController(withIdentifier: "changePassVC") as! ChangePasswordViewController
		viewController.currentUser = currentUser
		viewController.title = "Change password"
		self.navigationController?.pushViewController(viewController, animated: true)
	}
	
	private func signUserOut() {
		let alert = UIAlertController(title: "Sign out", message: "Are you sure you want to sign out?", preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: {
			action in
			self.navigationController?.popToRootViewController(animated: false)
			let viewController = self.storyboard?.instantiateViewController(withIdentifier: "loginNavController") as! UINavigationController
			viewController.modalTransitionStyle = .crossDissolve
			viewController.modalPresentationStyle = .fullScreen
			self.present(viewController, animated: true)
		}))
		alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
		self.present(alert, animated: true, completion: nil)
	}
	
	private func deleteAccount() {
		let alert = UIAlertController(title: "Warning", message: "This action will permanently delete your account and all your data will be lost. Do you want to continue?", preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: {
			action in
			
			try! self.realm.write {
				// delete the account
				self.realm.delete(self.currentUser)
			}
			
			self.navigationController?.popToRootViewController(animated: false)
			let viewController = self.storyboard?.instantiateViewController(withIdentifier: "loginNavController") as! UINavigationController
			viewController.modalTransitionStyle = .crossDissolve
			viewController.modalPresentationStyle = .fullScreen
			self.present(viewController, animated: true)
		}))
		alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
		self.present(alert, animated: true, completion: nil)
	}
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return settingsOptions.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "settingsCell", for: indexPath)
		cell.textLabel?.text = settingsOptions[indexPath.row]
		cell.textLabel?.font = UIFont.systemFont(ofSize: 20)
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		switch tableView.cellForRow(at: indexPath)?.textLabel?.text {
		case "Change password":
			self.changePassword()
		case "Sign out":
			self.signUserOut()
		case "Delete account":
			self.deleteAccount()
		default:
			return
		}
	}
}

extension SettingsViewController: LoginButtonDelegate {
	func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
		
	}
	
	func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
		navigationController?.popToRootViewController(animated: false)
		let viewController = self.storyboard?.instantiateViewController(withIdentifier: "loginNavController") as! UINavigationController
		viewController.modalTransitionStyle = .crossDissolve
		viewController.modalPresentationStyle = .fullScreen
		self.present(viewController, animated: true)
	}
}
