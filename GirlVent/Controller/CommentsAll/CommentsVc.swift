//
//  CommentsVc.swift
//  Girlvent
//
//  Created by Glasier Inc. on 06/01/20.
//  Copyright © 2020 Glasier Inc. All rights reserved.
//

import UIKit
import UITextField_Shake
import CDAlertView
import UITextView_Placeholder

class CommentsVc: UIViewController {

    //MARK:- Outlets
    @IBOutlet weak var CommentBackButton: UIButton!
    @IBOutlet weak var CommentsTitle: UILabel!
    @IBOutlet weak var CommentsListTableView: UITableView!
    @IBOutlet weak var CommentsTextview: UITextView!
    @IBOutlet weak var commentsSendButton: UIButton!
    @IBOutlet weak var EditCommentView: UIView!
    @IBOutlet weak var EditCommentCancelButton: UIButton!
    @IBOutlet weak var EditCommentTextView: UITextView!
    @IBOutlet weak var EditCommnetSaveButton: UIButton!
    
    @IBOutlet var lblEditComment: UILabel!
    
    
    
    
    //MARK:- Variables
    var CommentListarray = [GetCommentListData]()
    
    var postids = 0
    var CommentIds = 0
    
    
    //MARK:- ViewLifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
       
        CommentsTitle.text = GLocalizedString(key: "Comments_Title")
        lblEditComment.text = GLocalizedString(key: "Comments_Edit")
        CommentsTextview.placeholder = GLocalizedString(key: "PostTextView")
        EditCommnetSaveButton.setTitle(GLocalizedString(key: "OK"), for: .normal)
        

          EditCommentView.isHidden = true
        GetCommentAPICall()
        
