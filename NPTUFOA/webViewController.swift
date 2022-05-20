//
//  webViewController.swift
//  NPTUFOA
//
//  Created by students on 2022/5/20.
//

import UIKit
import WebKit

class webViewController: UIViewController {

    @IBAction func backButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

}
