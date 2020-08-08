//
//  HomeViewVC.swift
//  Girlvent
//
//  Created by Glasier Inc. on 25/12/19.
//  Copyright © 2019 Glasier Inc. All rights reserved.
//

import UIKit
import SideMenu
import UITextField_Shake
import CDAlertView
import DropDown
import AVFoundation
import AVKit
import UITextView_Placeholder

class HomeViewVC: UIViewController {

    //MARK:- Outlets
    @IBOutlet weak var MenuButton: UIButton!
    @IBOutlet weak var LanguageButton: UIButton!
    @IBOutlet weak var CreatePostButton: UIButton!
    @IBOutlet weak var ImagePostButton: UIButton!
    @IBOutlet weak var VideoPostButton: UIButton!
    @IBOutlet weak var YoutubeVideoPostButton: UIButton!
    @IBOutlet weak var UserPostListTable: UITableView!
    @IBOutlet weak var imagePostZoomView: UIView!
    @IBOutlet weak var imagePostZoomImageView: UIImageView!
    @IBOutlet weak var imagepostZoomimagescrolView: UIScrollView!
    var offset = 0
    @IBOutlet weak var ImageZoomCamcelButton: UIButton!
    var HomePostListarray = [GetHomePostData]()
    var islastrecord = false
    var refreshControl: UIRefreshControl!
    var spinner: UIActivityIndicatorView!
    var lastpostidsString = 0
    var reportspamPostIds = 0
    @IBOutlet weak var ReportSpamView: UIView!
    @IBOutlet weak var ReportSpamCancelBtn: UIButton!
    @IBOutlet weak var ReportSpamTextview: UITextView!
    @IBOutlet weak var ReportSpamLastCancelBtn: UIButton!
    @IBOutlet weak var ReportSubmitBtn: UIButton!
    
    @IBOutlet var lblReportPost: UILabel!
    
    
    //MARK:- Variables
    var ReportListArray: [String] = ["Clean out closet.","Clean out closet.","Clean out closet.","Clean out closet.","Clean out closet."]
    
    var sharedIdentifier = "group.com.Glasierinc.Girlventdemo"
    
    
    //MARK:- ViewLifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
//       if let userDefaults = UserDefaults(suiteName: "group.com.Glasierinc.Girlventdemo")
//       {
//            if let sharedArray = userDefaults.object(forKey: "img") as? [String : Any] {
//                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//                    let therapiescall = storyBoard.instantiateViewController(withIdentifier: "CreateImagePostVCpuch") as! CreateImagePostVC
//    //            therapiescall.SelectimahePathLable.text = sharedArray["imgPath"] as? String
//    //            //let imgdata = try! Data(contentsOf: URL(string: sharedArray["imgPath"] as! String)!)
//    //            therapiescall.profileimageview.image = UIImage(data: sharedArray["imgData"] as! Data)
//    //                therapiescall.ImageTextTextView.text = sharedArray["name"] as? String
//    //            therapiescall.isfromShare = true
//    //
//    //            userDefaults.removeObject(forKey: "img")
//    //            userDefaults.synchronize()
//                    self.navigationController?.pushViewController(therapiescall, animated: true)
//                }
//            if let sharedArray = userDefaults.object(forKey: "Video") as? [String : Any]
//            {
//                           let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//                            let therapiescall = storyBoard.instantiateViewController(withIdentifier: "CreateVideoPostVCpuch") as! CreateVideoPostVC
//                            self.navigationController?.pushViewController(therapiescall, animated: true)
//            }
//            if let sharedArray = userDefaults.object(forKey: "Text") as? [String : Any]
//            {
//                          let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//                           let therapiescall = storyBoard.instantiateViewController(withIdentifier: "CreatePostVCpuch") as! CreatePostVC
//                           self.navigationController?.pushViewController(therapiescall, animated: true)
//            }
//        }
        
        
        
        
        
