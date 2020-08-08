//
//  CategoriesPostListVC.swift
//  Girlvent
//
//  Created by Glasier Inc. on 24/01/20.
//  Copyright © 2020 Glasier Inc. All rights reserved.
//

import UIKit
import UITextField_Shake
import CDAlertView
import DropDown
import AVKit
import UITextView_Placeholder

class CategoriesPostListVC: UIViewController {
    @IBOutlet weak var imagePostZoomView: UIView!
     @IBOutlet weak var imagePostZoomImageView: UIImageView!
     @IBOutlet weak var imagepostZoomimagescrolView: UIScrollView!
        @IBOutlet weak var categoriesPostListTable: UITableView!
             var offset = 0
    
       var categoriesPostListarray = [CategoriesPostListData]()
 
    var categoriesid = 0
    var categoriName = ""
     @IBOutlet weak var ImageZoomCamcelButton: UIButton!
    var reportspamPostIds = 0
       @IBOutlet weak var ReportSpamView: UIView!
       @IBOutlet weak var ReportSpamCancelBtn: UIButton!
       @IBOutlet weak var ReportSpamTextview: UITextView!
       @IBOutlet weak var ReportSpamLastCancelBtn: UIButton!
       @IBOutlet weak var ReportSubmitBtn: UIButton!
    
    @IBOutlet var lblReportPost: UILabel!
    
       
       var ReportListArray: [String] = ["Clean out closet.","Clean out closet.","Clean out closet.","Clean out closet.","Clean out closet."]

@IBOutlet weak var TitleLablee: UILabel!
    @IBOutlet weak var Backbutton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TitleLablee.text = GLocalizedString(key: "menu_Categories")
        ReportSpamTextview.placeholder = GLocalizedString(key: "home_ReportSpamText")
        ReportSpamLastCancelBtn.setTitle(GLocalizedString(key: "Cancel"), for: .normal)
        ReportSubmitBtn.setTitle(GLocalizedString(key: "home_ReportPost"), for: .normal)
        self.lblReportPost.text = GLocalizedString(key:"home_ReportPost")
                
       ReportSpamView.isHidden = true
        TitleLablee.text = categoriName
             imagepostZoomimagescrolView.delegate = self
             imagepostZoomimagescrolView.minimumZoomScale = 1.0
             imagepostZoomimagescrolView.maximumZoomScale = 10.0
         
