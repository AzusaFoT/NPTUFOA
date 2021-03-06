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
    //var item: [APIData] = []
    
    struct APIData: Codable {
        var name: String?
        var meals: String?
        var studentNum: String?
        var time: String?
        var serialNum: Int?
        var mealsok : String?
        var takeok : String?
    }
    
    struct nData: Codable {
        var studentNum: String?
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
    var sNO :String = "⍩"
    
    
    
    //titleView
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var bTitle: UILabel!
    @IBOutlet weak var sTitle: UILabel!

    //numView
    @IBOutlet weak var numView: UIView!
    @IBOutlet weak var serialNumL: UILabel!
    @IBAction func renew(_ sender: Any) {
        self.getSheetDB()
        self.searchArrayData()
        self.sTitle.text = "請稍候"
        self.bTitle.text = "Loading......"
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 5) {
            self.serialNumL.text = self.sNO
            self.bTitle.text = "以下為取餐流水編號"
            self.sTitle.text = self.studentID
        }
    }
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
            self.getSheetDB()
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                //延遲一秒
                self.numView.alpha = 1
                self.bTitle.text = "以下為取餐流水編號"
                //self.serialNumL.text = self.searchArrayData()
                self.serialNumL.text = "⍩"
                self.sTitle.text = self.studentID
            }
            
            
        }
        else{
            displayAlert(title: "請輸入學號", message: "未輸入學號造成的錯誤")
        }
    }
    
    
    
    // 警告視窗
    func displayAlert(title: String,message: String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(alertAction)
        self.present(alertController,animated: true,completion: nil)
    }
    func searchArrayData() {
        var serialNumBack : String =  "⍩"
        var flag :Int = 0
        self.getSheetDB()
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 5) {
        var array = self.aPIDataArray
            
        for i in 0...499{
        
            let studentNum : String = (array[i].studentNum)! as String
            let serialNum :String = String(array[i].serialNum!)
            let takeok : String = array[i].takeok! as String
            
            // testzone
            //print(takeok)
            //print(studentNum,1)
            
            // break
            if (studentNum == ""){
                break
            }
            // break
            
            if(studentNum == self.studentID){
                if (takeok == "false")
                {
                    //有這筆資料要給一個flag
                    flag = 1
                    self.sNO = serialNum
                    self.serialNumL.text = serialNum
                    // testzone
                    //print(self.sNO)
                    //print(array[i])
                }
            }
            
        }
        
        if(flag == 0 && serialNumBack == "⍩"){
            print("we have no DATA, plz check your studentID.")
        }
        else{
            //U資料
            //print(array[Int(serialNumBack)!-1])
        }
        
            
            
        }
       
        
        
    }
    
    
    func getSheetDB(){
        print("sheet BD")
        //let urlSheetDB = "https://docs.google.com/spreadsheets/d/1mo-a7TcJkJ7B-77jR5aBqLu1lBiY38RRHeOCG5chHCs/edit#gid=1754583349"
        let urlGAS = "https://script.google.com/a/nptu.edu.tw/macros/s/AKfycbyZT0f_ksAC5O57eLaWIDTP_uIVVeT4k9GEY8PfoQ/exec"
        let apiUrl = urlGAS
        
        if let urlApi = URL(string: apiUrl){
            var urlRequest = URLRequest(url: urlApi)
                        urlRequest.httpMethod = HTTP_METHOD_GET
                        urlRequest.setValue(CONTENT_TYPE, forHTTPHeaderField: HTTP_HEADER_FIELD)

                        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                            if error == nil {
                                if let data = data,let aPIDataArray = try? JSONDecoder().decode([APIData].self, from: data) {
                                    
                                    self.aPIDataArray = aPIDataArray
                                    //print(self.aPIDataArray)
                                    //self.searchArrayData(array: self.aPIDataArray)
                                    
                                    
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

