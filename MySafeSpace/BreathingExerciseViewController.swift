//
//  BreathingExerciseViewController.swift
//  MySafeSpace
//
//  Created by user217582 on 4/28/22.
//

import UIKit

class BreathingExcerciseViewController: UIViewController {
    
    @IBOutlet weak var completionLabel: UILabel!
    @IBOutlet weak var redoExerciseButton: UIButton!
    
    private var firstRingLayer: CAShapeLayer = CAShapeLayer()
    private var secondRingLayer: CAShapeLayer = CAShapeLayer()
    private var thirdRingLayer: CAShapeLayer = CAShapeLayer()
    private var fourthRingLayer: CAShapeLayer = CAShapeLayer()
    private var inhaleTextLayer: CATextLayer = CATextLayer()
    private var holdTextLayer: CATextLayer = CATextLayer()
    private var exhaleTextLayer: CATextLayer = CATextLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let centerX = view.frame.width/2
        let centerY = view.frame.height/2 - 200 // din cauza navbarului
        
        let circlePath = setBezierPath(x: centerX, y: centerY, radius: 80)
        
        completionLabel.isHidden = true
        redoExerciseButton.isHidden = true
        
        firstRingLayer.path = circlePath.cgPath
        firstRingLayer.fillColor = UIColor.clear.cgColor
        firstRingLayer.strokeColor = UIColor(red: 0, green: 0, blue: 1,alpha: 1).cgColor
        firstRingLayer.lineWidth = 20.0
            
        secondRingLayer.path = circlePath.cgPath
        secondRingLayer.fillColor = UIColor.clear.cgColor
        secondRingLayer.strokeColor = UIColor(red: 0, green: 0, blue: 0.8,alpha: 1).cgColor
        secondRingLayer.lineWidth = 20.0
        
        thirdRingLayer.path = circlePath.cgPath
        thirdRingLayer.fillColor = UIColor.clear.cgColor
        thirdRingLayer.strokeColor = UIColor(red: 0, green: 0, blue: 0.6,alpha: 1).cgColor
        thirdRingLayer.lineWidth = 20.0
        
        fourthRingLayer.path = circlePath.cgPath
        fourthRingLayer.fillColor = UIColor.clear.cgColor
        fourthRingLayer.strokeColor = UIColor(red: 0, green: 0, blue: 0.4,alpha: 1).cgColor
        fourthRingLayer.lineWidth = 20.0
        
        inhaleTextLayer.string = "Inhale"
        inhaleTextLayer.frame = CGRect(x: centerX - 50, y: centerY - 19, width: 100, height: 100) // -18 pt ca marimea default a fontului este 36
        inhaleTextLayer.alignmentMode = .center
        
        holdTextLayer.string = "Hold"
        holdTextLayer.frame = CGRect(x: centerX - 75, y: centerY - 19, width: 150, height: 100) // -18 pt ca marimea default a fontului este 36
        holdTextLayer.alignmentMode = .center
        
        exhaleTextLayer.string = "Exhale"
        exhaleTextLayer.frame = CGRect(x: centerX - 75, y: centerY - 19, width: 150, height: 100) // -18 pt ca marimea default a fontului este 36
        exhaleTextLayer.alignmentMode = .center
        
        view.layer.addSublayer(fourthRingLayer)
        view.layer.addSublayer(thirdRingLayer)
        view.layer.addSublayer(secondRingLayer)
        view.layer.addSublayer(firstRingLayer)
        view.layer.addSublayer(inhaleTextLayer)
        view.layer.addSublayer(holdTextLayer)
        view.layer.addSublayer(exhaleTextLayer)
        
