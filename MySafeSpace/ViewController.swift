//
//  ViewController.swift
//  MySafeSpace
//
//  Created by user217582 on 4/8/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var label: UILabel!
    @IBOutlet var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            self.heartbeatAnimation()
        })
    }
    
    func heartbeatAnimation() {
        UIView.animateKeyframes(withDuration: 6, delay: 0, options: [.calculationModeCubic], animations: {
            let newDiffX = 200 - self.view.frame.size.width
            let newDiffY = self.view.frame.height - 200
            let initialDiffX = 150 - self.view.frame.size.width
            let initialDiffY = self.view.frame.height - 150
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.1,
                animations: {
                self.imageView.frame = CGRect(x: -(newDiffX/2), y: newDiffY/2, width: 200, height: 200)
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.1, relativeDuration: 0.1, animations: {
                self.imageView.frame = CGRect(x: -(initialDiffX/2), y: initialDiffY/2, width: 150, height: 150)
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.4, relativeDuration: 0.1, animations: {
                self.imageView.frame = CGRect(x: -(newDiffX/2), y: newDiffY/2, width: 200, height: 200)
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.1, animations: {
                self.imageView.frame = CGRect(x: -(initialDiffX/2), y: initialDiffY/2, width: 150, height: 150)
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.8, relativeDuration: 0.1, animations: {
                self.imageView.frame = CGRect(x: -(newDiffX/2), y: newDiffY/2, width: 200, height: 200)
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.9, relativeDuration: 0.1, animations: {
                self.imageView.frame = CGRect(x: -(initialDiffX/2), y: initialDiffY/2, width: 150, height: 150)
            })
        }, completion: {
            done in
            if done {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                    let viewController = LoginViewController()
                    viewController.modalTransitionStyle = .crossDissolve
                    viewController.modalPresentationStyle = .fullScreen
                    self.present(viewController, animated: true)
                })
            }
        })
        
    }

}

