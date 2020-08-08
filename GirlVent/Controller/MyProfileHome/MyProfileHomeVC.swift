//
//  MyProfileHomeVC.swift
//  Girlvent
//
//  Created by Glasier Inc. on 04/01/20.
//  Copyright © 2020 Glasier Inc. All rights reserved.
//

import UIKit
import UITextField_Shake
import CDAlertView
import AVFoundation
import AVKit
import DropDown
import UITextView_Placeholder

class MyProfileHomeVC: UIViewController,UINavigationControllerDelegate, UIImagePickerControllerDelegate{
   
    

    
      var HomePostListarray = [UserPostListPostDetail]()
    @IBOutlet weak var UserProfilePostListTable: UITableView!
    @IBOutlet weak var MyProfileMenuButton: UIButton!
    @IBOutlet weak var MyProfileBackButton: UIButton!
    @IBOutlet weak var UserProfilePicImageview: UIImageView!
    @IBOutlet weak var UserNameLable: UILabel!
    @IBOutlet weak var UserbioTextview: UITextView!
    @IBOutlet weak var MyProfileImageButton: UIButton!
    let notificationName = Notification.Name("MyPostVCCome")
         let imagesnotificationName = Notification.Name("MyimagesVCCome")
         let videonotificationName = Notification.Name("MyvideoVCCome")
    
    @IBOutlet weak var imagePostZoomView: UIView!
   @IBOutlet weak var ImageZoomCamcelButton: UIButton!
        @IBOutlet weak var imagePostZoomImageView: UIImageView!
        @IBOutlet weak var imagepostZoomimagescrolView: UIScrollView!
                var offset = 0
    var otheruser = "0"
    var otheruserids = "0"
    var mediaUrl:URL!
    var imageData:Data!
    @IBOutlet weak var SendMessageView: UIView!
    @IBOutlet weak var SendMsgCancelBtn: UIButton!
    @IBOutlet weak var SendMsgTextview: UITextView!
    @IBOutlet weak var SendMsgAttachmentLable: UILabel!
    @IBOutlet weak var SendMsgBtn: UIButton!
    @IBOutlet weak var AddAttachmentBtn: UIButton!
    
    @IBOutlet var lblNewMessage: UILabel!
    
   
    var whoselectmedia = ""
    
      var UIPicker = UIImagePickerController()
    
    var reportspamPostIds = 0
    @IBOutlet weak var ReportSpamView: UIView!
    @IBOutlet weak var ReportSpamCancelBtn: UIButton!
    @IBOutlet weak var ReportSpamTextview: UITextView!
    @IBOutlet weak var ReportSpamLastCancelBtn: UIButton!
    @IBOutlet weak var ReportSubmitBtn: UIButton!
    
    @IBOutlet var lblReportPost: UILabel!
    
    
    
    @IBOutlet weak var TitleLable: UILabel!
    var ReportListArray: [String] = ["Clean out closet.","Clean out closet.","Clean out closet.","Clean out closet.","Clean out closet."]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        TitleLable.text = GLocalizedString(key: "menu_MyProfile")
        lblNewMessage.text = GLocalizedString(key: "message_title")
        SendMsgTextview.placeholder = GLocalizedString(key: "WriteSomething")
        SendMsgBtn.setTitle(GLocalizedString(key: "message_SendMessage"), for: .normal)
        AddAttachmentBtn.setTitle(GLocalizedString(key: "message_AddAttachment"), for: .normal)
        
        ReportSpamTextview.placeholder = GLocalizedString(key: "home_ReportSpamText")
        ReportSpamLastCancelBtn.setTitle(GLocalizedString(key: "Cancel"), for: .normal)
        ReportSubmitBtn.setTitle(GLocalizedString(key: "home_ReportPost"), for: .normal)
        self.lblReportPost.text = GLocalizedString(key:"home_ReportPost")

