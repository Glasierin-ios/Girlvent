//
//  ForumDetilsVc.swift
//  Girlvent
//
//  Created by Glasier Inc. on 30/01/20.
//  Copyright © 2020 Glasier Inc. All rights reserved.
//

import UIKit
import UITextField_Shake
import CDAlertView
import Alamofire

class ForumDetilsVc: UIViewController {

  
    @IBOutlet weak var ForumsBackBtn: UIButton!
    @IBOutlet weak var ForumsTitleLable: UILabel!
    @IBOutlet weak var ForumsDetilsTableView: UITableView!
    
    @IBOutlet weak var ForumaddTextview: UITextView!
      @IBOutlet weak var ForumSendButton: UIButton!
    
     @IBOutlet weak var ActionForumButton: UIButton!
    
    @IBOutlet weak var RenameView: UIView!
    
    @IBOutlet var lblTitle: UILabel!
    
    
    
    
    
    var ForumreplayListarray = [ForumDetilsData]()
    var formtokan = ""
    var forumids = 0
    var renameison = "0"
    var responseEditid = 0
    var OtherUsertype = 0
    var forumtitle = ""
    var perentids = 0
    @IBOutlet weak var RenameCancelBtn: UIButton!
    @IBOutlet weak var RenameTextView: UITextView!
    @IBOutlet weak var RenameCancelLastBtn: UIButton!
    @IBOutlet weak var RenameDoneBtn: UIButton!
     @IBOutlet weak var RenameTitleLable: UILabel!
    
    
    
    
    var data : [CITreeViewData] = []
       //var treeView:CITreeView!
       
       let treeViewCellIdentifier = "TreeViewCellIdentifier"
       let treeViewCellNibName = "CITreeViewCell"

    
    
    @IBOutlet weak var sampleTreeView: CITreeView!
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lblTitle.text = GLocalizedString(key: "menu_Forums")
        ActionForumButton.setTitle(GLocalizedString(key: "fd_Action"), for: .normal)
        RenameTitleLable.text = GLocalizedString(key: "fd_RenameForum")
        RenameDoneBtn.setTitle(GLocalizedString(key: "fd_Rename"), for: .normal)
        RenameCancelLastBtn.setTitle(GLocalizedString(key: "Cancel"), for: .normal)
        
        
        
        
        data = CITreeViewData.getDefaultCITreeViewData()
        
        sampleTreeView.collapseNoneSelectedRows = false
        sampleTreeView.register(UINib(nibName: treeViewCellNibName, bundle: nil), forCellReuseIdentifier: treeViewCellIdentifier)
       
        
        
        let user:LoginData = HELPER.getSession()
                    
               
        if user.token == formtokan{
            ActionForumButton.isHidden = false
            
        }else{
            
       
            
        }
        RenameView.isHidden = true
             
