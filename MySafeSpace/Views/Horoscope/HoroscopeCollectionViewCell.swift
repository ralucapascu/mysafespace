//
//  HoroscopeCollectionViewCell.swift
//  MySafeSpace
//
//  Created by user217582 on 5/4/22.
//

import UIKit

class HoroscopeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    func configure(image: UIImage, labelText: String) {
        self.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 1.0, alpha: 1.0)
        self.layer.cornerRadius = 20
        self.layer.borderColor = UIColor(red: 0.0, green: 0.0, blue: 0.6, alpha: 1.0).cgColor
        self.layer.borderWidth = 2.0
        label.text = labelText
        imageView.image = image
        imageView.tintColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: self.centerYAnchor, constant: -40).isActive = true
        label.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        imageView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 0).isActive = true
        imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
    }
}