            UIPicker.delegate = self
            ReportSpamView.isHidden = true
            ReportListArray.removeAll()
            GetReportSpamListAPICall()
    }
    @IBAction func ImageZoomCamcelButtonClick(_ sender: Any) {
            
            self.imagePostZoomView.isHidden = true
        }
    @IBAction func AddAttachmentBtnClick(_ sender: Any) {
        
            self.UIPicker.allowsEditing = false
            self.UIPicker.mediaTypes = ["public.image","public.movie"]
            self.UIPicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            self.UIPicker.modalPresentationStyle = .fullScreen
            self.present(self.UIPicker, animated: true, completion: nil)
    }
    @IBAction func MyProfileImageButtonClick(_ sender: Any) {
        
        imagePostZoomView.isHidden = false
        
        
        
        self.imagePostZoomImageView.image = self.UserProfilePicImageview.image
    }

    
    @IBAction func SendMsgBtnClick(_ sender: Any) {
        
        if CheckFields(){
            SendMsgAPI()
        }

            SendMessageView.isHidden = true
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
    //MARK:- == FUNCTION FOR Get Report Spam List API ==
    func GetReportSpamListAPICall(){
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
                       }else{
                       }
                   }
               }
    @IBAction func ReportSpamLastCancelBtnClick(_ sender: Any) {
         ReportSpamView.isHidden = true
    }
    @IBAction func ReportSpamCancelBtnClick(_ sender: Any) {
         ReportSpamView.isHidden = true
    }
    //MARK:- == FUNCTION FOR Edit reply response API ==
       func ReportSpamPostAPICall(){
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
    @IBAction func SendMsgCancelBtnClick(_ sender: Any) {
            SendMessageView.isHidden = true
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
     override func viewWillDisappear(_ animated: Bool) {
             NotificationCenter.default.post(name: NSNotification.Name(rawValue: "myvideostop"), object: nil)
     }
    override func viewWillAppear(_ animated: Bool) {
          super.viewWillAppear(true)
        let user:LoginData = HELPER.getSession()
                  if otheruser == "0"{
                     MyProfileMenuButton.setImage(UIImage(named: "myProfilemenuIcon"), for: .normal)
                    self.TitleLable.text = GLocalizedString(key: "menu_MyProfile")
                  }else{
                      if otheruser == user.token{
                            MyProfileMenuButton.setImage(UIImage(named: "myProfilemenuIcon"), for: .normal)
                        self.TitleLable.text = GLocalizedString(key: "menu_MyProfile")
                      }else{
                            MyProfileMenuButton.setImage(UIImage(named: "ProfileMsgIcon"), for: .normal)
                       
                    }
                  }
        SendMessageView.isHidden = true
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

        setAlphaOfBackgroundViews(alpha: 1)
        GetHomePostAPICall()
    }
    @IBAction func MyProfileBackButtonClick(_ sender: Any) {
        
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let therapiescall = storyBoard.instantiateViewController(withIdentifier: "HomeViewVCpuch") as! HomeViewVC
                self.navigationController?.pushViewController(therapiescall, animated: true)
    }
    @IBAction func MyProfileMenuButtonClick(_ sender: Any) {
        
        let user:LoginData = HELPER.getSession()
        if otheruser == "0"{
            self.view.endEditing(true)
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "MyProfileMenuVcpuch") as! MyProfileMenuVc

            vc.delegate = self
            vc.preferredContentSize = CGSize(width: 300, height: 500)
            vc.modalPresentationStyle = .popover
            let ppc = vc.popoverPresentationController
            ppc?.permittedArrowDirections = .any
            ppc?.delegate = self
            ppc!.sourceView = MyProfileMenuButton
            ppc?.sourceRect = MyProfileMenuButton.bounds

            present(vc, animated: true, completion: nil)

        }else{
            if otheruser == user.token{
                self.view.endEditing(true)
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let vc = storyBoard.instantiateViewController(withIdentifier: "MyProfileMenuVcpuch") as! MyProfileMenuVc

                vc.delegate = self
                vc.preferredContentSize = CGSize(width: 300, height: 500)
                vc.modalPresentationStyle = .popover
                let ppc = vc.popoverPresentationController
                ppc?.permittedArrowDirections = .any
                ppc?.delegate = self
                ppc!.sourceView = MyProfileMenuButton
                ppc?.sourceRect = MyProfileMenuButton.bounds
                present(vc, animated: true, completion: nil)
                                       
            }else{

                SendMessageView.isHidden = false
            }
        }
    }
    //MARK:- == FUNCTION FOR Home Post get API ==
      func GetHomePostAPICall(){
          let param = [
              "language":"english"
              ] as [String : AnyObject]
          
          print(param)
        let user:LoginData = HELPER.getSession()
        var usertokan = ""

        if otheruser == "0"{
            usertokan = user.token
        }else{
            
            usertokan = otheruser
        }
        

          
          APIHelper.shared.GetUserPostListAPIcall(parameter: param,UserTokan:usertokan ) { (success, result) in
              
            if(result.data != nil){
                  if(success){
             
                    self.HomePostListarray = result.data.postDetail
                    if self.HomePostListarray.count == 0{
                                          let alert = CDAlertView(title: nil, message:GLocalizedString(key: "NoPostFound"), type: .error)
                                                                  let doneAction = CDAlertViewAction(title: GLocalizedString(key: "OK"), font: nil, textColor: UIColor.black, backgroundColor: UIColor.white) { (doneAction) -> Bool in
                                                                   
                                                                      return true
                                                                  }
                                                                  alert.add(action: doneAction)
                                                                  alert.circleFillColor = ALERT_COLOR
                                                                  alert.show()
                                      }else{
                                      }
                    self.UserNameLable.text = result.data.userInfo.username
                    self.UserbioTextview.text = result.data.userInfo.bio
                    if self.otheruser == "0"{
                                
                                self.TitleLable.text = GLocalizedString(key: "menu_MyProfile")
                              }else{
                        if self.otheruser == user.token{
                                       
                                    self.TitleLable.text = GLocalizedString(key: "menu_MyProfile")
                                  }else{
                                       self.TitleLable.text = result.data.userInfo.username + "\(GLocalizedString(key: "'s Profile"))"
                                   
                                }
                              }
                    
                     
                      if let urlt = result.data.userInfo.profileUrl
                                    {
                                        if (urlt != ""){
                                            let urlf = URL(string: urlt)!
                                            // let image2 = UIImageView()
                                            self.UserProfilePicImageview.sd_setImage(with: urlf, placeholderImage:UIImage(named: "GirlVentLogo"), options: .delayPlaceholder, completed: { (image, error, cacheType, imageURL) in
                                            })
                                        }
                                    }
                      self.UserProfilePostListTable.reloadData()
                  }
              } else{
                  
               
                  print("Not Success")
              }
          }
          
      }

    //MARK: -ImagePickerView Delegates
     
              func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
               
                
                   if let chosenImage = info[.originalImage] as? UIImage {
                    whoselectmedia = "0"
                     imageData = chosenImage.pngData()

                if let url = info[UIImagePickerController.InfoKey.imageURL] as? URL {
                    self.SendMsgAttachmentLable.text  = url.lastPathComponent
                    mediaUrl =  url
              
                }else{
                    
                    if (picker.sourceType == UIImagePickerController.SourceType.camera) {

                        let imgName = UUID().uuidString
                        let documentDirectory = NSTemporaryDirectory()
                        let localPath = documentDirectory.appending(imgName)

                        let data = chosenImage.jpegData(compressionQuality: 0.3)! as NSData
                        data.write(toFile: localPath, atomically: true)
                        let photoURL = URL.init(fileURLWithPath: localPath)
                           mediaUrl =  photoURL
                        self.SendMsgAttachmentLable.text  = photoURL.lastPathComponent

                    }
                }

                   }else{
                    
                    
                    if let mediaType = info[UIImagePickerController.InfoKey.mediaType] as? String {
                                                                     if mediaType == "public.movie" {
                                                                         whoselectmedia = "1"
                                                                         print("Video Selected")
                                                                        
                                                                        let videoURL = info[UIImagePickerController.InfoKey.mediaURL] as! URL
                                                                        
                                                                        
                                                                        let data = NSData(contentsOf: videoURL as URL)!
                                                                        print("File size before compression: \(Double(data.length / 1048576)) mb")
                                                                        let compressedURL = NSURL.fileURL(withPath: NSTemporaryDirectory() + NSUUID().uuidString + ".mp4")
                                                                        compressVideo(inputURL: videoURL , outputURL: compressedURL) { (exportSession) in
                                                                            guard let session = exportSession else {
                                                                                return
                                                                            }
                                                                            switch session.status {
                                                                                case .unknown:
                                                                                    break
                                                                                case .waiting:
                                                                                    break
                                                                                case .exporting:
                                                                                    break
                                                                                case .completed:
                                                                                    self.mediaUrl =  videoURL
                                                                                    self.SendMsgAttachmentLable.text  = videoURL.lastPathComponent
                                                                                    guard let compressedData = NSData(contentsOf: compressedURL) else {
                                                                                        return
                                                                                    }
                                                                                    print("File size after compression: \(Double(compressedData.length / 1048576)) mb")
                                                                                case .failed:
                                                                                    break
                                                                                case .cancelled:
                                                                                    break
                                                                                @unknown default: break
                                                                            }
                                                                        }
                                                                    }
                                                                 }
                                    }
                                    dismiss(animated: true, completion: nil)
                                  }
                        
        func compressVideo(inputURL: URL, outputURL: URL, handler:@escaping (_ exportSession: AVAssetExportSession?)-> Void) {
            let urlAsset = AVURLAsset(url: inputURL, options: nil)
            guard let exportSession = AVAssetExportSession(asset: urlAsset, presetName: AVAssetExportPresetLowQuality) else {
                handler(nil)
                    return
                }
                exportSession.outputURL = outputURL
                exportSession.outputFileType = AVFileType.mp4
                exportSession.shouldOptimizeForNetworkUse = true
                exportSession.exportAsynchronously { () -> Void in
                handler(exportSession)
                                 }
                             }
              func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
              {
                   
                  dismiss(animated: true, completion: nil)
              }
     override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        }
        
        
        func viewForZooming(in scrollView: UIScrollView) -> UIView? {
            return imagePostZoomImageView
        }
    
    func CheckFields() -> Bool
    {
                   
                       
        if (SendMsgTextview.text?.trimmingCharacters(in: .whitespaces).isEmpty)! && whoselectmedia == ""
                         {
                             
                             
                             let alert = CDAlertView(title: GLocalizedString(key: "Hang On"), message: GLocalizedString(key: "AddAnyContentOrAttachment"), type: .warning)
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
     //MARK:- == FUNCTION FOR Submit POST API ==
                 func SendMsgAPI(){
                     
                  if whoselectmedia == ""{
                        imageData = nil
                        mediaUrl = nil
                        
                    }
                    APIHelper.shared.SendMsgAPIcall(Messge: SendMsgTextview.text!, toUserid: otheruserids, Language: "english", userPostvideo:mediaUrl ?? NSURL() as URL,userpostimage:imageData ?? NSData() as Data,whocome:whoselectmedia,completion:{ (success, response) in
                        
                        
                         
                             if(success){
                               
                              let alert = CDAlertView(title: GLocalizedString(key: "Success"), message: GLocalizedString(key: "MessageSent"), type: .success)
                                                                                         let doneAction = CDAlertViewAction(title: GLocalizedString(key: "OK"), font: nil, textColor: UIColor.black, backgroundColor: UIColor.white) { (doneAction) -> Bool in
                                                                                            self.SendMsgTextview.text = ""
                                                                                            self.SendMsgAttachmentLable.text = ""
                                                                                            self.imagePostZoomView.isHidden = true
                                                                                             return true
                                                                                         }
                                                                                         alert.add(action: doneAction)
                                                                                         alert.circleFillColor = ALERT_COLOR
                                                                                         alert.show()
                           
                             }else{
                             
                          
                             print("Not Success")
                         }
                     })
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
    
}
extension MyProfileHomeVC : UITableViewDelegate , UITableViewDataSource,MyProfilePostListCellDelegate {
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
        
//                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//                      let therapiescall = storyBoard.instantiateViewController(withIdentifier: "MyProfileHomeVCpuch") as! MyProfileHomeVC
//                     self.navigationController?.pushViewController(therapiescall, animated: true)
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
                            therapiescall.selectedcategoriid = Int(self.HomePostListarray[index.row].categoryId)!
                                                          therapiescall.wheretoCome = 1
                                                          therapiescall.postidString = self.HomePostListarray[index.row].postId
                                                                             
                                                  
                                                          self.navigationController?.pushViewController(therapiescall, animated: true)
                                                  
                                                  
                                              }else if self.HomePostListarray[index.row].type == "youtube" {
                                                  let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                                           let therapiescall = storyBoard.instantiateViewController(withIdentifier: "CreateYoutubeVideoPostVCpuch") as! CreateYoutubeVideoPostVC
                                                  therapiescall.linkforEditStirng = self.HomePostListarray[index.row].youtube
                                                  therapiescall.textforEditString = self.HomePostListarray[index.row].content
                            therapiescall.selectedcategoriid = Int(self.HomePostListarray[index.row].categoryId)!
                                                  therapiescall.wheretoCome = 1
                                                  therapiescall.postidString = self.HomePostListarray[index.row].postId
                                                           self.navigationController?.pushViewController(therapiescall, animated: true)
                                                  
                                              }else if self.HomePostListarray[index.row].type == "video" {
                                                  let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                                                 let therapiescall = storyBoard.instantiateViewController(withIdentifier: "CreateVideoPostVCpuch") as! CreateVideoPostVC
                                                  
                                                  therapiescall.textforEditString = self.HomePostListarray[index.row].content
                            therapiescall.selectedcategoriid = Int(self.HomePostListarray[index.row].categoryId)!
                                                  therapiescall.wheretoCome = 1
                                                  therapiescall.postidString = self.HomePostListarray[index.row].postId
                                                   therapiescall.linkforEditStirng = self.HomePostListarray[index.row].media
                                                  
                                                                 self.navigationController?.pushViewController(therapiescall, animated: true)
                                                  
                                                  
                                              }else if self.HomePostListarray[index.row].type == "image" {
                                                  let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                                               let therapiescall = storyBoard.instantiateViewController(withIdentifier: "CreateImagePostVCpuch") as! CreateImagePostVC
                                                                            therapiescall.textforEditString = self.HomePostListarray[index.row].content
                            therapiescall.selectedcategoriid = Int(self.HomePostListarray[index.row].categoryId)! 
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
                                                             self.UserProfilePostListTable.deleteRows(at: [indexPath], with: .automatic)
                                                            
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
                                   self.reportspamPostIds = self.HomePostListarray[index.row].postId
                                 }
            reportAction.titleTextColor = UIColor(red: 224.0/255.0, green: 60.0/255.0, blue: 113.0/255.0, alpha: 1.0)
            actionSheetController.addAction(reportAction)

        }
        
                             let shareAction = UIAlertAction(title: GLocalizedString(key: "Share"), style: UIAlertAction.Style.default) { (action) -> Void in
                                                        let message = self.HomePostListarray[index.row].content
                                                        let meadi = self.HomePostListarray[index.row].media
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
        
        return HomePostListarray.count
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        //  return 60
        
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyProfilePostListCellpuch") as! MyProfilePostListCell
        cell.selectionStyle = .none
        
        
        cell.Homepostdata = self.HomePostListarray[indexPath.row]
              cell.delegate = self
              cell.indexPath = indexPath
        
     
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         
    }
    
     func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let videoCell = (cell as? HomePostListCell) else { return }
               
             //  videoCell.VideoView.player?.pause()
    }
    
     func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let videoCell = cell as? HomePostListCell else { return }
        
