//
//  MyMessagesVc.swift
//  Girlvent
//
//  Created by Glasier Inc. on 29/01/20.
//  Copyright © 2020 Glasier Inc. All rights reserved.
//

import UIKit
import UITextField_Shake
import CDAlertView

class MyMessagesVc: UIViewController {

    @IBOutlet weak var MyMassgeBackBtn: UIButton!
    @IBOutlet weak var MyMassgeMenuBtn: UIButton!
    @IBOutlet weak var MyMassageProfileImage: UIImageView!
    @IBOutlet weak var UserNameLable: UILabel!
    @IBOutlet weak var UserBioTextview: UITextView!
    @IBOutlet weak var MessageListTableView: UITableView!
    @IBOutlet weak var Nomessageview: UIView!
    var MymessageListarray = [GetMyMessageListMyMessage]()
    
    var wheretoconform = "0"
    
    
    
    @IBOutlet weak var MyProfileImageButton: UIButton!

         
         
         @IBOutlet weak var imagePostZoomView: UIView!

             @IBOutlet weak var imagePostZoomImageView: UIImageView!
             @IBOutlet weak var imagepostZoomimagescrolView: UIScrollView!
                     var offset = 0
            @IBOutlet weak var ImageZoomCamcelButton: UIButton!
    
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblNoMessage: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblTitle.text = GLocalizedString(key: "menu_MyMessages")
        lblNoMessage.text = GLocalizedString(key: "mymessage_NoMessages")

        Nomessageview.isHidden = true
        GetmyMessageAPICall()
        
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
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func MyProfileImageButtonClick(_ sender: Any) {
              
              imagePostZoomView.isHidden = false
              
              
              
              self.imagePostZoomImageView.image = self.MyMassageProfileImage.image
          }
          @IBAction func ImageZoomCamcelButtonClick(_ sender: Any) {
                 
                    self.imagePostZoomView.isHidden = true
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
       override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
           //        if (dropper.isHidden == false) { // Checks if Dropper is visible
           //            dropper.hideWithAnimation(0.1) // Hides Dropper
           //        }
               }
               
               
               func viewForZooming(in scrollView: UIScrollView) -> UIView? {
                   return imagePostZoomImageView
               }


