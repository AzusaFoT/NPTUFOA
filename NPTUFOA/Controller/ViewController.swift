//
//  ViewController.swift
//  NPTUFOA
//
//  Created by students on 2022/5/20.
//

import UIKit

class ViewController: UIViewController {
    
    struct SearchResponse: Codable {
        let resultCount: Int?
        let results: [APIData]
    }
    var item: [APIData] = []
    
    struct APIData: Codable {
        var name: String?
        var meals: String?
        var studentNum: String?
        var time: String?
        var serialNum: Int?
        var maalsok : String?
        var takeok : String?
    }
    var str1:String = ""
    
    let logoImage = UIImageView()
    
    let HTTP_METHOD_GET = "GET"
    let CONTENT_TYPE = "application/json"
    let HTTP_HEADER_FIELD = "Content-Type"
    var studentID : String = ""
    var aPIDataArray : [APIData] = []
    
    
    
    
    //titleView
    @IBOutlet weak var titleView: UIView!
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
    @IBOutlet weak var loginView: UIView!
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
        /*for i in (1...500){
            if item[i]["serialNum"] == studentNumBox.text {
                serialNum = String(i)
            }
        }綠茶
        */
        getSheetDB()
        //fetchItem()
        
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
        print("sheet BD")
        //let urlSheetDB = "https://docs.google.com/spreadsheets/d/1mo-a7TcJkJ7B-77jR5aBqLu1lBiY38RRHeOCG5chHCs/edit#gid=1754583349"
        let urlGAS = "https://script.google.com/macros/s/AKfycbxO7o3jJFms2ZOgItEuPGeOrW-KMMhIr_RZoRGs7tVYv1FlOtFE/exec"
        let apiUrl = urlGAS
        
        if let urlApi = URL(string: apiUrl){
            var urlRequest = URLRequest(url: urlApi)
                        urlRequest.httpMethod = HTTP_METHOD_GET
                        urlRequest.setValue(CONTENT_TYPE, forHTTPHeaderField: HTTP_HEADER_FIELD)

                        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                            if error == nil {
                                if let data = data,let aPIDataArray = try? JSONDecoder().decode([APIData].self, from: data) {
                                    
                                    self.aPIDataArray = aPIDataArray
                                    print(self.aPIDataArray,"nope")
                                    DispatchQueue.main.async {
                                        print("reload?")
                                    }
                                    
                                    //print(type(of: aPIDataArray))
                                    
                                    //let text = JSONDecoder.Input().base64EncodedString()
                                    
                                    //self.serialNumL.text = self.visit(data: text, userID: self.studentNumBox.text!)
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
        }else{
            print("NO")
        }
        
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        numView.alpha = 0
        titleView.alpha = 0
        loginView.alpha = 0
        
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        logoImage.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
        logoImage.image = UIImage(named: "ICON")
        logoImage.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        logoImage.center = view.center
        
        view.addSubview(logoImage)
        
        
        
       
    }
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 1) {
            self.logoImage.frame = CGRect(x: 0, y: 0, width: 120, height: 120)
            self.logoImage.center = self.view.center
        } completion: { (aniFin) in
            UIView.animate(withDuration: 0.5) {
                self.logoImage.frame = CGRect(x: 0, y: 0, width: 5000, height: 5000)
                self.logoImage.center = self.view.center
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
                    self.titleView.alpha = 1
                    self.loginView.alpha = 1
                }
                self.logoImage.alpha = 0
            }
        }
        

    }

}