                     imagePostZoomView.isHidden = true
                    let directions: [UISwipeGestureRecognizer.Direction] = [.up, .down, .right, .left]
                    for direction in directions {
                        let gesture = UISwipeGestureRecognizer(target: self, action: #selector(HomeViewVC.handleSwipe(gesture:)))
                        gesture.direction = direction
                        imagepostZoomimagescrolView.addGestureRecognizer(gesture)
                       
                    }
        
        ReportListArray.removeAll()
              GetReportSpamListAPICall()
        
    }
    @IBAction func ImageZoomCamcelButtonClick(_ sender: Any) {
         
            self.imagePostZoomView.isHidden = true
     }
    @IBAction func clk_ReportameList(_ sender: UIControl) {
           let dropDown = DropDown()
                   dropDown.anchorView = sender
                          dropDown.dataSource = ReportListArray
                          dropDown.selectionAction =  { (index, item) in
                              
                              self.ReportSpamTextview.text = item
                          }
                          dropDown.show()
      }
    //MARK:- == FUNCTION FOR Get Report Spam List API ==
                 func GetReportSpamListAPICall(){
                     //let TokenId = UserDefaults.value(forKey: "TokenId") as! String
                     
                     
                     let param = [:] as [String : AnyObject]
                     
                     print(param)
                     
                     APIHelper.shared.GetReportSpamListAPIcall(parameter: param) { (success, result) in
                         
                         if(result.data != nil){
                             if(success){
                        
                                 self.ReportListArray.removeAll()
                                 for dic in result.data{
                                     self.ReportListArray.append(dic.reportName)
                                 }
                             }
                         } else{
                             
                          
                             print("Not Success")
                         }
                     }
                                
                 }
    @objc func handleSwipe(gesture: UISwipeGestureRecognizer) {
             print(gesture.direction)
             
             switch gesture.direction {
             case UISwipeGestureRecognizer.Direction.down:
                 print("down swipe")
                 UIView.animate(withDuration: 0.2,
                                animations: {
                                 self.imagePostZoomImageView.frame = CGRect(x: 0, y: +50, width: self.imagePostZoomImageView.frame.width, height: self.imagePostZoomImageView.frame.height)
                 }, completion: { animated in
                     self.imagePostZoomImageView.frame = CGRect(x: 0, y: 0, width: self.imagePostZoomImageView.frame.width, height: self.imagePostZoomImageView.frame.height)
                     self.imagePostZoomView.isHidden = true
                 })
             case UISwipeGestureRecognizer.Direction.up:
                 print("up swipe")
                 UIView.animate(withDuration: 0.2,
                                            animations: {
                                             self.imagePostZoomImageView.frame = CGRect(x: 0, y: -50, width: self.imagePostZoomImageView.frame.width, height: self.imagePostZoomImageView.frame.height)
                 }, completion: { animated in
               self.imagePostZoomImageView.frame = CGRect(x: 0, y: 0, width: self.imagePostZoomImageView.frame.width, height: self.imagePostZoomImageView.frame.height)
                     self.imagePostZoomView.isHidden = true
                 })
             case UISwipeGestureRecognizer.Direction.left:
                 print("left swipe")
             case UISwipeGestureRecognizer.Direction.right:
                 print("right swipe")
             default:
                 print("other swipe")
             }
         }
       override func viewWillAppear(_ animated: Bool) {
           
           super.viewWillAppear(true)
                GetcategoriePostAPICall()
       }
       override func viewWillDisappear(_ animated: Bool) {
           
      
       
               NotificationCenter.default.post(name: NSNotification.Name(rawValue: "videostop"), object: nil)
       }
    
    @IBAction func BackButtonClick(_ sender: Any) {
          
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func ReportSubmitBtnClick(_ sender: Any) {
           
           
                     if (ReportSpamTextview.text?.trimmingCharacters(in: .whitespaces).isEmpty)!
                                          {
                                                                                   
                                                                                     
                                                                                     let alert = CDAlertView(title: GLocalizedString(key: "Hang On"), message: GLocalizedString(key: "EnterSomeText"), type: .warning)
                                                                                     let doneAction = CDAlertViewAction(title: GLocalizedString(key: "OK"), font: nil, textColor: UIColor.black, backgroundColor: UIColor.white) { (doneAction) -> Bool in
                                                                                       self.ReportSpamView.isHidden = false
                                                                                         return true
                                                                                     }
                                                                                     alert.add(action: doneAction)
                                                                                     alert.circleFillColor = ALERT_COLOR
                                                                                     alert.show()
                                                                                    
                            }else{
                                 ReportSpamPostAPICall()
                                
                            }
           
                ReportSpamView.isHidden = true
       }
       @IBAction func ReportSpamLastCancelBtnClick(_ sender: Any) {
            ReportSpamView.isHidden = true
       }
       @IBAction func ReportSpamCancelBtnClick(_ sender: Any) {
            ReportSpamView.isHidden = true
       }
       
       //MARK:- == FUNCTION FOR Edit reply response API ==
          func ReportSpamPostAPICall(){
                //let TokenId = UserDefaults.value(forKey: "TokenId") as! String
                
                
                let param = [
                  "post_id": reportspamPostIds,
                  "issue" :ReportSpamTextview.text!
                    ] as [String : AnyObject]
                
                print(param)
                
                APIHelper.shared.ReportSpamAPIcall(parameter: param) { (success, result) in
                    
                   
                        if(success){
                       
                           let alert = CDAlertView(title: GLocalizedString(key: "Success"), message: GLocalizedString(key: "PostReported"), type: .success)
                               let doneAction = CDAlertViewAction(title: GLocalizedString(key: "OK"), font: nil, textColor: UIColor.black, backgroundColor: UIColor.white) { (doneAction) -> Bool in
                                   self.ReportSpamView.isHidden = true
                                           return true
                                           }
                               alert.add(action: doneAction)
                               alert.circleFillColor = ALERT_COLOR
                               alert.show()
                        }
                    
                }
                
            }
       
    
    //MARK:- == FUNCTION FOR Home Post get API ==
      func GetcategoriePostAPICall(){
          //let TokenId = UserDefaults.value(forKey: "TokenId") as! String
        
    
          
          let param = [
              "category_id":categoriesid
              ] as [String : AnyObject]
          
          print(param)
          
          APIHelper.shared.GetCategoriesPostListAPIcall(parameter: param) { (success, result) in
              
              if(result.data != nil){
                  if(success){
             
                      self.categoriesPostListarray = result.data
                      
                      self.categoriesPostListTable.reloadData()
                  }else{
                         let alert = CDAlertView(title:nil, message:GLocalizedString(key: "NoPostFound"), type: .error)
                                                                       let doneAction = CDAlertViewAction(title: GLocalizedString(key: "OK"), font: nil, textColor: UIColor.black, backgroundColor: UIColor.white) { (doneAction) -> Bool in
                                                                           
                                                                     
                                                                           
                                                                      
                                                                               return true
                                                                   }
                                                                   alert.add(action: doneAction)
                                                                   alert.circleFillColor = ALERT_COLOR
                                                                   alert.show()
                  }
              }
          }
          
      }
         override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      //        if (dropper.isHidden == false) { // Checks if Dropper is visible
      //            dropper.hideWithAnimation(0.1) // Hides Dropper
      //        }
          }
          
          
          func viewForZooming(in scrollView: UIScrollView) -> UIView? {
              return imagePostZoomImageView
          }

