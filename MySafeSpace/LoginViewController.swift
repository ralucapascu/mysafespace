//
//  LoginViewController.swift
//  MySafeSpace
//
//  Created by user217582 on 4/17/22.
//

import UIKit

class LoginViewController: UIViewController {
    
    private let imageView: UIImageView = {
        let imageView: UIImageView = UIImageView(frame: CGRect(x: 0, y:0, width: 150, height: 150))
        let heartImage = UIImage(systemName:"heart.fill")?.withTintColor(.systemRed, renderingMode: .alwaysOriginal)
        imageView.contentMode = .scaleAspectFit
        imageView.image = heartImage
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.center = view.center
    }
    
    func pulse() {
        UIView.animateKeyframes(withDuration: 2, delay: 0, options: [.repeat, .autoreverse], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5, animations: {
                let diffX = 200 - self.view.frame.size.width
                let diffY = self.view.frame.height - 200
                self.imageView.frame = CGRect(x: -(diffX/2), y: diffY/2, width: 200, height: 200)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5, animations: {
                let diffX = 150 - self.view.frame.size.width
                let diffY = self.view.frame.height - 150
                self.imageView.frame = CGRect(x: -(diffX/2), y: diffY/2, width: 150, height: 150)
            })
        }, completion: {
            done in
            if done {
                
            }
        })
        
    }

}

