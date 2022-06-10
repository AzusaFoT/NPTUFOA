//
//  ViewController.swift
//  NPTUFOA
//
//  Created by students on 2022/5/20.
//

import UIKit

class ViewController: UIViewController {
    struct APIData: Codable {
        var name: String
        var meals: String
        var studentNum: String
        var time: String
        var serialNum: Int
    }
    @IBOutlet weak var numView: UIView!
    let HTTP_METHOD_GET = "GET"
    let CONTENT_TYPE = "application/json"
    let HTTP_HEADER_FIELD = "Content-Type"
        
    var aPIDataArray = [APIData]()
    
    @IBOutlet weak var studentNumBox: UITextField!
    @IBAction func loginButton(_ sender: UIButton) {
        if studentNumBox.text != "" {
            self.performSegue(withIdentifier: "websiteSegue", sender: self)
            numView.alpha = 1
        }
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
    
    func getSheetDB(){
        //let urlSheetDB = "https://docs.google.com/spreadsheets/d/1mo-a7TcJkJ7B-77jR5aBqLu1lBiY38RRHeOCG5chHCs/edit#gid=1754583349"
        let urlGAS = "https://script.google.com/macros/s/AKfycbwmGFdnuE98e0AVg-wnULmTS0vebOs6SYT33JoWZsR9t3mQmJqrn0qShu8t-V23Jq3_Kg/exec"
        let apiUrl = urlGAS
        
        if let urlApi = URL(string: apiUrl){
            var urlRequest = URLRequest(url: urlApi)
                        urlRequest.httpMethod = HTTP_METHOD_GET
                        urlRequest.setValue(CONTENT_TYPE, forHTTPHeaderField: HTTP_HEADER_FIELD)

                        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                            if error == nil {
                                if let data = data,
                                   let aPIDataArray = try? JSONDecoder().decode([APIData].self, from: data) {
                                    self.aPIDataArray = aPIDataArray
                                    DispatchQueue.main.async {
                                        print("reload?")
                                    }
                                }
                            } else {
                                print("====== getDataFromSheetDB error ======")
                                print("debugDescription: \(error.debugDescription)")
                                print("====== getDataFromSheetDB error =======")
                                //self.aPIDataArray = self.getDataFromArray()
                                
                                DispatchQueue.main.async {
                                    print("reload?")
                                }
                            }
                        }.resume()
            
        }
        
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        numView.alpha = 0
    }


}