//        videoCell.VideoView.player?.pause()
//       videoCell.VideoView.player = nil
    }
}
extension MyProfileHomeVC : UIPopoverPresentationControllerDelegate{
    
         //MARK:- ======================   UIPopoverPresentationControllerDelegate  ==========================
      func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {
          setAlphaOfBackgroundViews(alpha: 1)
      }
      
      func prepareForPopoverPresentation(_ popoverPresentationController: UIPopoverPresentationController) {
          setAlphaOfBackgroundViews(alpha: 0.7)
      }

      func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
          // Tells iOS that we do NOT want to adapt the presentation style for iPhone
          return .none
      }
    
      
      func setAlphaOfBackgroundViews(alpha: CGFloat) {
       //   let statusBarWindow = UIApplication.shared.value(forKey: "statusBarWindow") as? UIWindow
          UIView.animate(withDuration: 0.2) {
            //  statusBarWindow?.alpha = alpha;
              self.view.alpha = alpha;
            //  self.navigationController?.navigationBar.alpha = alpha;
          }
      }
    
    
}
extension MyProfileHomeVC : MyProfileMenuOptionCellDelegate{
    
    
    func MyPostsButtonTapped() {
              self.dismiss(animated: true, completion: nil)
           let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                            let therapiescall = storyBoard.instantiateViewController(withIdentifier: "MyProfileHomeVCpuch") as! MyProfileHomeVC
                           self.navigationController?.pushViewController(therapiescall, animated: true)
               
       }
       
       func MyMessagesButtonTapped() {
        
        self.dismiss(animated: true, completion: nil)
               let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
               let therapiescall = storyBoard.instantiateViewController(withIdentifier: "MyMessagesVc") as! MyMessagesVc
               self.navigationController?.pushViewController(therapiescall, animated: true)
           
       }
       
       func EditProfileButtonTapped() {
        
        self.dismiss(animated: true, completion: nil)
             let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
             let therapiescall = storyBoard.instantiateViewController(withIdentifier: "EditProfileVc") as! EditProfileVc
             self.navigationController?.pushViewController(therapiescall, animated: true)

       }
       
       func MyImagesButtonTapped() {
              self.dismiss(animated: true, completion: nil)
           let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
           let therapiescall = storyBoard.instantiateViewController(withIdentifier: "MyImagesVCpuch") as! MyImagesVC
           self.navigationController?.pushViewController(therapiescall, animated: true)
       }
       
       func MyVideosButtonTapped() {
           self.dismiss(animated: true, completion: nil)

               let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                               let therapiescall = storyBoard.instantiateViewController(withIdentifier: "MyVideosVCpuch") as! MyVideosVC
                               self.navigationController?.pushViewController(therapiescall, animated: true)
       }
}
