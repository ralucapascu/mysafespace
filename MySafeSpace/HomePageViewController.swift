//
//  HomePageViewController.swift
//  MySafeSpace
//
//  Created by user217582 on 4/24/22.
//

import UIKit

class HomePageViewController: UIViewController {
    
    @IBOutlet weak var helloUserLabel: UILabel!
    @IBOutlet weak var breathingExerciseView: UIControl!
    
    var currentUser: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        helloUserLabel.text = "Hello, " + currentUser.firstName + "!"
        
        breathingExerciseView.layer.cornerRadius = 30
    }
    
    @IBAction func didTapStartExerciseButton(_ sender: Any) {
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "breathingExerciseVC") as! BreathingExcerciseViewController
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func didTapBreathingExercise(_ sender: Any) {
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "breathingExerciseVC") as! BreathingExcerciseViewController
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
