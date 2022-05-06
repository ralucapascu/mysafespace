//
//  EditImageViewController.swift
//  MySafeSpace
//
//  Created by user217582 on 5/6/22.
//

import UIKit

class EditImageViewController: UIViewController {

	@IBOutlet weak var imageView: UIImageView!
	@IBOutlet weak var descriptionTextView: UITextView!
	
	public var imageData: Data = Data()
	
	public var completion: ((Photo) -> Void)!
	
    override func viewDidLoad() {
        super.viewDidLoad()

		imageView.image = UIImage(data: imageData)
		
		navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save description", style: .done, target: self, action: #selector(didTapSaveButton))
    }
	
	@objc func didTapSaveButton() {
		let photo = Photo()
		photo.photoDescription = descriptionTextView.text
		completion(photo)
		navigationController?.popViewController(animated: true)
	}

}