       GetForumDetilsAPICall()
  
       
    }
    
    @IBAction func RenameDoneBtnClick(_ sender: Any) {
        
        if renameison == "0"{
            ForumsTitleLable.text = RenameTextView.text
          
                   ForumRenameAPICall()
           
        }else if renameison == "1"{
           
            EditReplyResponseAPICall()
           
        }else if renameison == "2"{
            
            if (RenameTextView.text?.trimmingCharacters(in: .whitespaces).isEmpty)!
                                 {
                                                                          
                                                                            
                                                                            let alert = CDAlertView(title: GLocalizedString(key: "Hang On"), message: GLocalizedString(key: "EnterText"), type: .warning)
                                                                            let doneAction = CDAlertViewAction(title: GLocalizedString(key: "OK"), font: nil, textColor: UIColor.black, backgroundColor: UIColor.white) { (doneAction) -> Bool in
                                                                                self.RenameView.isHidden = false
                                                                                return true
                                                                            }
                                                                            alert.add(action: doneAction)
                                                                            alert.circleFillColor = ALERT_COLOR
                                                                            alert.show()
                                                                           
                   }else{
                        ReplyResponseAPICall()
                       
                   }
                   
            
            
          
        }
       
         RenameView.isHidden = true
    }
    @IBAction func RenameCancelLastBtnClick(_ sender: Any) {
         RenameView.isHidden = true
    }
    @IBAction func RenameBtnClick(_ sender: Any) {
         RenameView.isHidden = true
    }
    @IBAction func ForumsBackBtnClick(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
        
      }
    @IBAction func ActionForumButtonClick(_ sender: Any) {
       

         let actionSheetController = UIAlertController(title:nil, message:nil, preferredStyle: UIAlertController.Style.actionSheet)
        
        
        
        if OtherUsertype == 0{
            let renameAction = UIAlertAction(title: GLocalizedString(key: "fd_Rename"), style: UIAlertAction.Style.default) { (action) -> Void in
                                                   
                
                
                                    self.renameison = "0"
                                    self.RenameDoneBtn.setTitle(GLocalizedString(key: "fd_Rename"), for: .normal)
                                    self.RenameTitleLable.text = GLocalizedString(key: "fd_RenameForum")
                                    self.RenameTextView.text = self.ForumsTitleLable.text
                                    self.RenameView.isHidden = false
                
                                               }
            renameAction.titleTextColor = UIColor(red: 224.0/255.0, green: 60.0/255.0, blue: 113.0/255.0, alpha: 1.0)

            actionSheetController.addAction(renameAction)

        }
        let deleteAction = UIAlertAction(title: GLocalizedString(key: "Delete"), style: UIAlertAction.Style.default) { (action) -> Void in
                                        let alert = CDAlertView(title: GLocalizedString(key: "Confirmation"), message:GLocalizedString(key: "fd_ForumDeleteConfirmation"), type: .warning)
                                                                   let doneAction = CDAlertViewAction(title: GLocalizedString(key: "OK"), font: nil, textColor: UIColor.black, backgroundColor: UIColor.white) { (doneAction) -> Bool in

                                                                       self.ForumDeleteAPICall()
                                                                       return true
                                                                   }
                                                                   let canleAction = CDAlertViewAction(title: GLocalizedString(key: "Cancel"), font: nil, textColor: UIColor.black, backgroundColor: UIColor.white) { (doneAction) -> Bool in
                                                               

                                                                       return true
                                                               
                                                                   }
                                                               alert.add(action: doneAction)
                                                               alert.add(action: canleAction)
                                                               alert.circleFillColor = ALERT_COLOR
                                                               alert.show()
                                        
                                    }

                                    let cancelAction = UIAlertAction(title: GLocalizedString(key: "Cancel"), style: UIAlertAction.Style.cancel) { (action) -> Void in
                                    }
                                   deleteAction.titleTextColor = UIColor(red: 224.0/255.0, green: 60.0/255.0, blue: 113.0/255.0, alpha: 1.0)
                                  cancelAction.titleTextColor = UIColor.darkGray
                            
                      
                                     actionSheetController.addAction(deleteAction)
                                  actionSheetController.addAction(cancelAction)
                                   present(actionSheetController, animated: true, completion: nil)
         
       }
    
    @IBAction func ForumSendButtonClick(_ sender: Any) {
        
        
        if (ForumaddTextview.text?.trimmingCharacters(in: .whitespaces).isEmpty)!
                      {
                                                               
                                                                 
                                                                 let alert = CDAlertView(title: GLocalizedString(key: "Hang On"), message: GLocalizedString(key: "EnterText"), type: .warning)
                                                                 let doneAction = CDAlertViewAction(title: GLocalizedString(key: "OK"), font: nil, textColor: UIColor.black, backgroundColor: UIColor.white) { (doneAction) -> Bool in
                                                                     return true
                                                                 }
                                                                 alert.add(action: doneAction)
                                                                 alert.circleFillColor = ALERT_COLOR
                                                                 alert.show()
                                                                
        }else{
          ForumReplyAPICall()
            
        }
        
       
       
        
    }
    //MARK:- == FUNCTION FOR  Forum Rename List API ==
                  func ForumRenameAPICall(){
                            //let TokenId = UserDefaults.value(forKey: "TokenId") as! String
                            
                            
                            let param = [
                                "language":"english",
                                "forum_id" :forumids,
                                "title": RenameTextView.text!
                                ] as [String : AnyObject]
                            
                            print(param)
                            
                            APIHelper.shared.ForumRenameAPIcall(parameter: param) { (success, result) in
                                
                           
                                    if(success){
                                     let alert = CDAlertView(title: GLocalizedString(key: "Success"), message: GLocalizedString(key: "ForumNameChange"), type: .success)
                                                                                                     let doneAction = CDAlertViewAction(title: GLocalizedString(key: "OK"), font: nil, textColor: UIColor.black, backgroundColor: UIColor.white) { (doneAction) -> Bool in

                                                                                                        self.RenameTextView.text = ""
                                                                                                         return true
                                                                                                     }
                                                                                                
                                                                                                 alert.add(action: doneAction)
                                                                                                
                                                                                                 alert.circleFillColor = ALERT_COLOR
                                                                                                 alert.show()
                                        
                                       }
                               
                            }
                            
                        }
    
    //MARK:- == FUNCTION FOR  Forum Delete List API ==
                 func ForumDeleteAPICall(){
                           //let TokenId = UserDefaults.value(forKey: "TokenId") as! String
                           
                           
                           let param = [
                               "language":"english",
                               "forum_id" :forumids
                               ] as [String : AnyObject]
                           
                           print(param)
                           
                           APIHelper.shared.ForumdeleteAPIcall(parameter: param) { (success, result) in
                               
                          
                                   if(success){
                                    self.navigationController?.popViewController(animated: true)
                                       
                                      }
                              
                           }
                           
                       }
    
    //MARK:- == FUNCTION FOR  Forum Reply List API ==
               func ForumReplyAPICall(){
                         //let TokenId = UserDefaults.value(forKey: "TokenId") as! String
                         
                         
                         let param = [
                             "language":"english",
                             "forum_id" :forumids,
                             "content" : ForumaddTextview.text!
                             ] as [String : AnyObject]
                         
                         print(param)
                         
                         APIHelper.shared.ForumReplyAPIcall(parameter: param) { (success, result) in
                             
                        
                                 if(success){
                                    self.ForumaddTextview.text = ""
                              
                                    self.GetForumDetilsAPICall()
                                     
                                    }
                            
                         }
                         
                     }
    
    //MARK:- == FUNCTION FOR get Forum Detils List API ==
              func GetForumDetilsAPICall(){
                        //let TokenId = UserDefaults.value(forKey: "TokenId") as! String
                        
                        
                        let param = [
                            "language":"english",
                            "forum_id" :forumids
                            ] as [String : AnyObject]
                        
                        print(param)
                        
                        APIHelper.shared.ForumDetilsListAPIcall(parameter: param) { (success, result) in
                            
                       
                                if(success){
                                
                                    self.ForumreplayListarray = result.data
                              
//                                    if OtherUsertype == 1{
//                                         ActionForumButton.isHidden = false
//                                     }else{
//                                         ActionForumButton.isHidden = true
//                                     }
//                                     self.ForumsTitleLable.text = forumtitle
                                    
                                    self.sampleTreeView.reloadData()
                                    
                                    
                                 //   DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                         self.sampleTreeView.expandAllRows()
                                 //   }
                                 
                                                      //    self.ForumsDetilsTableView.reloadData()
                               
                                    
                                   }
                           
                        }
                        
                    }
     
    //MARK:- == FUNCTION FOR Delete reply response API ==
       func DeleteReplyResponseAPICall(responsetid:Int){
             //let TokenId = UserDefaults.value(forKey: "TokenId") as! String
             
             
             let param = [
               "forum_post_id": responsetid
                 ] as [String : AnyObject]
             
             print(param)
             
             APIHelper.shared.ForumReplyDeleteResponseAPIcall(parameter: param) { (success, result) in
                 
                
                     if(success){
                
                         self.GetForumDetilsAPICall()
                     }
                 
             }
             
         }
    //MARK:- == FUNCTION FOR Edit reply response API ==
       func EditReplyResponseAPICall(){
             //let TokenId = UserDefaults.value(forKey: "TokenId") as! String
             
             
             let param = [
               "forum_post_id": responseEditid,
               "content" :RenameTextView.text!
                 ] as [String : AnyObject]
             
             print(param)
             
             APIHelper.shared.ForumReplyEditResponseAPIcall(parameter: param) { (success, result) in
                 
                
                     if(success){
                        self.responseEditid = 0
                        self.RenameTextView.text = ""
                         self.GetForumDetilsAPICall()
                     }
                 
             }
             
         }
    //MARK:- == FUNCTION FOR Edit reply response API ==
       func ReplyResponseAPICall(){
             //let TokenId = UserDefaults.value(forKey: "TokenId") as! String
             
             
             let param = [
               "forum_post_id": responseEditid,
               "content" :RenameTextView.text!,
               "forum_id":forumids,
               "forum_parent_id": perentids
                 ] as [String : AnyObject]
             
             print(param)
             
             APIHelper.shared.ForumReplyResponseAPIcall(parameter: param) { (success, result) in
                 
                
                     if(success){
                        self.responseEditid = 0
                        self.RenameTextView.text = ""
                         self.GetForumDetilsAPICall()
                     }
                 
             }
             
         }
 
}
extension ForumDetilsVc : UITableViewDelegate , UITableViewDataSource,ForumDetilsCellDelegate {
    func FourmDetilsMoreTapped(at index: IndexPath, fourm_Post_id: Int, prent_id: Int, Conten: String, Fourm_tokan: String) {
     
        
       
               let user:LoginData = HELPER.getSession()
               print(index)
               print(user.token!)
               let actionSheetController = UIAlertController(title:nil, message:nil, preferredStyle: UIAlertController.Style.actionSheet)
                           
        
        
               if user.token == Fourm_tokan{
                
                           let editAction = UIAlertAction(title: GLocalizedString(key: "fd_EditForumReply"), style: UIAlertAction.Style.default) { (action) -> Void in
                            
                            self.RenameDoneBtn.setTitle(GLocalizedString(key: "OK"), for: .normal)
                            self.RenameTitleLable.text = GLocalizedString(key: "Edit Message")
                            self.renameison = "1"
                            self.responseEditid = fourm_Post_id
                            print(prent_id)
                            self.perentids = prent_id
                            self.RenameTextView.text = Conten
                            self.RenameView.isHidden = false
                               
                           }
                           let deleteAction = UIAlertAction(title: GLocalizedString(key: "Delete"), style: UIAlertAction.Style.default) { (action) -> Void in
                               let alert = CDAlertView(title: GLocalizedString(key: "Confirmation"), message: GLocalizedString(key: "fd_ReplyDeleteConfirmation"), type: .warning)
                                                                                                let doneAction = CDAlertViewAction(title: GLocalizedString(key: "OK"), font: nil, textColor: UIColor.black, backgroundColor: UIColor.white) { (doneAction) -> Bool in

                                                                                                  self.DeleteReplyResponseAPICall(responsetid:fourm_Post_id)
                                                                                                    return true
                                                                                                }
                                                                                                let canleAction = CDAlertViewAction(title: GLocalizedString(key: "Cancel"), font: nil, textColor: UIColor.black, backgroundColor: UIColor.white) { (doneAction) -> Bool in
                                                                                                    return true
                                                                                            
                                                                                                }
                                                                                            alert.add(action: doneAction)
                                                                                            alert.add(action: canleAction)
                                                                                            alert.circleFillColor = ALERT_COLOR
                                                            
                                                                                            alert.show()
                               
                           }
                    
                   editAction.titleTextColor = UIColor(red: 224.0/255.0, green: 60.0/255.0, blue: 113.0/255.0, alpha: 1.0)
                   deleteAction.titleTextColor = UIColor(red: 224.0/255.0, green: 60.0/255.0, blue: 113.0/255.0, alpha: 1.0)
             
                   actionSheetController.addAction(editAction)
                   actionSheetController.addAction(deleteAction)
               }else{
                if OtherUsertype == 1{
                                    let deleteAction = UIAlertAction(title: GLocalizedString(key: "Delete"), style: UIAlertAction.Style.default) { (action) -> Void in
                                                                 let alert = CDAlertView(title: GLocalizedString(key: "Confirmation"), message: "Are you sure you want to delete this reply ?", type: .success)
                                    let doneAction = CDAlertViewAction(title: GLocalizedString(key: "OK"), font: nil, textColor: UIColor.black, backgroundColor: UIColor.white) { (doneAction) -> Bool in

                                        self.DeleteReplyResponseAPICall(responsetid:fourm_Post_id)
                                                return true
                                            }
                                    let canleAction = CDAlertViewAction(title: GLocalizedString(key: "Cancel"), font: nil, textColor: UIColor.black, backgroundColor: UIColor.white) { (doneAction) -> Bool in
                                            return true
                                                                                                                              
                                            }
                                        alert.add(action: doneAction)
                                        alert.add(action: canleAction)
                                        
                                        alert.circleFillColor = ALERT_COLOR
                                        alert.show()
                                                                 
                                                             }
                     deleteAction.titleTextColor = UIColor(red: 224.0/255.0, green: 60.0/255.0, blue: 113.0/255.0, alpha: 1.0)
                    actionSheetController.addAction(deleteAction)
                                 }
                
        }
      

               
                          let replyAction = UIAlertAction(title: GLocalizedString(key: "fd_ReplyToForum"), style: UIAlertAction.Style.default) { (action) -> Void in
                                 
                                 self.RenameDoneBtn.setTitle(GLocalizedString(key: "Reply"), for: .normal)
                                                            self.RenameTitleLable.text = GLocalizedString(key: "ReplyMessage")
                                                            self.renameison = "2"
                                                            self.responseEditid = fourm_Post_id
                            print(prent_id)
                                                            self.perentids = prent_id
                                                            self.RenameView.isHidden = false
                             }
                             let cancelAction = UIAlertAction(title: GLocalizedString(key: "Cancel"), style: UIAlertAction.Style.cancel) { (action) -> Void in
                             }
                            replyAction.titleTextColor = UIColor(red: 224.0/255.0, green: 60.0/255.0, blue: 113.0/255.0, alpha: 1.0)
                           cancelAction.titleTextColor = UIColor.darkGray
                     
               
                              actionSheetController.addAction(replyAction)
                           actionSheetController.addAction(cancelAction)
                            present(actionSheetController, animated: true, completion: nil)
        
    }
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return ForumreplayListarray.count
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ForumDetilsCell") as! ForumDetilsCell
        cell.selectionStyle = .none
//        cell.delegate = self
//        cell.indexPath = indexPath
      //  cell.ForumDetilsedata = self.ForumreplayListarray[indexPath.row]
        
        
     
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         
    }
    
    
}
extension ForumDetilsVc : CITreeViewDelegate {
    func treeViewNode(_ treeViewNode: CITreeViewNode, willExpandAt indexPath: IndexPath) {
        
    }
    
