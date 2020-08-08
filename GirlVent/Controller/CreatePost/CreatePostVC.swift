//
//  CreatePostVC.swift
//  Girlvent
//
//  Created by Glasier Inc. on 01/01/20.
//  Copyright © 2020 Glasier Inc. All rights reserved.
//

import UIKit
import UITextField_Shake
import CDAlertView
import UITextView_Placeholder

class CreatePostVC: UIViewController {

    //MARK:- Outlets
    @IBOutlet weak var MsgPostCancelButton: UIButton!
    @IBOutlet weak var CatagoryListButton: UIButton!
    @IBOutlet weak var TextTextview: UITextView!
    @IBOutlet weak var MsgPostButton: UIButton!
    @IBOutlet weak var SelectCategoriesTxt: UITextField!
    
    @IBOutlet var lblCreatePost: UILabel!
    
    
    
    
    //MARK:- Variables
    let categoriesListPicker = UIPickerView()
    var selectedcategoriid = 0
    var  categoriesListArray = [GetCategoriesListData]()
    
    var textforEditString = ""
    var wheretoCome = 0
    var postidString = 0
    
    
    
    //MARK:- ViewLifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblCreatePost.text = GLocalizedString(key: "CreatePost")
        CatagoryListButton.setTitle(GLocalizedString(key: "NewsFeed"), for: .normal)
        SelectCategoriesTxt.text = GLocalizedString(key: "NewsFeed")
        TextTextview.placeholder = GLocalizedString(key: "PostTextView")
        MsgPostButton.setTitle(GLocalizedString(key: "Post"), for: .normal)
        
        
        
        
       // categoriesListPicker.tintColor = ALERT_COLOR
          categoriesListPicker.setValue(ALERT_COLOR, forKeyPath: "textColor")

        GetCategoriesListAPI()
        
        if wheretoCome == 0{
                   
                   
               }else{
                   TextTextview.text = textforEditString
               }
        
        
        SelectCategoriesTxt.inputView = categoriesListPicker
        categoriesListPicker.delegate = self
    }
    // self.dismiss(animated: true, completion: nil)
    
    @IBAction func MsgPostCancelButtonClick(_ sender: Any) {
        let savedata =  UserDefaults.init(suiteName: "group.com.Glasierinc.Girlventdemo")
        savedata?.removeObject(forKey: "Text")
        self.navigationController?.popViewController(animated: true)
        
    }
    @IBAction func CatagoryListButtonClick(_ sender: Any) {
        

        //dropper.showWithAnimation(0.15, options: .center, button: CatagoryListButton)

    }
    @IBAction func MsgPostButtonClick(_ sender: Any) {
        
        if wheretoCome == 0{
            
            if TextTextview.text == ""{
                let alert = CDAlertView(title: "GirlVent", message: "Please write something!", type: .error)
                                     let doneAction = CDAlertViewAction(title: "Ok", font: nil, textColor: UIColor.black, backgroundColor: UIColor.white) { (doneAction) -> Bool in

                                         return true
                                     }
                                     alert.add(action: doneAction)
                                     alert.circleFillColor = ALERT_COLOR
                                     alert.show()
                
            }else{
                
                   SubmitPostTextAPI()
            }
                         
                          
               }else{
                   UpdatePostTextAPI()
                   
               }
        
    
        
        
    }
    //MARK:- == FUNCTION FOR Update POST API ==
                   func UpdatePostTextAPI(){
                       //let TokenId = UserDefaults.value(forKey: "TokenId") as! String
                       
                       
                       let param = [
                           "type":"youtube",
                           "content":TextTextview.text!,
                           "language":"english",
                           "forum_id" : selectedcategoriid,
                           "post_id": postidString
                           ] as [String : AnyObject]
                       
                       print(param)
                       
                       APIHelper.shared.UpdatePostAPIcall(parameter: param) { (success, result) in
                           
                           
                               if(success){
                                      self.navigationController?.popViewController(animated: true)
          //                         let alert = CDAlertView(title: "Congratulations", message: result.message, type: .success)
          //                                                                                 let doneAction = CDAlertViewAction(title: "Ok", font: nil, textColor: UIColor.black, backgroundColor: UIColor.white) { (doneAction) -> Bool in
          //
          //
          //                                                                                     return true
          //                                                                                 }
          //                                                                                 alert.add(action: doneAction)
          //                                                                                 alert.circleFillColor = ALERT_COLOR
          //                                                                                 alert.show()
                             
                               }else{
                               
                            
                               print("Not Success")
                           }
                       }
              }
    
    //MARK:- == FUNCTION FOR Submit POST API ==
         func SubmitPostTextAPI(){
             //let TokenId = UserDefaults.value(forKey: "TokenId") as! String
             
             
             let param = [
                 "type":"text",
                 "content":TextTextview.text!,
                 "language":"english",
                 "forum_id" : selectedcategoriid
                 ] as [String : AnyObject]
             
             print(param)
             
             APIHelper.shared.SubmitHomeTextPostAPIcall(parameter: param) { (success, result) in
                 
                 
                     if(success){
                       
                        self.navigationController?.popViewController(animated: true)
//                         let alert = CDAlertView(title: "Congratulations", message: result.message, type: .success)
//                                                                                 let doneAction = CDAlertViewAction(title: "Ok", font: nil, textColor: UIColor.black, backgroundColor: UIColor.white) { (doneAction) -> Bool in
//
//
//                                                                                     return true
//                                                                                 }
//                                                                                 alert.add(action: doneAction)
//                                                                                 ALERT_COLOR
//                                                                                 alert.show()
                   
                     }else{
                     
                  
                     print("Not Success")
                 }
             }
    }
            

    //MARK:- == FUNCTION FOR GET Categories POST API ==
         func GetCategoriesListAPI(){
             //let TokenId = UserDefaults.value(forKey: "TokenId") as! String
             
             
            let param = [:] as [String : AnyObject]
             
             print(param)
             
             APIHelper.shared.GetCategoriesListAPIcall(parameter: param) { (success, result) in
                 
                 if(result.data != nil){
                     if(success){
                      
                        self.categoriesListArray = result.data
                        if self.wheretoCome == 1{
                                                     for obj in self.categoriesListArray{
                                                         if obj.id == self.selectedcategoriid{
                                                             self.CatagoryListButton.setTitle(obj.name, for: .normal)
                                                            self.SelectCategoriesTxt.text = obj.name
                                                         }
                                                     }
                                                 }
                     }
                 } else{
                     
                  
                     print("Not Success")
                 }
             }
    }
}
extension CreatePostVC : UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
       
            
               return categoriesListArray.count + 1
       
      
    }
    // MARK: UIPickerView Delegation

    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
       
                  
        if row == 0{
            
             return "News feed"
        }else{
             return categoriesListArray[row - 1].name
        }
        
       
             
        
       
    }

    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
  
                if row == 0{
                      
                      SelectCategoriesTxt.text =  "News feed"
                    selectedcategoriid = 0
                  }else{
                       SelectCategoriesTxt.text =  categoriesListArray[row - 1].name
                    selectedcategoriid = categoriesListArray[row - 1].id
                  }
           

 
    }
    
    
}
