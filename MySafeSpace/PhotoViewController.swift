//
//  PhotoViewController.swift
//  MySafeSpace
//
//  Created by user217582 on 5/6/22.
//

import UIKit

class PhotoViewController: UIViewController {

	@IBOutlet weak var textView: UITextView!
	@IBOutlet weak var imageView: UIImageView!
	
	public var imageData: Data!
	public var photo: Photo!
	
	override func viewDidLoad() {
        super.viewDidLoad()

		textView.text = photo.photoDescription
		imageView.image = UIImage(data: imageData)
    }
}