    @IBAction func MyMassgeMenuBtnClick(_ sender: Any) {
        
        
               self.view.endEditing(true)
                   let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                   let vc = storyBoard.instantiateViewController(withIdentifier: "MyProfileMenuVcpuch") as! MyProfileMenuVc
                   //vc.CityNameArray = self.CityNamepasss
                    vc.delegate = self
              
                   vc.preferredContentSize = CGSize(width: 300, height: 500)
                   vc.modalPresentationStyle = .popover
                   let ppc = vc.popoverPresentationController
                   ppc?.permittedArrowDirections = .any
                   ppc?.delegate = self
                   ppc!.sourceView = MyMassgeMenuBtn
                   ppc?.sourceRect = MyMassgeMenuBtn.bounds
                   
                   present(vc, animated: true, completion: nil)
               
        
        
    }
    @IBAction func MyMassgeBackBtnClick(_ sender: Any) {
       
        if wheretoconform == "0"{
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                     let therapiescall = storyBoard.instantiateViewController(withIdentifier: "MyProfileHomeVCpuch") as! MyProfileHomeVC
                    self.navigationController?.pushViewController(therapiescall, animated: true)
        }else{
            self.navigationController?.popViewController(animated: true)
            
        }

        
    }
    //MARK:- == FUNCTION FOR Delete My Message API ==
    func DeleteMyMessaheAPICall(MessageId:Int){
              //let TokenId = UserDefaults.value(forKey: "TokenId") as! String
              
              
              let param = [
                  "language":"english",
                  "message_id":MessageId
                  ] as [String : AnyObject]
              
              print(param)
              
              APIHelper.shared.DeleteMyMessageAPIcall(parameter: param) { (success, result) in
                  
             
                      if(success){
                      
                               let alert = CDAlertView(title: GLocalizedString(key: "Success"), message: GLocalizedString(key: "MessageDeleted"), type: .success)
                                                                                                                                         let doneAction = CDAlertViewAction(title: GLocalizedString(key: "OK"), font: nil, textColor: UIColor.black, backgroundColor: UIColor.white) { (doneAction) -> Bool in
                                                                                                                                           self.GetmyMessageAPICall()
                                                                                                                                             return true
                                                                                                                                         }
                                                                                                                                         alert.add(action: doneAction)
                                                                                                                                         alert.circleFillColor = ALERT_COLOR
                                                                                                                                         alert.show()
                         }
                        
                        
                      
                    
                 
              }
              
          }
    //MARK:- == FUNCTION FOR get my message API ==
      func GetmyMessageAPICall(){
                //let TokenId = UserDefaults.value(forKey: "TokenId") as! String
                
                
                let param = [
                    "language":"english"
                    ] as [String : AnyObject]
                
                print(param)
                
                APIHelper.shared.GetMyMessageListAPIcall(parameter: param) { (success, result) in
                    
               
                        if(success){
                        
                            self.MymessageListarray = result.data.myMessages
                            if self.MymessageListarray.count == 0{
                                let alert = CDAlertView(title: nil, message:GLocalizedString(key: "mymessage_NoMessages"), type: .error)
                                                        let doneAction = CDAlertViewAction(title: GLocalizedString(key: "OK"), font: nil, textColor: UIColor.black, backgroundColor: UIColor.white) { (doneAction) -> Bool in
                                                         
                                                            return true
                                                        }
                                                        alert.add(action: doneAction)
                                                        alert.circleFillColor = ALERT_COLOR
                                                        alert.show()
                                //self.Nomessageview.isHidden = false
                            }else{
                                //self.Nomessageview.isHidden = true
                            }
                            
                            self.UserNameLable.text = result.data.userInfo.username
                                                self.UserBioTextview.text = result.data.userInfo.bio
                                                  if let urlt = result.data.userInfo.profileUrl
                                                                {
                                                                    if (urlt != ""){
                                                                        let urlf = URL(string: urlt)!

                                                                       self.MyMassageProfileImage.sd_setImage(with: urlf, placeholderImage:UIImage(named: "GirlVentLogo"), options: .delayPlaceholder, completed: { (image, error, cacheType, imageURL) in
                                                                        })
                                                                       
                                                                    }
                                                                }
                                                  self.MessageListTableView.reloadData()
                            
                            
                            
                            
                        }else{
                            let alert = CDAlertView(title: nil, message:GLocalizedString(key: "mymessage_NoMessages"), type: .error)
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
extension MyMessagesVc : UITableViewDelegate , UITableViewDataSource,MyMessageCellDelegate {
    func MassgePostDeleteTapped(at index: IndexPath) {
        
            let alert = CDAlertView(title: GLocalizedString(key: "Confirmation"), message: GLocalizedString(key: "mymessage_MessageDeleteConfirmation"), type: .warning)
            
            let doneAction = CDAlertViewAction(title: GLocalizedString(key: "OK"), font: nil, textColor: UIColor.black, backgroundColor: UIColor.white) { (doneAction) -> Bool in
                    self.DeleteMyMessaheAPICall(MessageId: self.MymessageListarray[index.row].messageId)
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
    
   

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return MymessageListarray.count
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyMessageCell") as! MyMessageCell
        cell.selectionStyle = .none
        cell.delegate = self
        cell.indexPath = indexPath
        cell.MyMessagedata = self.MymessageListarray[indexPath.row]
        
        
       cell.layoutIfNeeded()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         
    }
    
    
}
extension MyMessagesVc : UIPopoverPresentationControllerDelegate{
    
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
extension MyMessagesVc : MyProfileMenuOptionCellDelegate{
    
    
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
