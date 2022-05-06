//
//  PhotoCollectionViewCell.swift
//  MySafeSpace
//
//  Created by user217582 on 5/6/22.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
	@IBOutlet weak var imageView: UIImageView!
	
	func configure(image: UIImage) {
		self.backgroundColor = .black
		imageView.image = image
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
		imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
		imageView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
		imageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
	}
}
