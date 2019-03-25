//
//  DetailViewController.swift
//  sp19midterm-cooperjones
//
//  Created by Cooper Jones on 3/25/19.
//  Copyright © 2019 Cooper Jones. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var detailDescriptionLabel: UILabel!
    var detailItem: String?

    func configureView() {
        // Update the user interface for the detail item.
        if let detail = detailItem {
                loadWebPage(detail.description)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
    }
    
    func loadWebPage(_ urlString: String){
        //the urlString should be a propery formed url
        //creates a URL object
        print("loading: " + urlString)
        let myurl = URL(string: urlString)
        //create a URLRequest object
        let request = URLRequest(url: myurl!)
        //load the URLRequest object in our web view
        webView.load(request)
    }
    
    //WKNavigationDelegate method that is called when a web page begins to load
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        spinner.startAnimating()
    }
    
    //WKNavigationDelegate method that is called when a web page loads successfully
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        spinner.stopAnimating()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


