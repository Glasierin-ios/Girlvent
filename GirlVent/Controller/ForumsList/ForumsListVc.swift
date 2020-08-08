//
//  ForumsListVc.swift
//  Girlvent
//
//  Created by Glasier Inc. on 30/01/20.
//  Copyright © 2020 Glasier Inc. All rights reserved.
//

import UIKit
import UITextField_Shake
import CDAlertView
import UITextView_Placeholder

class ForumsListVc: UIViewController {

    
    @IBOutlet weak var CreateForumsView: UIView!
    @IBOutlet weak var ForumListTableView: UITableView!
    
    @IBOutlet weak var CreateForumCancelBtn: UIButton!
    @IBOutlet weak var ForumBackBtn: UIButton!
    
    var ForumTitleListarray = [ForumListData]()
    var ForumTitleListarraysearch = [ForumListData]()
    var otherusertype = 0
    
    @IBOutlet weak var CreateForumTitleTxt: UITextField!
    @IBOutlet weak var CreateForumContainTextview: UITextView!
    
    @IBOutlet weak var CreateForumLastCancelBtn: UIButton!
    @IBOutlet weak var CreateForumPostBtn: UIButton!
    @IBOutlet weak var SearchTxt: UITextField!
    @IBOutlet weak var AddNewBtn: UIButton!
    
    
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblNewForum: UILabel!
    @IBOutlet var lblSubject: UILabel!
    @IBOutlet var lblReplies: UILabel!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()