    func treeViewNode(_ treeViewNode: CITreeViewNode, didExpandAt indexPath: IndexPath) {
        
    }
    
    func treeViewNode(_ treeViewNode: CITreeViewNode, willCollapseAt indexPath: IndexPath) {
        
    }
    
    func treeViewNode(_ treeViewNode: CITreeViewNode, didCollapseAt indexPath: IndexPath) {
        
    }
    

    
    func willExpandTreeViewNode(treeViewNode: CITreeViewNode, atIndexPath: IndexPath) {}
    
    func didExpandTreeViewNode(treeViewNode: CITreeViewNode, atIndexPath: IndexPath) {}
    
    func willCollapseTreeViewNode(treeViewNode: CITreeViewNode, atIndexPath: IndexPath) {}
    
    func didCollapseTreeViewNode(treeViewNode: CITreeViewNode, atIndexPath: IndexPath) {}
    
    
    func treeView(_ treeView: CITreeView, heightForRowAt indexPath: IndexPath, withTreeViewNode witwithTreeViewNodeeeViewNode: CITreeViewNode) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func treeView(_ treeView: CITreeView, didDeselectRowAt didSelectRowAteeViewNode: CITreeViewNode, atIndexPath atIndexPathdexPath: IndexPath) {
        
    }
    
