//
//  WebViewViewController.swift
//  MySafeSpace
//
//  Created by user217582 on 5/7/22.
//

import UIKit
import WebKit

class WebViewViewController: UIViewController {

	@IBOutlet weak var webView: WKWebView!
	
	override func viewDidLoad() {
        super.viewDidLoad()

		webView.load(URLRequest(url: URL(string: "https://www.csid.ro/")!))
    }
}
