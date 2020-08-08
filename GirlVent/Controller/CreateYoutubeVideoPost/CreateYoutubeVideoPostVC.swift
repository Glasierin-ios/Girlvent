//
//  CreateYoutubeVideoPostVC.swift
//  Girlvent
//
//  Created by Glasier Inc. on 01/01/20.
//  Copyright © 2020 Glasier Inc. All rights reserved.
//

import UIKit
import UITextField_Shake
import CDAlertView
import UITextView_Placeholder

class CreateYoutubeVideoPostVC: UIViewController {

    //MARK:- Outlets
    @IBOutlet weak var YouPostCancelButton: UIButton!
    @IBOutlet weak var YouCatategoryListButton: UIButton!
    @IBOutlet weak var YouTextTextview: UITextView!
    @IBOutlet weak var YoutubeLinkTextfiled: UITextField!
    @IBOutlet weak var YouPostButton: UIButton!
    @IBOutlet weak var SelectCategoriesTxt: UITextField!
    
    @IBOutlet var lblCreatePost: UILabel!
    @IBOutlet var lblExample: UILabel!
    
    
    
    
    //MARK:- Variables
    let categoriesListPicker = UIPickerView()
    var selectedcategoriid = 0
    var  categoriesListArray = [GetCategoriesListData]()
    
    var textforEditString = ""
    var linkforEditStirng = ""
    var wheretoCome = 0
    var postidString = 0
    
    
    //MARK:- ViewLifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()

        
        lblCreatePost.text = GLocalizedString(key: "CreatePost")
        YouCatategoryListButton.setTitle(GLocalizedString(key: "NewsFeed"), for: .normal)
        SelectCategoriesTxt.text = GLocalizedString(key: "NewsFeed")
        YouTextTextview.placeholder = GLocalizedString(key: "PostTextView")
        YoutubeLinkTextfiled.placeholder = GLocalizedString(key: "YoutubeLink")
        lblExample.text = GLocalizedString(key: "LinkExample")
        YouPostButton.setTitle(GLocalizedString(key: "Post"), for: .normal)
        
        categoriesListPicker.setValue(ALERT_COLOR, forKeyPath: "textColor")
        
        if wheretoCome == 0{
            
            
        }else{
            YouTextTextview.text = textforEditString
                  YoutubeLinkTextfiled.text = linkforEditStirng
        }
       GetCategoriesListAPI()
        SelectCategoriesTxt.inputView = categoriesListPicker
                   categoriesListPicker.delegate = self
        
        
        
        // Do any additional setup after loading the view.
    }
    @IBAction func YouPostCancelButtonClick(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func YouCatategoryListButtonClick(_ sender: Any) {
    }
    @IBAction func YouPostButtonClick(_ sender: Any) {
        //
        if YoutubeLinkTextfiled.text == ""{
                     let alert = CDAlertView(title: "GirlVent", message: "Please Enter Youtube url.", type: .error)
                              let doneAction = CDAlertViewAction(title: "Ok", font: nil, textColor: UIColor.black, backgroundColor: UIColor.white) { (doneAction) -> Bool in

                                  return true
                              }
                              alert.add(action: doneAction)
                              alert.circleFillColor = ALERT_COLOR
                              alert.show()
                 }else{
                        if wheretoCome == 0{
                            SubmitPostTextAPI()
                        }else{
                            UpdatePostTextAPI()
                }
            }
        
    }
    //MARK:- == FUNCTION FOR Submit POST API ==
         func SubmitPostTextAPI(){
             //let TokenId = UserDefaults.value(forKey: "TokenId") as! String
             
             
             let param = [
                 "type":"youtube",
                 "content":YouTextTextview.text!,
                 "language":"english",
                 "forum_id" : selectedcategoriid,
                 "link": YoutubeLinkTextfiled.text!
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
//                                                                                 alert.circleFillColor = ALERT_COLOR
//                                                                                 alert.show()
                   
                     }else{
                     
                  
                     print("Not Success")
                 }
             }
    }
            //MARK:- == FUNCTION FOR Update POST API ==
                   func UpdatePostTextAPI(){
                       //let TokenId = UserDefaults.value(forKey: "TokenId") as! String
                       
                       
                       let param = [
                           "type":"youtube",
                           "content":YouTextTextview.text!,
                           "language":"english",
                           "forum_id" : selectedcategoriid,
                           "youtube_link": YoutubeLinkTextfiled.text!,
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
                                        self.YouCatategoryListButton.setTitle(obj.name, for: .normal)
                                        self.SelectCategoriesTxt.text = obj.name
                                    }
                                }
                            }
                           
                            
                           }
                       } else{
                       }
                   }
          }

}
extension CreateYoutubeVideoPostVC : UIPickerViewDelegate, UIPickerViewDataSource{
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
