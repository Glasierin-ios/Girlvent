//
//  ForgotPasswordVc.swift
//  Girlvent
//
//  Created by Glasier Inc. on 24/12/19.
//  Copyright © 2019 Glasier Inc. All rights reserved.
//

import UIKit
import UITextField_Shake
import CDAlertView

class ForgotPasswordVc: UIViewController {

    //MARK:- Outlets
    @IBOutlet weak var TitleLable: UILabel!
    @IBOutlet weak var ForBack: UIButton!
    @IBOutlet weak var EmailTxt: UITextField!
    @IBOutlet weak var SendButton: UIButton!
    
    
    
    //MARK:- ViewLifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        TitleLable.text = GLocalizedString(key: "fp_Title")
        EmailTxt.placeholder = GLocalizedString(key: "fp_EmailAddress")
        SendButton.setTitle(GLocalizedString(key: "fp_SendPasswordLink"), for: .normal)
    }
    
    @IBAction func ForBackButtonclick(_ sender: Any) {
        
        
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func SendButtonClick(_ sender: Any) {
        if CheckFields()
                     {
                       sendforgotAPICall()
                     }
              
    }
    
    
    //MARK:- == FUNCTION FOR Forgot PAssword API ==
    func sendforgotAPICall(){
        //let TokenId = UserDefaults.value(forKey: "TokenId") as! String
        
        
        let param = [
            "email":EmailTxt.text!
            ] as [String : AnyObject]
        
        print(param)
        
        APIHelper.shared.ForgotPasswordAPIcall(parameter: param) { (success, result) in
            
            if(result.data != nil){
                if(success){
                  
                  
                  let alert = CDAlertView(title: GLocalizedString(key: "Success"), message: GLocalizedString(key: "SentResetLink"), type: .success)
                                                                          let doneAction = CDAlertViewAction(title: GLocalizedString(key: "OK"), font: nil, textColor: UIColor.black, backgroundColor: UIColor.white) { (doneAction) -> Bool in

                                                                            self.EmailTxt.text = ""
                                                                            self.navigationController?.popViewController(animated: true)
                                                                              print(result)
                                                                              return true
                                                                          }
                                                                          alert.add(action: doneAction)
                                                                          alert.circleFillColor = ALERT_COLOR
                                                                          alert.show()
                  
              
                }
            } else{
                
             
                print("Not Success")
            }
        }
        
    }
    
     // MARK: - Functions
           func CheckFields() -> Bool
           {
               
               if (EmailTxt.text?.trimmingCharacters(in: .whitespaces).isEmpty)!
               {
                   self.EmailTxt.shake(10,withDelta: 5.0,speed: 0.03,shakeDirection: ShakeDirection.horizontal)
                   
                   let alert = CDAlertView(title: GLocalizedString(key: "Hang On"), message: GLocalizedString(key: "ValidEmail"), type: .warning)
                   let doneAction = CDAlertViewAction(title: GLocalizedString(key: "OK"), font: nil, textColor: UIColor.black, backgroundColor: UIColor.white) { (doneAction) -> Bool in
                       return true
                   }
                   alert.add(action: doneAction)
                   alert.circleFillColor = ALERT_COLOR
                   alert.show()
                   let test = false
                   return test
               }
               else if !(HELPER.sharedInstance.isValidEmail(testStr:EmailTxt.text!))
               {
                   self.EmailTxt.shake(10,withDelta: 5.0,speed: 0.03,shakeDirection: ShakeDirection.horizontal)
                   
                   let alert = CDAlertView(title: "Hang On!", message: GLocalizedString(key: "ValidEmail"), type: .warning)
                   let doneAction = CDAlertViewAction(title: GLocalizedString(key: "OK"), font: nil, textColor: UIColor.black, backgroundColor: UIColor.white) { (doneAction) -> Bool in
                       return true
                   }
                   alert.add(action: doneAction)
                   alert.circleFillColor = ALERT_COLOR
                   alert.show()
                   let test = false
                   return test
               }
      
               let test = true
               return test
           }
    
    

}