    func treeView(_ treeView: CITreeView, didSelectRowAt treeViewNode: CITreeViewNode, atIndexPath indexPath: IndexPath) {
//      let node =  treeViewNode.item as! CITreeViewData
//                print(node.ids)
//
//        if let parentNode = treeViewNode.parentNode{
//            print(parentNode.item)
//            let node =  parentNode.item as! CITreeViewData
//            print(node.ids)
//            print("section" + "\(indexPath.section)" + "row" + "\(indexPath.row)")
//        }
    }
}

extension ForumDetilsVc : CITreeViewDataSource {
    func treeViewSelectedNodeChildren(for treeViewNodeItem: AnyObject) -> [AnyObject] {
       if let dataObj = treeViewNodeItem as? ForumDetilsData {
                      return dataObj.child
                  }
                  return []
    }
    
    func treeViewDataArray() -> [AnyObject] {
        return ForumreplayListarray
    }
    
    func treeView(_ treeView: CITreeView, atIndexPath indexPath: IndexPath, withTreeViewNode treeViewNode: CITreeViewNode) -> UITableViewCell {
        let cell = treeView.dequeueReusableCell(withIdentifier: treeViewCellIdentifier) as! CITreeViewCell
      //  let dataObj = treeViewNode.item as! Dictionary<String, Any>
     //   cell.nameLabel.text = "\n " + "\(dataObj["new_content"] as! String)" + "\n"
        cell.ForumDetilsedata = treeViewNode.item as? ForumDetilsData
         cell.ForumDetilsedataArray = treeViewNode.item as? ForumDetilsData
        cell.delegate = self
        cell.indexPath = indexPath
        cell.setupCell(level: treeViewNode.level)

        return cell;
    }

}
