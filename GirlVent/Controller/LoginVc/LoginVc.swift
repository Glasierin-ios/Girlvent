//
//  LoginVc.swift
//  Girlvent
//
//  Created by Glasier Inc. on 20/12/19.
//  Copyright © 2019 Glasier Inc. All rights reserved.
//

import UIKit
import PasswordTextField
import UITextField_Shake
import CDAlertView
import SideMenu

class LoginVc: UIViewController {

    //MARK:- Outlets
    @IBOutlet weak var EmailTxt: UITextField!
    @IBOutlet weak var PasswordTxt: PasswordTextField!
    @IBOutlet weak var RegisternowButton: UIButton!
    
    @IBOutlet weak var ForgotPassButton: UIButton!
    @IBOutlet weak var SigninButton: UIButton!
    
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblLogin: UILabel!
    
    
    
    
    
    
    //MARK:- ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        
        EmailTxt.PaddingViewadd(EmailTxt)
        PasswordTxt.PaddingViewadd(PasswordTxt)
        PasswordTxt.showButtonWhile = .Always
  
       
        lblTitle.text = GLocalizedString(key: "login_Title")
        lblLogin.text = GLocalizedString(key: "login_Login")
        EmailTxt.placeholder = GLocalizedString(key: "login_Email")
        PasswordTxt.placeholder = GLocalizedString(key: "login_Password")
        
        RegisternowButton.setTitle(GLocalizedString(key: "login_RegisterNow"), for: .normal)
        ForgotPassButton.setTitle(GLocalizedString(key: "login_ForgotPassword"), for: .normal)
        SigninButton.setTitle(GLocalizedString(key: "login_SignIn"), for: .normal)
        
    }
    

    //MARK:- ButtonActions
    @IBAction func RegisternowButtonClick(_ sender: Any) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                       let therapiescall = storyBoard.instantiateViewController(withIdentifier: "RegisterVcpuch") as! RegisterVc
                       self.navigationController?.pushViewController(therapiescall, animated: true)
    }
    @IBAction func ForgotPassButtonClick(_ sender: Any) {
        
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                           let therapiescall = storyBoard.instantiateViewController(withIdentifier: "ForgotPasswordVcpuch") as! ForgotPasswordVc
                           self.navigationController?.pushViewController(therapiescall, animated: true)
        
        
    }
    @IBAction func SigninButtonClick(_ sender: Any) {
        
        
             if CheckFields()
               {
                 getLoginResult()
               }
        
    
        
    }
    //MARK:- == FUNCTION FOR LOGIN API ==
      func getLoginResult(){
          //let TokenId = UserDefaults.value(forKey: "TokenId") as! String
          
          
          let param = [
              "username":EmailTxt.text!,
              "password":PasswordTxt.text!,
              "devicetoken":"iphone",
              "device_token" : App_Delegate.toekn
              ] as [String : AnyObject]
          
          print(param)
          
          APIHelper.shared.loginAPIcall(parameter: param) { (success, result) in
              
              if(result.data != nil){
                  if(success){
                    
                    
                  
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                    let therapiescall = storyBoard.instantiateViewController(withIdentifier: "HomeViewVCpuch") as! HomeViewVC
                    self.navigationController?.pushViewController(therapiescall, animated: true)
                    HELPER.saveUserSession(u: result.data)
                    UserDefaults.standard.set(result.data.profilePicUrl, forKey: GlobalDefaultsKey.KUserMainImage)
                    UserDefaults.standard.set(result.data.username, forKey: GlobalDefaultsKey.KUserMainName)
                    
                
                  }else{
                    let alert = CDAlertView(title: nil, message: result.message, type: .error)
                                  let doneAction = CDAlertViewAction(title: "Ok", font: nil, textColor: UIColor.black, backgroundColor: UIColor.white) { (doneAction) -> Bool in
                                      return true
                                  }
                                  alert.add(action: doneAction)
                                  alert.circleFillColor = ALERT_COLOR
                                  alert.show()
                    
                }
              } else{
                  let alert = CDAlertView(title: nil, message: result.message, type: .error)
                                                 let doneAction = CDAlertViewAction(title: "Ok", font: nil, textColor: UIColor.black, backgroundColor: UIColor.white) { (doneAction) -> Bool in
                                                     return true
                                                 }
                                                 alert.add(action: doneAction)
                                                 alert.circleFillColor = ALERT_COLOR
                                                 alert.show()
               
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
               
               let alert = CDAlertView(title: GLocalizedString(key:"Hang On"), message: GLocalizedString(key: "ValidEmail"), type: .warning)
               let doneAction = CDAlertViewAction(title: GLocalizedString(key:"OK"), font: nil, textColor: UIColor.black, backgroundColor: UIColor.white) { (doneAction) -> Bool in
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
               
               let alert = CDAlertView(title: GLocalizedString(key:"Hang On"), message: GLocalizedString(key: "ValidEmail"), type: .warning)
               let doneAction = CDAlertViewAction(title: GLocalizedString(key:"OK"), font: nil, textColor: UIColor.black, backgroundColor: UIColor.white) { (doneAction) -> Bool in
                   return true
               }
               alert.add(action: doneAction)
               alert.circleFillColor = ALERT_COLOR
               alert.show()
               let test = false
               return test
           }
           else if (PasswordTxt.text?.trimmingCharacters(in: .whitespaces).isEmpty)!
           {
               self.PasswordTxt.shake(10,withDelta: 5.0,speed: 0.03,shakeDirection: ShakeDirection.horizontal)
               
               let alert = CDAlertView(title: GLocalizedString(key:"Hang On"), message: GLocalizedString(key:"EnterPassword"), type: .warning)
               let doneAction = CDAlertViewAction(title: GLocalizedString(key:"OK"), font: nil, textColor: UIColor.black, backgroundColor: UIColor.white) { (doneAction) -> Bool in
                   return true
               }
               alert.add(action: doneAction)
               alert.circleFillColor = ALERT_COLOR
               alert.show()
               let test = false
               return test
           }else if PasswordTxt.text!.count <= 5 {
               self.PasswordTxt.shake(10,withDelta: 5.0,speed: 0.03,shakeDirection: ShakeDirection.horizontal)
               
               let alert = CDAlertView(title: GLocalizedString(key:"Hang On"), message: GLocalizedString(key:"PasswordValidationMessage"), type: .warning)
               let doneAction = CDAlertViewAction(title: GLocalizedString(key:"OK"), font: nil, textColor: UIColor.black, backgroundColor: UIColor.white) { (doneAction) -> Bool in
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
