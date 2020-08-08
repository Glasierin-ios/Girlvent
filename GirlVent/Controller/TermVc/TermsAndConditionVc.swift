//
//  TermsAndConditionVc.swift
//  Girlvent
//
//  Created by Glasier Inc. on 09/06/20.
//  Copyright © 2020 Glasier Inc. All rights reserved.
//

import UIKit
import WebKit
class TermsAndConditionVc: UIViewController {
      
    //MARK:- Outlets
      @IBOutlet weak var webView: WKWebView!
      @IBOutlet weak var termBackButton: UIButton!
      @IBOutlet var lblTitle: UILabel!
    
    
    //MARK:- Variables
     let sampleURL = "https://girlvent.girlvent.glasier.in.glasier.in/terms-conditions"
      private var activityIndicatorContainer: UIView!
      private var activityIndicator: UIActivityIndicatorView!
    
    
    //MARK:- ViewLifeCycles
      override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        sendRequest(urlString: sampleURL)
        
        lblTitle.text = GLocalizedString(key: "tc_Title")
      }
      @IBAction func termBackButtonclick(_ sender: Any) {
             
             
             self.navigationController?.popViewController(animated: true)
         }
      // Convert String into URL and load the URL
      private func sendRequest(urlString: String) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
      }
      fileprivate func setActivityIndicator() {
        // Configure the background containerView for the indicator
        activityIndicatorContainer = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        activityIndicatorContainer.center.x = webView.center.x
        // Need to subtract 44 because WebKitView is pinned to SafeArea
        //   and we add the toolbar of height 44 programatically
        activityIndicatorContainer.center.y = webView.center.y - 44
        activityIndicatorContainer.backgroundColor = UIColor.black
        activityIndicatorContainer.alpha = 0.8
        activityIndicatorContainer.layer.cornerRadius = 10
      
        // Configure the activity indicator
        activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.whiteLarge
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
    activityIndicatorContainer.addSubview(activityIndicator)
        webView.addSubview(activityIndicatorContainer)
        
        // Constraints
        activityIndicator.centerXAnchor.constraint(equalTo: activityIndicatorContainer.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: activityIndicatorContainer.centerYAnchor).isActive = true
      }
    
    @objc private func goBack() {
      }
    // Helper function to control activityIndicator's animation
      fileprivate func showActivityIndicator(show: Bool) {
        if show {
          activityIndicator.startAnimating()
        } else {
          activityIndicator.stopAnimating()
          activityIndicatorContainer.removeFromSuperview()
        }
      }
    }
    extension TermsAndConditionVc: WKNavigationDelegate {
      func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.showActivityIndicator(show: false)
      }
      func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        // Set the indicator everytime webView started loading
        self.setActivityIndicator()
        self.showActivityIndicator(show: true)
      }
      func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        self.showActivityIndicator(show: false)
      }
    }