        ReportSpamView.isHidden = true
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
        self.refreshControl = UIRefreshControl()
        self.refreshControl.addTarget(self, action: #selector(HomeViewVC.pullTorefresh), for: UIControl.Event.valueChanged)
        UserPostListTable.addSubview(self.refreshControl)
        spinner = UIActivityIndicatorView(style: .gray)
        self.refreshControl.beginRefreshing()
        ReportListArray.removeAll()
        GetReportSpamListAPICall()
    }
    @objc func pullTorefresh(){
        lastpostidsString = 0
        islastrecord = true
              GetHomePostAPICall()
      }
    func bootamTorefresh(){
                 GetHomePostAPICall()
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
    @IBAction func ImageZoomCamcelButtonClick(_ sender: Any) {
        
           self.imagePostZoomView.isHidden = true
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
        
        
        
        self.refreshControl.beginRefreshing()
         lastpostidsString = 0
        CheckUserStausAPICall()
       
        
        
        
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        
   
    
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "videostop"), object: nil)
    }
    

    @IBAction func MenuButtonClick(_ sender: Any) {
        
        
       // let menu = SideMenuNavigationController(rootViewController: self)
        // SideMenuNavigationController is a subclass of UINavigationController, so do any additional configuration
        // of it here like setting its viewControllers. If you're using storyboards, you'll want to do something like:
        // let menu = storyboard!.instantiateViewController(withIdentifier: "RightMenu") as! SideMenuNavigationController
       // present(menu, animated: true, completion: nil)
        
               let leftMenuNavigationController = storyboard!.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as! SideMenuNavigationController
        
       // let leftMenuNavigationController = SideMenuNavigationController(rootViewController: YourViewController)
        SideMenuManager.default.leftMenuNavigationController = leftMenuNavigationController

//        let rightMenuNavigationController = SideMenuNavigationController(rootViewController: YourViewController)
//        SideMenuManager.default.rightMenuNavigationController = rightMenuNavigationController

        // Setup gestures: the left and/or right menus must be set up (above) for these to work.
        // Note that these continue to work on the Navigation Controller independent of the view controller it displays!
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
        SideMenuManager.default.addScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)
        leftMenuNavigationController.presentationStyle = .menuSlideIn
        leftMenuNavigationController.blurEffectStyle = .dark
        leftMenuNavigationController.menuWidth = self.view.frame.width
        leftMenuNavigationController.statusBarEndAlpha = 0
        // Copy all settings to the other menu
       // rightMenuNavigationController.settings = leftMenuNavigationController.settings
        
        
 
    
        present(leftMenuNavigationController, animated: true, completion: nil)
      
         
       // present(SideMenuManager.default.leftMenuNavigationController!, animated: true, completion: nil)
    }

    //MARK:- == FUNCTION FOR check user satus API ==
            func CheckUserStausAPICall(){
                      //let TokenId = UserDefaults.value(forKey: "TokenId") as! String
                      
                      
                      let param = [
                          "language":"english"
                          ] as [String : AnyObject]
                      
                      print(param)
                      
                      APIHelper.shared.CheckUserStatusAPIcall(parameter: param) { (success, result) in
                          
                     
                              if(success){
                              
                                if result.data.status == "inactive"{
                                    let alert = CDAlertView(title: GLocalizedString(key: GLocalizedString(key: "Admin")), message: result.message, type: .error)
                                                                  let doneAction = CDAlertViewAction(title: GLocalizedString(key: "OK"), font: nil, textColor: UIColor.black, backgroundColor: UIColor.white) { (doneAction) -> Bool in

                                                                      UserDefaults.standard.removeObject(forKey: USER_LOGIN)
                                                                      let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                                                      let therapiescall = storyBoard.instantiateViewController(withIdentifier: "LoginVcPuch") as! LoginVc
                                                                      self.navigationController?.pushViewController(therapiescall, animated: true)
                                                                          return true
                                                                      }
                                                                  alert.add(action: doneAction)
                                                                  alert.circleFillColor = ALERT_COLOR
                                                                  alert.show()
                                    
                                }else{
                                    self.GetHomePostAPICall()
                                }
                                
                                  
                              }else{

                              
                           
                                
                        }
                         
                      }
                      
                  }

    
    @IBAction func LanguageButtonClick(_ sender: Any) {
        
        
        let actionSheetController = UIAlertController(title:nil, message:nil, preferredStyle: UIAlertController.Style.actionSheet)
                          
        
              
        let englishAction = UIAlertAction(title: GLocalization.sharedInstance.localizedString(forKey: "EnglishLanguage", value: ""), style: UIAlertAction.Style.default) { (action) -> Void in
                                
                                GLocalization.sharedInstance.setLanguage(language: "en")
//                                self.CheckUserStausAPICall()
                                self.UserPostListTable.reloadData()
                            }
        let spanishAction = UIAlertAction(title: GLocalization.sharedInstance.localizedString(forKey: "SpanishLanguage", value: ""), style: UIAlertAction.Style.default) { (action) -> Void in
                                GLocalization.sharedInstance.setLanguage(language: "es")
//                                self.CheckUserStausAPICall()
                                self.UserPostListTable.reloadData()
                            }
        let franceAction = UIAlertAction(title: GLocalization.sharedInstance.localizedString(forKey: "FrenchLanguage", value: ""), style: UIAlertAction.Style.default) { (action) -> Void in
                                GLocalization.sharedInstance.setLanguage(language: "fr")
//                                self.CheckUserStausAPICall()
                                self.UserPostListTable.reloadData()
                            }
                            let cancelAction = UIAlertAction(title: GLocalizedString(key: "Cancel"), style: UIAlertAction.Style.cancel) { (action) -> Void in
                            }
                          cancelAction.titleTextColor = UIColor.darkGray
                          englishAction.titleTextColor = UIColor(red: 224.0/255.0, green: 60.0/255.0, blue: 113.0/255.0, alpha: 1.0)
                          spanishAction.titleTextColor = UIColor(red: 224.0/255.0, green: 60.0/255.0, blue: 113.0/255.0, alpha: 1.0)
                          franceAction.titleTextColor = UIColor(red: 224.0/255.0, green: 60.0/255.0, blue: 113.0/255.0, alpha: 1.0)
                          
                        if GLocalization.sharedInstance.getLanguage() == "en"
                        {
                          englishAction.setValue(true, forKey: "checked")
                        }
                        else if GLocalization.sharedInstance.getLanguage() == "es"
                        {
                          spanishAction.setValue(true, forKey: "checked")
                        }
                        else
                        {
                            franceAction.setValue(true, forKey: "checked")
                        }
        
        
                          actionSheetController.addAction(englishAction)
                          actionSheetController.addAction(spanishAction)
                          actionSheetController.addAction(franceAction)
                          actionSheetController.addAction(cancelAction)
                           present(actionSheetController, animated: true, completion: nil)
        
        
    }
    @IBAction func CreatePostButtonClick(_ sender: Any) {
        

        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
         let therapiescall = storyBoard.instantiateViewController(withIdentifier: "CreatePostVCpuch") as! CreatePostVC
         self.navigationController?.pushViewController(therapiescall, animated: true)
                                                                                 
    }
    @IBAction func ImagePostButtonclick(_ sender: Any) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let therapiescall = storyBoard.instantiateViewController(withIdentifier: "CreateImagePostVCpuch") as! CreateImagePostVC
        therapiescall.isfromShare = false
        self.navigationController?.pushViewController(therapiescall, animated: true)
    }
    @IBAction func VideoPostButtonClick(_ sender: Any) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let therapiescall = storyBoard.instantiateViewController(withIdentifier: "CreateVideoPostVCpuch") as! CreateVideoPostVC
        self.navigationController?.pushViewController(therapiescall, animated: true)
    }
    @IBAction func YoutubeVideoButtonClick(_ sender: Any) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
           let therapiescall = storyBoard.instantiateViewController(withIdentifier: "CreateYoutubeVideoPostVCpuch") as! CreateYoutubeVideoPostVC
           self.navigationController?.pushViewController(therapiescall, animated: true)
        
        
    }
    //MARK:- == FUNCTION FOR Home Post get API ==
    func GetHomePostAPICall(){
        //let TokenId = UserDefaults.value(forKey: "TokenId") as! String
        
        var lastids = 0
        if self.HomePostListarray.count > 1 {
            lastids = lastpostidsString
        }else{
            lastids = 0
            
        }
        let param = [
            "language":"english",
            "postLastId": lastids,
            "device_token":App_Delegate.toekn
            ] as [String : AnyObject]
        
        print(param)
        
        APIHelper.shared.GetHomePostAPIcall(parameter: param) { (success, result) in
            
            if(result.data != nil){
                if(success){
           
                    self.refreshControl.endRefreshing()
                    if result.data.count == 0{
                         self.spinner.stopAnimating()
                        self.islastrecord = true
                    }else{
                        if self.lastpostidsString == 0{
                            self.HomePostListarray.removeAll()
                            self.refreshControl.endRefreshing()
                            
                            self.HomePostListarray = result.data
                        
                        }else{
                            if self.HomePostListarray.count > 1 {
                                                     
                                                     for(_,value) in result.data.enumerated()
                                                       {
                                                              self.HomePostListarray.append(value)
                                                         self.spinner.stopAnimating()
                                                      }
                            }else{
                                                       self.refreshControl.endRefreshing()
                                                      self.HomePostListarray = result.data
                            }
                        }
                     
                        self.islastrecord = false
                        self.UserPostListTable.reloadData()
                    }
                    
                   
                    
                    
                }
            } else{
                
             
                print("Not Success")
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
                                    
                              
                                    
                                    self.GetHomePostAPICall()
                                        return true
                            }
                            alert.add(action: doneAction)
                            alert.circleFillColor = ALERT_COLOR
                            alert.show()
                         }
                        
                        
                      
                    
                 
              }
              
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
    
    
}
extension HomeViewVC : UITableViewDelegate , UITableViewDataSource,HomePostCellDelegate {
    func VideoTapped(at index: IndexPath) {
               if self.HomePostListarray[index.row].media != "" {
            let url = URL(string: self.HomePostListarray[index.row].media)
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
    func CategoriesButtonTapped(at index: IndexPath) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                              let therapiescall = storyBoard.instantiateViewController(withIdentifier: "CategoriesPostListVC") as! CategoriesPostListVC
        therapiescall.categoriesid = Int(self.HomePostListarray[index.row].categoryId)!
        therapiescall.categoriName = self.HomePostListarray[index.row].categoryName!
                             self.navigationController?.pushViewController(therapiescall, animated: true)
    }
    
    func imagepostZoomButtonTapped(at index: IndexPath) {
        imagePostZoomView.isHidden = false
        
        
        
        if let urlt = self.HomePostListarray[index.row].media
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
                therapiescall.postids = HomePostListarray[index.row].postId
                self.navigationController?.pushViewController(therapiescall, animated: true)
        
        
        
    }
    
    func UserprofileButtonTapped(at index: IndexPath) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let therapiescall = storyBoard.instantiateViewController(withIdentifier: "MyProfileHomeVCpuch") as! MyProfileHomeVC
        therapiescall.otheruser = HomePostListarray[index.row].token
        therapiescall.otheruserids = String(HomePostListarray[index.row].userId)
               self.navigationController?.pushViewController(therapiescall, animated: true)
    }
    
