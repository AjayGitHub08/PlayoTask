//
//  HeadLinesWebViewViewController.swift
//  PlayoTask
//
//  Created by pampana ajay on 11/11/21.
//

import UIKit
import WebKit

class HeadLinesWebViewViewController: UIViewController {

    @IBOutlet var webView: WKWebView!
    var webUrl:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let webUrl = webUrl {
        
        if let url = NSURL(string: webUrl) {
            let request = NSURLRequest(url: url as URL)
            webView.load(request as URLRequest)
                }
        }
}
    
    @IBAction func backTapped(){
        self.navigationController?.popViewController(animated: true)
    }
    
}