    //MARK:- == FUNCTION FOR Delete Post API ==
    func DeletePostAPICall(postids:Int){
              //let TokenId = UserDefaults.value(forKey: "TokenId") as! String
              
              
              let param = [
                  "language":"english",
                  "post_id":postids
                  ] as [String : AnyObject]
              
              print(param)
              
              APIHelper.shared.DeletePostAPIcall(parameter: param) { (success, result) in
                  
             
                      if(success){
                      
                               let alert = CDAlertView(title: GLocalizedString(key: "Success"), message: GLocalizedString(key: "PostDeleted"), type: .success)
                                let doneAction = CDAlertViewAction(title: GLocalizedString(key: "OK"), font: nil, textColor: UIColor.black, backgroundColor: UIColor.white) { (doneAction) -> Bool in
                                    
                              
                                    
                                    self.GetcategoriePostAPICall()
                                        return true
                            }
                            alert.add(action: doneAction)
                            alert.circleFillColor = ALERT_COLOR
                            alert.show()
                         }
                        
                        
                      
                    
                 
              }
              
          }
    
}
extension CategoriesPostListVC : UITableViewDelegate , UITableViewDataSource,categoriesPostCellDelegate {
    func VideoTapped(at index: IndexPath) {
                if self.categoriesPostListarray[index.row].media != "" {
             let url = URL(string: self.categoriesPostListarray[index.row].media)
             let player = AVPlayer(url: url!)
             let playerViewController = AVPlayerViewController()
             playerViewController.player = player
             self.present(playerViewController, animated: true) {
                 playerViewController.player!.play()
             }
         }
         else {
             //self.showAlert(title: Globs.AppName, message: "URL not available" , linkHandler: nil)
         }
     }
    
    func imagepostZoomButtonTapped(at index: IndexPath) {
        imagePostZoomView.isHidden = false
        
        
        
        if let urlt = self.categoriesPostListarray[index.row].media
                                              {
                                                  if (urlt != ""){
                                                      let urlf = URL(string: urlt)!
                                                      // let image2 = UIImageView()
                                                      self.imagePostZoomImageView.sd_setImage(with: urlf, placeholderImage:UIImage(named: "GirlVentLogo"), options: .delayPlaceholder, completed: { (image, error, cacheType, imageURL) in
                                                      })
                                                  }
                                              }
    }
    
