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
        var maalsok : String
        var takeok : String
    }
    
    
    
    
    let HTTP_METHOD_GET = "GET"
    let CONTENT_TYPE = "application/json"
    let HTTP_HEADER_FIELD = "Content-Type"
    var studentID : String = ""
    var aPIDataArray = [APIData]()
    
    //titleView
    @IBOutlet weak var bTitle: UILabel!
    @IBOutlet weak var sTitle: UILabel!

    //numView
    @IBOutlet weak var numView: UIView!
    @IBOutlet weak var serialNumL: UILabel!
    @IBAction func logoutButton(_ sender: UIButton) {
        numView.alpha = 0
        self.bTitle.text = "線上點餐整合服務"
        self.sTitle.text = "學生登記系統"
    }
    
    //loginView
    @IBOutlet weak var studentNumBox: UITextField!
    // login button
    @IBAction func loginButton(_ sender: UIButton) {
        if studentNumBox.text != "" {
            self.studentID = studentNumBox.text!
            self.performSegue(withIdentifier: "websiteSegue", sender: self)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                //延遲一秒
                self.numView.alpha = 1
                self.serialNumL.text = self.searchSerialNum(sNum: self.studentNumBox.text!)
                
                self.bTitle.text = "以下為取餐流水編號"
                self.sTitle.text = self.studentID
            }
            
            
        }
        else{
            displayAlert(title: "請輸入學號", message: "未輸入學號造成的錯誤")
        }
    }
    
    func searchSerialNum(sNum: String) -> String {
        //sNum = studentNum
        //主要是用來爬json的資料把
        var serialNum : String = "⍩"
        
        
        
        return serialNum
    }
    
    // 警告視窗
    func displayAlert(title: String,message: String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(alertAction)
        self.present(alertController,animated: true,completion: nil)
    }
    
    func getSheetDB(){
        //let urlSheetDB = "https://docs.google.com/spreadsheets/d/1mo-a7TcJkJ7B-77jR5aBqLu1lBiY38RRHeOCG5chHCs/edit#gid=1754583349"
        let urlGAS = "https://script.google.com/macros/s/AKfycbxO7o3jJFms2ZOgItEuPGeOrW-KMMhIr_RZoRGs7tVYv1FlOtFE/exec"
        let apiUrl = urlGAS
        
        if let urlApi = URL(string: apiUrl){
            var urlRequest = URLRequest(url: urlApi)
                        urlRequest.httpMethod = HTTP_METHOD_GET
                        urlRequest.setValue(CONTENT_TYPE, forHTTPHeaderField: HTTP_HEADER_FIELD)

                        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                            if error == nil {
                                if let data = data,
                                   let aPIDataArray = try? JSONDecoder().decode([APIData].self, from: data) {
                                    print(aPIDataArray,"nope")
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
            print(self.aPIDataArray)
    }
        
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        numView.alpha = 0
        
       
    }


}

