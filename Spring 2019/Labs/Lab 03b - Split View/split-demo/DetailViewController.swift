//
//  DetailViewController.swift
//  split-demo
//
//  Created by Cooper Jones on 2/28/19.
//  Copyright © 2019 Cooper Jones. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var detailDescriptionLabel: UILabel!

    @IBOutlet weak var webView: WKWebView!
    
    @IBOutlet weak var webSpinner: UIActivityIndicatorView!
    
    func loadWebPage(_ urlString: String){
        //the urlString should be a propery formed url
        //creates a URL object
        let myurl = URL(string: urlString)
        //create a URLRequest object
        let request = URLRequest(url: myurl!)
        //load the URLRequest object in our web view
        webView.load(request)
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation
        navigation: WKNavigation!) {
        webSpinner.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!)
    {
        webSpinner.stopAnimating()
    }
    
    func configureView() {
        // Update the user interface for the detail item.
        if let detail = detailItem {
            if let label = detailDescriptionLabel {
                label.text = detail.description
                loadWebPage(detail.description)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
    }

    var detailItem: String? {
        didSet {
            // Update the view.
            configureView()
        }
    }


}

