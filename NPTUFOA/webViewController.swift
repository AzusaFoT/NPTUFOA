//
//  webViewController.swift
//  NPTUFOA
//
//  Created by students on 2022/5/20.
//

import UIKit
import WebKit

class webViewController: UIViewController,WKUIDelegate,WKNavigationDelegate {

    
    @IBAction func backButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var webView: WKWebView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let myURL = URL(string:"https://sheetdb.io/s/f/sboj9o8hufsrq")
                let myRequest = URLRequest(url: myURL!)
                webView.load(myRequest)
    }
    
    

    
}