        breathingAnimation()
    }
    
    @IBAction func didTapRedoExerciseButton(_ sender: Any) {
        breathingAnimation()
    }
    
    private func breathingAnimation() {
        
        completionLabel.isHidden = true
        redoExerciseButton.isHidden = true
        self.firstRingLayer.isHidden = false
        self.secondRingLayer.isHidden = false
        self.thirdRingLayer.isHidden = false
        self.fourthRingLayer.isHidden = false
        self.inhaleTextLayer.isHidden = false
        self.holdTextLayer.isHidden = false
        self.exhaleTextLayer.isHidden = false
        
        CATransaction.begin()
        CATransaction.setCompletionBlock({
            self.firstRingLayer.isHidden = true
            self.secondRingLayer.isHidden = true
            self.thirdRingLayer.isHidden = true
            self.fourthRingLayer.isHidden = true
            self.inhaleTextLayer.isHidden = true
            self.holdTextLayer.isHidden = true
            self.exhaleTextLayer.isHidden = true
            self.completionLabel.isHidden = false
            self.redoExerciseButton.isHidden = false
        })
        fourthRingLayer.add(animationGroup(scaleValue: 2), forKey: nil)
        CATransaction.commit()
        thirdRingLayer.add(animationGroup(scaleValue: 1.75), forKey: nil)
        firstRingLayer.add(animationGroup(scaleValue: 1.25), forKey: nil)
        secondRingLayer.add(animationGroup(scaleValue: 1.5), forKey: nil)
        inhaleTextLayer.add(hideInhaleText(scaleValue: 0.0), forKey: nil)
        holdTextLayer.add(hideHoldText(scaleValue: 0.0), forKey: nil)
        exhaleTextLayer.add(hideExhaleText(scaleValue: 0.0), forKey: nil)
    }
    
    private func animationGroup(scaleValue: CGFloat) -> CAAnimationGroup {
        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [keepAnimationInPlace, scaleAnimation(scaleValue: scaleValue)]
        animationGroup.duration = 10
        animationGroup.repeatCount = 4
        return animationGroup
    }
    
    private lazy var keepAnimationInPlace: CABasicAnimation = {
        let expandingAnimation = CABasicAnimation(keyPath: "position")
        expandingAnimation.fromValue = [view.frame.width/2, view.frame.height/2 - 200]
        expandingAnimation.toValue = [view.frame.width/2, view.frame.height/2 - 200]
        return expandingAnimation
    }()
    
    private func scaleAnimation(scaleValue: CGFloat) -> CAKeyframeAnimation {
        let scaleAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        scaleAnimation.values = [1, scaleValue, scaleValue, 1, 1]
        scaleAnimation.keyTimes = [0, 0.35, 0.5, 0.85, 1]
        return scaleAnimation
    }
    
    private func hideInhaleText(scaleValue: CGFloat) -> CAKeyframeAnimation {
        let hideInhaleTextAnimation = CAKeyframeAnimation(keyPath: "hidden")
        hideInhaleTextAnimation.values = [0, 1]
        hideInhaleTextAnimation.keyTimes = [0, 0.68]
        hideInhaleTextAnimation.duration = 10
        hideInhaleTextAnimation.repeatCount = 4
        return hideInhaleTextAnimation
    }
    
    private func hideHoldText(scaleValue: CGFloat) -> CAKeyframeAnimation {
        let hideHoldTextAnimation = CAKeyframeAnimation(keyPath: "opacity")
        hideHoldTextAnimation.values = [0, 0, 1, 1, 0]
        hideHoldTextAnimation.keyTimes = [0, 0.34, 0.35, 0.49, 0.5]
        hideHoldTextAnimation.duration = 10
        hideHoldTextAnimation.repeatCount = 4
        return hideHoldTextAnimation
    }
    
    private func hideExhaleText(scaleValue: CGFloat) -> CAKeyframeAnimation {
        let hideExhaleTextAnimation = CAKeyframeAnimation(keyPath: "hidden")
        hideExhaleTextAnimation.values = [1, 0]
        hideExhaleTextAnimation.keyTimes = [0, 1]
        hideExhaleTextAnimation.duration = 10
        hideExhaleTextAnimation.repeatCount = 4
        return hideExhaleTextAnimation
    }
    
    private func setBezierPath(x: CGFloat, y: CGFloat, radius: CGFloat) -> UIBezierPath {
        return UIBezierPath(arcCenter: CGPoint(x: 0, y: 0), radius: radius, startAngle: CGFloat(0), endAngle: CGFloat(Double.pi * 2), clockwise: true)
    }
}

