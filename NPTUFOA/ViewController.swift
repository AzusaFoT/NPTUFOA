//
//  ViewController.swift
//  NPTUFOA
//
//  Created by students on 2022/5/20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var studentNumBox: UITextField!
    @IBAction func loginButton(_ sender: UIButton) {
        if studentNumBox.text != "" {
            self.performSegue(withIdentifier: "websiteSegue", sender: self)}
        else{
            displayAlert(title: "請輸入學號", message: "未輸入學號造成的錯誤")
        }
    }
    
    func loginVerify(sNum: String){
        //sNum = studentNum
        
    }
    
    func displayAlert(title: String,message: String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(alertAction)
        self.present(alertController,animated: true,completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