        self.CommentsListTableView.estimatedRowHeight = 150
        // Do any additional setup after loading the view.
    }
    
    @IBAction func EditCommentSaveButtonClick(_ sender: Any) {
          EditCommentAPICall()
          EditCommentView.isHidden = true
    }
    @IBAction func EditCommentCancelButtonClick(_ sender: Any) {
        
        
      
          EditCommentView.isHidden = true
    }
    
    @IBAction func CommentsBackButtonClick(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    @IBAction func commentsSendButtonClick(_ sender: Any) {
        
        
        if (CommentsTextview.text?.trimmingCharacters(in: .whitespaces).isEmpty)!
                      {
                                                               
                                                                 
                                                                 let alert = CDAlertView(title: GLocalizedString(key: "Hang On"), message: GLocalizedString(key: "EnterText"), type: .warning)
                                                                 let doneAction = CDAlertViewAction(title: GLocalizedString(key: "OK"), font: nil, textColor: UIColor.black, backgroundColor: UIColor.white) { (doneAction) -> Bool in
                                                                     return true
                                                                 }
                                                                 alert.add(action: doneAction)
                                                                 alert.circleFillColor = ALERT_COLOR
                                                                 alert.show()
                                                                
        }else{
             AddCommentAPICall()
            
        }
        
       
       
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    //MARK:- == FUNCTION FOR Get Comment List API ==
      func GetCommentAPICall(){
          //let TokenId = UserDefaults.value(forKey: "TokenId") as! String
          
          
          let param = [
            "post_id": postids
              ] as [String : AnyObject]
          
          print(param)
          
          APIHelper.shared.GetCommentListAPIcall(parameter: param) { (success, result) in
              
              if(result.data != nil){
                  if(success){
             
                      self.CommentListarray = result.data
                      
                      self.CommentsListTableView.reloadData()
                  }
              } else{
                  
               self.CommentListarray.removeAll()
                           self.CommentsListTableView.reloadData()
                  print("Not Success")
              }
          }
          
      }
    
    //MARK:- == FUNCTION FOR Add Comment API ==
      func AddCommentAPICall(){
          //let TokenId = UserDefaults.value(forKey: "TokenId") as! String
          
          
          let param = [
            "post_id": postids,
            "comment" : CommentsTextview.text!
              ] as [String : AnyObject]
          
          print(param)
          
          APIHelper.shared.AddCommentAPIcall(parameter: param) { (success, result) in
              
              if(result.data != nil){
                  if(success){
             
                    self.CommentsTextview.text = ""
                    self.GetCommentAPICall()
                  }
              } else{
                  print("Not Success")
              }
          }
          
      }
    //MARK:- == FUNCTION FOR Edit Comment API ==
    func EditCommentAPICall(){
          //let TokenId = UserDefaults.value(forKey: "TokenId") as! String
          
          
          let param = [
            "comment_id": CommentIds,
            "comment" : EditCommentTextView.text!
              ] as [String : AnyObject]
          
          print(param)
          
          APIHelper.shared.EditCommentAPIcall(parameter: param) { (success, result) in
              
              if(result.data != nil){
                  if(success){
             
                    self.GetCommentAPICall()
                  }
              } else{
                  print("Not Success")
              }
          }
          
      }
    
    //MARK:- == FUNCTION FOR Edit Comment API ==
    func DeleteCommentAPICall(Commentid:Int){
          //let TokenId = UserDefaults.value(forKey: "TokenId") as! String
          
          
          let param = [
            "comment_id": Commentid
              ] as [String : AnyObject]
          
          print(param)
          
          APIHelper.shared.DeleteCommentAPIcall(parameter: param) { (success, result) in
              
             
                  if(success){
             
                    self.GetCommentAPICall()
                  }
              
          }
          
      }
}
extension CommentsVc : UITableViewDelegate , UITableViewDataSource,CommentsListCellDelegate {
   
    
    func UserprofileButtonTapped(at index: IndexPath) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                 let therapiescall = storyBoard.instantiateViewController(withIdentifier: "MyProfileHomeVCpuch") as! MyProfileHomeVC
         therapiescall.otheruser = CommentListarray[index.row].token
         therapiescall.otheruserids = String(CommentListarray[index.row].userId)
                self.navigationController?.pushViewController(therapiescall, animated: true)
    }
    
    func optionBtnapped(at index: IndexPath, optionButton: UIButton, tablecell: UITableViewCell) {
        
        
        let user:LoginData = HELPER.getSession()
        
        print(user.token!)
        let actionSheetController = UIAlertController(title:nil, message:nil, preferredStyle: UIAlertController.Style.actionSheet)
                    
    
                    let editAction = UIAlertAction(title: GLocalizedString(key: "Edit"), style: UIAlertAction.Style.default) { (action) -> Void in
                        
                        self.EditCommentView.isHidden = false
                        self.EditCommentTextView.text = self.CommentListarray[index.row].comment
                        self.CommentIds = self.CommentListarray[index.row].commentId
                    }
        
                    let deleteAction = UIAlertAction(title: GLocalizedString(key: "Delete"), style: UIAlertAction.Style.default) { (action) -> Void in
                        
                        
                        let alert = CDAlertView(title: GLocalizedString(key: "Confirmation"), message: GLocalizedString(key: "CommentDeleteConfirmation"), type: .warning)
                            let doneAction = CDAlertViewAction(title: GLocalizedString(key: "OK"), font: nil, textColor: UIColor.black, backgroundColor: UIColor.white) { (doneAction) -> Bool in

                                self.DeleteCommentAPICall(Commentid: self.CommentListarray[index.row].commentId)
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
            editAction.titleTextColor = UIColor(red: 224.0/255.0, green: 60.0/255.0, blue: 113.0/255.0, alpha: 1.0)
            deleteAction.titleTextColor = UIColor(red: 224.0/255.0, green: 60.0/255.0, blue: 113.0/255.0, alpha: 1.0)
            cancelAction.titleTextColor = UIColor.darkGray
       // actionSheetController.title. =  UIColor(red: 224.0/255.0, green: 60.0/255.0, blue: 113.0/255.0, alpha: 1.0)
                    actionSheetController.addAction(editAction)
            actionSheetController.addAction(deleteAction)
            actionSheetController.addAction(cancelAction)
        
                   
                     present(actionSheetController, animated: true, completion: nil)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return CommentListarray.count
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentsListCellpuch") as! CommentsListCell
        cell.selectionStyle = .none
        cell.delegate = self
        cell.indexPath = indexPath
        cell.CommentData = self.CommentListarray[indexPath.row]
        
        
     
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         
    }
    
    
}