        lblTitle.text = GLocalizedString(key: "menu_Forums")
        SearchTxt.placeholder = GLocalizedString(key: "fl_Search")
        AddNewBtn.setTitle(GLocalizedString(key: "fl_ AddNewForum"), for: .normal)
        lblSubject.text = GLocalizedString(key: "fl_Subject")
        lblReplies.text = GLocalizedString(key: "fl_Replies")
        lblNewForum.text = GLocalizedString(key: "fl_New Forum")
        CreateForumTitleTxt.placeholder = GLocalizedString(key: "fl_Title")
        CreateForumContainTextview.placeholder = GLocalizedString(key: "fl_Content")
        CreateForumPostBtn.setTitle(GLocalizedString(key: "fl_Create"), for: .normal)
        CreateForumLastCancelBtn.setTitle(GLocalizedString(key: "Cancel"), for: .normal)
        
        
           CreateForumsView.isHidden = true
       
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
         GetForumTitleAPICall()
    }
    @IBAction func SearchTxtValueChagedMethod(_ sender: Any) {
        
        updateSearchArray(searchTextString: SearchTxt.text ?? "")
    }
    @IBAction func AddNewBtnClick(_ sender: Any) {
        self.CreateForumTitleTxt.text = ""
                                   self.CreateForumContainTextview.text = ""
           CreateForumsView.isHidden = false
       }
    @IBAction func CreateForumPostBtnClick(_ sender: Any) {
        
        if CheckFields(){
            
            CreateForumTitleAPICall()
                   CreateForumsView.isHidden = true
        }
    
    }
    @IBAction func CreateForumLastCancelBtnClick(_ sender: Any) {
        
        
        CreateForumsView.isHidden = true
    }
    @IBAction func CreateForumsCancelBtnClick(_ sender: Any) {
           CreateForumsView.isHidden = true
    }
    @IBAction func ForumBackBtnClick(_ sender: Any) {
          
        self.navigationController?.popViewController(animated: true)
          
      }
      func CheckFields() -> Bool{
        

            if (CreateForumTitleTxt.text?.trimmingCharacters(in: .whitespaces).isEmpty)!
           {
               self.CreateForumTitleTxt.shake(10,withDelta: 5.0,speed: 0.03,shakeDirection: ShakeDirection.horizontal)
               
               let alert = CDAlertView(title: GLocalizedString(key: "Hang On"), message: GLocalizedString(key: "EnterForumTitle"), type: .warning)
               let doneAction = CDAlertViewAction(title: GLocalizedString(key: "OK"), font: nil, textColor: UIColor.black, backgroundColor: UIColor.white) { (doneAction) -> Bool in
                   return true
               }
               alert.add(action: doneAction)
               alert.circleFillColor = ALERT_COLOR
               alert.show()
               let test = false
               return test
           }
            if (CreateForumContainTextview.text?.trimmingCharacters(in: .whitespaces).isEmpty)!
                        {
                            
                            
                            let alert = CDAlertView(title: GLocalizedString(key: "Hang On"), message: GLocalizedString(key: "WriteSomeContent"), type: .warning)
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
    //MARK:- == FUNCTION FOR Create Forum Title  API ==
            func CreateForumTitleAPICall(){
                      //let TokenId = UserDefaults.value(forKey: "TokenId") as! String
                      
                      
                      let param = [
                          "language":"english",
                          "title":CreateForumTitleTxt.text!,
                          "content":CreateForumContainTextview.text!
                          ] as [String : AnyObject]
                      
                      print(param)
                      
                      APIHelper.shared.CreateForumAPIcall(parameter: param) { (success, result) in
                          
                     
                              if(success){
                                self.CreateForumTitleTxt.text = ""
                                self.CreateForumContainTextview.text = ""
                                self.GetForumTitleAPICall()
                               
                                                        
                                  
                                  
                                 }
                         
                      }
                      
                  }
    
     //MARK:- == FUNCTION FOR get Forum Title List API ==
             func GetForumTitleAPICall(){
                       //let TokenId = UserDefaults.value(forKey: "TokenId") as! String
                       
                       
                       let param = [
                           "language":"english"
                           ] as [String : AnyObject]
                       
                       print(param)
                       
                       APIHelper.shared.GetForumListAPIcall(parameter: param) { (success, result) in
                           
                      
                               if(success){
                               
                                   self.ForumTitleListarray = result.data
                                self.ForumTitleListarraysearch = result.data
                                self.otherusertype = result.userType
                                                         self.ForumListTableView.reloadData()
                                   
                                   
                                  }
                          
                       }
                       
                   }
    

}
extension ForumsListVc : UITableViewDelegate , UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return ForumTitleListarraysearch.count
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ForumsListCell") as! ForumsListCell
        cell.selectionStyle = .none
     
        cell.ForumTitledata = self.ForumTitleListarraysearch[indexPath.row]
        
        
     
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                      let therapiescall = storyBoard.instantiateViewController(withIdentifier: "ForumDetilsVc") as! ForumDetilsVc
        therapiescall.forumids = self.ForumTitleListarraysearch[indexPath.row].forumId
        therapiescall.formtokan = self.ForumTitleListarraysearch[indexPath.row].token
//        therapiescall.OtherUsertype = self.otherusertype
//        therapiescall.forumtitle = self.ForumTitleListarraysearch[indexPath.row].title
        
                     self.navigationController?.pushViewController(therapiescall, animated: true)
        
        
        
    }
    
    
}
extension ForumsListVc
{
    //MARK:- Search
   
    func updateSearchArray(searchTextString: String) {
        
        if (!searchTextString.isEmpty) {
           
                self.ForumTitleListarraysearch = self.ForumTitleListarray.filter({ (directory) -> Bool in
                                    
                    let data =  directory.title .contains(searchTextString.capitalized) || directory.title .contains(searchTextString) || directory.username .contains(searchTextString)  || directory.title .contains(searchTextString.capitalized) || directory.username .contains(searchTextString.capitalized)
                                             return data
                                    })
        }else
        {
         
                        self.ForumTitleListarraysearch.removeAll()
                        self.ForumTitleListarraysearch.append(contentsOf:self.ForumTitleListarray)
            
        
        }
         
           self.ForumListTableView.reloadData()
    }
}