    func CommentButtonTapped(at index: IndexPath) {
        
             let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let therapiescall = storyBoard.instantiateViewController(withIdentifier: "CommentsVcpuch") as! CommentsVc
                therapiescall.postids = categoriesPostListarray[index.row].postId
                self.navigationController?.pushViewController(therapiescall, animated: true)
        
        
        
    }
    
    func UserprofileButtonTapped(at index: IndexPath) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let therapiescall = storyBoard.instantiateViewController(withIdentifier: "MyProfileHomeVCpuch") as! MyProfileHomeVC
        therapiescall.otheruser = categoriesPostListarray[index.row].token
               self.navigationController?.pushViewController(therapiescall, animated: true)
    }
    
    func optionBtnapped(at index: IndexPath, optionButton: UIButton, tablecell: UITableViewCell) {
        
        
        let user:LoginData = HELPER.getSession()
        
        print(user.token!)
        let actionSheetController = UIAlertController(title:nil, message:nil, preferredStyle: UIAlertController.Style.actionSheet)
                    
        if user.token == categoriesPostListarray[index.row].token{
                    let editAction = UIAlertAction(title: GLocalizedString(key: "Edit"), style: UIAlertAction.Style.default) { (action) -> Void in
                        
                                              if self.categoriesPostListarray[index.row].type == "text"{
                                                  let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                                          let therapiescall = storyBoard.instantiateViewController(withIdentifier: "CreatePostVCpuch") as! CreatePostVC
                                                          therapiescall.textforEditString = self.categoriesPostListarray[index.row].content
                                                          therapiescall.selectedcategoriid = Int(self.categoriesPostListarray[index.row].categoryId)
                                                          therapiescall.wheretoCome = 1
                                                          therapiescall.postidString = self.categoriesPostListarray[index.row].postId
                                                                             
                                                  
                                                          self.navigationController?.pushViewController(therapiescall, animated: true)
                                                  
                                                  
                                              }else if self.categoriesPostListarray[index.row].type == "youtube" {
                                                  let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                                           let therapiescall = storyBoard.instantiateViewController(withIdentifier: "CreateYoutubeVideoPostVCpuch") as! CreateYoutubeVideoPostVC
                                                  therapiescall.linkforEditStirng = self.categoriesPostListarray[index.row].youtube
                                                  therapiescall.textforEditString = self.categoriesPostListarray[index.row].content
                                                  therapiescall.selectedcategoriid = Int(self.categoriesPostListarray[index.row].categoryId)
                                                  therapiescall.wheretoCome = 1
                                                  therapiescall.postidString = self.categoriesPostListarray[index.row].postId
                                                           self.navigationController?.pushViewController(therapiescall, animated: true)
                                                  
                                              }else if self.categoriesPostListarray[index.row].type == "video" {
                                                  let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                                                 let therapiescall = storyBoard.instantiateViewController(withIdentifier: "CreateVideoPostVCpuch") as! CreateVideoPostVC
                                                  
                                                  therapiescall.textforEditString = self.categoriesPostListarray[index.row].content
                                                  therapiescall.selectedcategoriid = Int(self.categoriesPostListarray[index.row].categoryId)
                                                  therapiescall.wheretoCome = 1
                                                  therapiescall.postidString = self.categoriesPostListarray[index.row].postId
                                                   therapiescall.linkforEditStirng = self.categoriesPostListarray[index.row].media
                                                  
                                                                 self.navigationController?.pushViewController(therapiescall, animated: true)
                                                  
                                                  
                                              }else if self.categoriesPostListarray[index.row].type == "image" {
                                                  let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                                               let therapiescall = storyBoard.instantiateViewController(withIdentifier: "CreateImagePostVCpuch") as! CreateImagePostVC
                                                                            therapiescall.textforEditString = self.categoriesPostListarray[index.row].content
                                                                            therapiescall.selectedcategoriid = Int(self.categoriesPostListarray[index.row].categoryId) ?? 0
                                                                            therapiescall.wheretoCome = 1
                                                                            therapiescall.postidString = self.categoriesPostListarray[index.row].postId
                                                                              therapiescall.linkforEditStirng = self.categoriesPostListarray[index.row].media
                                                  
                                                               self.navigationController?.pushViewController(therapiescall, animated: true)
                                              }
                                              
                    }
                    let deleteAction = UIAlertAction(title: GLocalizedString(key: "Delete"), style: UIAlertAction.Style.default) { (action) -> Void in
                        
                        let alert = CDAlertView(title: GLocalizedString(key: "Confirmation"), message: GLocalizedString(key: "PostDeleteConfirmation"), type: .warning)
                                                     
                                                         let doneAction = CDAlertViewAction(title: GLocalizedString(key: "OK"), font: nil, textColor: UIColor.black, backgroundColor: UIColor.white) { (doneAction) -> Bool in
                                                            self.DeletePostAPICall(postids: self.categoriesPostListarray[index.row].postId)
                                                                                       self.categoriesPostListarray.remove(at: index.row)
                                                                                         let indexPath = IndexPath(item: index.row, section: 0)
                                                                                         self.categoriesPostListTable.deleteRows(at: [indexPath], with: .automatic)
                                                           
                                                            
                                                           
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
            let reportAction = UIAlertAction(title: GLocalizedString(key: "Report"), style: UIAlertAction.Style.default) { (action) -> Void in
                
                self.ReportSpamView.isHidden = false
                                             self.reportspamPostIds = self.categoriesPostListarray[index.row].postId
                
            }
            reportAction.titleTextColor = UIColor(red: 224.0/255.0, green: 60.0/255.0, blue: 113.0/255.0, alpha: 1.0)
            actionSheetController.addAction(reportAction)
        }
        
                         let shareAction = UIAlertAction(title: GLocalizedString(key: "Share"), style: UIAlertAction.Style.default) { (action) -> Void in
                                          let message = self.categoriesPostListarray[index.row].content
                                          let meadi = self.categoriesPostListarray[index.row].media
                                              if let link = NSURL(string: "https://itunes.apple.com/app/id1519398477")
                                              {
                                                  let objectsToShare = [meadi,message,link] as [Any]
                                                  let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
                                                  activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList]
                                                if DeviceType.IS_IPAD {
                                                      activityVC.popoverPresentationController?.sourceView = optionButton
                                                      activityVC.popoverPresentationController?.sourceRect = optionButton.bounds
                                                  }
                                                  self.present(activityVC, animated: true, completion: nil)
                                              }
                                        }
                      
                      let cancelAction = UIAlertAction(title: GLocalizedString(key: "Cancel"), style: UIAlertAction.Style.cancel) { (action) -> Void in
                      }
                    cancelAction.titleTextColor = UIColor.darkGray
                    shareAction.titleTextColor = UIColor(red: 224.0/255.0, green: 60.0/255.0, blue: 113.0/255.0, alpha: 1.0)
        
                    actionSheetController.addAction(shareAction)
              
                    actionSheetController.addAction(cancelAction)
                     present(actionSheetController, animated: true, completion: nil)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return categoriesPostListarray.count
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        //  return 60
        
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoriesPostCell") as! CategoriesPostCell
        cell.selectionStyle = .none
        
        cell.delegate = self
        cell.indexPath = indexPath
         
         cell.categoriepostdata = self.categoriesPostListarray[indexPath.row]
     
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         
    }
    
     func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let videoCell = (cell as? HomePostListCell) else { return }
              // videoCell.VideoView.player?.pause()
               
    }
    
     func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let videoCell = cell as? HomePostListCell else { return }
        
//        videoCell.VideoView.player?.pause()
//       videoCell.VideoView.player = nil
    }
}