    func optionBtnapped(at index: IndexPath, optionButton: UIButton, tablecell: UITableViewCell) {
        
        
        let user:LoginData = HELPER.getSession()
        
        print(user.token!)
        let actionSheetController = UIAlertController(title:nil, message:nil, preferredStyle: UIAlertController.Style.actionSheet)


        
        if user.token == HomePostListarray[index.row].token{
                    let editAction = UIAlertAction(title: GLocalizedString(key: "Edit"), style: UIAlertAction.Style.default) { (action) -> Void in
                        
                        if self.HomePostListarray[index.row].type == "text"{
                            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                    let therapiescall = storyBoard.instantiateViewController(withIdentifier: "CreatePostVCpuch") as! CreatePostVC
                                    therapiescall.textforEditString = self.HomePostListarray[index.row].content
                                    therapiescall.selectedcategoriid = Int(self.HomePostListarray[index.row].categoryId) ?? 0
                                    therapiescall.wheretoCome = 1
                                    therapiescall.postidString = self.HomePostListarray[index.row].postId
                                                       
                            
                                    self.navigationController?.pushViewController(therapiescall, animated: true)
                            
                            
                        }else if self.HomePostListarray[index.row].type == "youtube" {
                            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                     let therapiescall = storyBoard.instantiateViewController(withIdentifier: "CreateYoutubeVideoPostVCpuch") as! CreateYoutubeVideoPostVC
                            therapiescall.linkforEditStirng = self.HomePostListarray[index.row].youtube
                            therapiescall.textforEditString = self.HomePostListarray[index.row].content
                            therapiescall.selectedcategoriid = Int(self.HomePostListarray[index.row].categoryId) ?? 0
                            therapiescall.wheretoCome = 1
                            therapiescall.postidString = self.HomePostListarray[index.row].postId
                                     self.navigationController?.pushViewController(therapiescall, animated: true)
                            
                        }else if self.HomePostListarray[index.row].type == "video" {
                            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                           let therapiescall = storyBoard.instantiateViewController(withIdentifier: "CreateVideoPostVCpuch") as! CreateVideoPostVC
                            
                            therapiescall.textforEditString = self.HomePostListarray[index.row].content
                            therapiescall.selectedcategoriid = Int(self.HomePostListarray[index.row].categoryId) ?? 0
                            therapiescall.wheretoCome = 1
                            therapiescall.postidString = self.HomePostListarray[index.row].postId
                             therapiescall.linkforEditStirng = self.HomePostListarray[index.row].media
                            
                                           self.navigationController?.pushViewController(therapiescall, animated: true)
                            
                            
                        }else if self.HomePostListarray[index.row].type == "image" {
                            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                         let therapiescall = storyBoard.instantiateViewController(withIdentifier: "CreateImagePostVCpuch") as! CreateImagePostVC
                                                      therapiescall.textforEditString = self.HomePostListarray[index.row].content
                                                      therapiescall.selectedcategoriid = Int(self.HomePostListarray[index.row].categoryId) ?? 0
                                                      therapiescall.wheretoCome = 1
                                                      therapiescall.postidString = self.HomePostListarray[index.row].postId
                                                        therapiescall.linkforEditStirng = self.HomePostListarray[index.row].media
                            
                                         self.navigationController?.pushViewController(therapiescall, animated: true)
                        }
                        
                    }
                    let deleteAction = UIAlertAction(title: GLocalizedString(key: "Delete"), style: UIAlertAction.Style.default) { (action) -> Void in
                        
                        let alert = CDAlertView(title: GLocalizedString(key: "Confirmation"), message: GLocalizedString(key: "PostDeleteConfirmation"), type: .warning)
                              
                                  let doneAction = CDAlertViewAction(title: GLocalizedString(key: "OK"), font: nil, textColor: UIColor.black, backgroundColor: UIColor.white) { (doneAction) -> Bool in
                                     self.DeletePostAPICall(postids: self.HomePostListarray[index.row].postId)
                                                                self.HomePostListarray.remove(at: index.row)
                                                                  let indexPath = IndexPath(item: index.row, section: 0)
                                                                  self.UserPostListTable.deleteRows(at: [indexPath], with: .automatic)
                                    
                                     
                                    
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
                                    self.lblReportPost.text = GLocalizedString(key:"home_ReportPost")
                                    self.ReportSpamTextview.placeholder = GLocalizedString(key: "home_ReportSpamText")
                                    self.ReportSpamLastCancelBtn.setTitle(GLocalizedString(key: "Cancel"), for: .normal)
                                    self.ReportSubmitBtn.setTitle(GLocalizedString(key: "home_ReportPost"), for: .normal)
                                   self.reportspamPostIds = self.HomePostListarray[index.row].postId
                                    
                                 }
            reportAction.titleTextColor = UIColor(red: 224.0/255.0, green: 60.0/255.0, blue: 113.0/255.0, alpha: 1.0)
            actionSheetController.addAction(reportAction)

        }
                    //TODO:Share
                      let shareAction = UIAlertAction(title: GLocalizedString(key: "Share"), style: UIAlertAction.Style.default) { (action) -> Void in
                        let message = self.HomePostListarray[index.row].content
                        let meadi = self.HomePostListarray[index.row].media
                            if let link = NSURL(string: "https://itunes.apple.com/app/id1519398477")
                            {
                                let objectsToShare = [meadi,message,link] as [Any]
                                let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
//                                activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList]
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
        
        return HomePostListarray.count
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        //  return 60
        
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomePostListCell") as! HomePostListCell
        cell.selectionStyle = .none
        
        cell.delegate = self
        cell.indexPath = indexPath

        
         cell.Homepostdata = self.HomePostListarray[indexPath.row]
     
        cell.lblWriteAComment.text = GLocalizedString(key: "home_WriteComment")
        cell.btnPost.setTitle(GLocalizedString(key: "Post"), for: .normal)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         
    }
    
     func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let videoCell = (cell as? HomePostListCell) else { return }
        //videoCell.VideoView.player?.
//        videoCell.VideoView.player?.play()
//        videoCell.videoPlayButtonButton.setImage(UIImage(named: ""), for: .normal)
//        NotificationCenter.default.addObserver(forName: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil, queue: nil) { notification in
//            videoCell.VideoView.player?.seek(to: CMTime.zero)
//         videoCell.VideoView.player?.play()
//        }
        if islastrecord{
            
        }else{
            let lastSectionIndex = tableView.numberOfSections - 1
                        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
                   
                   self.lastpostidsString = self.HomePostListarray[lastRowIndex].postId
                   
                        if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex {

                            spinner = UIActivityIndicatorView(style: .gray)
                            spinner.startAnimating()
                            
                            spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
                            
                            self.UserPostListTable.tableFooterView = spinner
                            self.UserPostListTable.tableFooterView?.isHidden = false
                            self.bootamTorefresh()
           }
        }
    }
    
     func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        guard let videoCell = cell as? HomePostListCell else { return }
//
//        videoCell.VideoView.player?.pause()
//        videoCell.videoPlayButtonButton.setImage(UIImage(named: "Videoplay"), for: .normal)
//       videoCell.VideoView.player = nil
    }
}
extension UIAlertAction {
    var titleTextColor: UIColor? {
        get {
            return self.value(forKey: "titleTextColor") as? UIColor
        } set {
            self.setValue(newValue, forKey: "titleTextColor")
        }
    }
}
