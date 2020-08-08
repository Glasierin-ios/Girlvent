//
//  EditProfileVc.swift
//  Girlvent
//
//  Created by Glasier Inc. on 28/01/20.
//  Copyright © 2020 Glasier Inc. All rights reserved.
//

import UIKit
import UITextField_Shake
import CDAlertView

class EditProfileVc: UIViewController,UINavigationControllerDelegate, UIImagePickerControllerDelegate,UIScrollViewDelegate {

    @IBOutlet weak var EditprofileBackBtn: UIButton!
    @IBOutlet weak var EditProfileMenuBtn: UIButton!
    @IBOutlet weak var UserProfilePicimageview: UIImageView!
    @IBOutlet weak var UserProfilePicBtn: UIButton!
    @IBOutlet weak var ImageUploadBtn: UIButton!
    @IBOutlet weak var FirstNameTxt: UITextField!
    @IBOutlet weak var LastNameTxt: UITextField!
    @IBOutlet weak var SelectMonthTxt: UITextField!
    @IBOutlet weak var SelectDatTxt: UITextField!
    @IBOutlet weak var BioTextView: UITextView!
    @IBOutlet weak var EditInfoSaveBtn: UIButton!
    @IBOutlet weak var PasswordTxt: UITextField!
    @IBOutlet weak var ConfirmPasswordTxt: UITextField!
    @IBOutlet weak var ChnagePasswordBtn: UIButton!
    
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblEditProfile: UILabel!
    @IBOutlet var lblSelectBirthDate: UILabel!
    @IBOutlet var lblChangePassword: UILabel!
    
    
    
    
    
    
      var UIPicker = UIImagePickerController()
    
    let monthListPicker = UIPickerView()
        let daysListPicker = UIPickerView()
    
    let Montharray = ["1","2","3","4","5","6","7","8","9","10","11","12"]
       let dayarray = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31"]
       
    
    var userdatails:UserDetailsData!
    
    @IBOutlet weak var imagePostZoomView: UIView!
  @IBOutlet weak var ImageZoomCamcelButton: UIButton!
     @IBOutlet weak var imagePostZoomImageView: UIImageView!
     @IBOutlet weak var imagepostZoomimagescrolView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblTitle.text = GLocalizedString(key: "pm_EditProfile")
        
        ImageUploadBtn.setTitle(GLocalizedString(key: "Upload"), for: .normal)
        
        
        lblEditProfile.text = GLocalizedString(key: "pm_EditProfile")
        FirstNameTxt.placeholder = GLocalizedString(key: "Register_FirstName")
        LastNameTxt.placeholder = GLocalizedString(key: "Register_LastName")
        
        lblSelectBirthDate.text = GLocalizedString(key: "Register_SelectBirthdate")
        SelectMonthTxt.placeholder = GLocalizedString(key: "Register_SelectMonth")
        SelectDatTxt.placeholder = GLocalizedString(key: "Register_SelectDay")
        EditInfoSaveBtn.setTitle(GLocalizedString(key: "Save Changes"), for: .normal)
        
        lblChangePassword.text = GLocalizedString(key: "ep_ChangePassword")
        PasswordTxt.placeholder = GLocalizedString(key: "Register_Password")
        ConfirmPasswordTxt.placeholder = GLocalizedString(key: "Register_ConfirmPassword")
        
        ChnagePasswordBtn.setTitle(GLocalizedString(key: "ep_ChangePassword"), for: .normal)
        
        
        
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
        SelectMonthTxt.inputView = monthListPicker
                SelectDatTxt.inputView = daysListPicker
                    daysListPicker.delegate = self
                monthListPicker.delegate = self
        
        
  UIPicker.delegate = self
        GetUserdetailsAPICall()

    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    //        if (dropper.isHidden == false) { // Checks if Dropper is visible
    //            dropper.hideWithAnimation(0.1) // Hides Dropper
    //        }
        }
        
        
        func viewForZooming(in scrollView: UIScrollView) -> UIView? {
            return imagePostZoomImageView
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

    @IBAction func ChnagePasswordBtnClick(_ sender: Any) {
        
        if CheckpasswordFields(){
                      ChnagepasswordAPI()
              }
        
    }
    @IBAction func EditInfoSaveBtnClick(_ sender: Any) {
        
        if CheckFields(){
                SubmitUserdetailsAPICall()
        }
    
    }
    @IBAction func ImageUploadBtnClick(_ sender: Any) {
        
        
          changePhoto()
        
        
      
    }
    @IBAction func UserProfilePicBtnClikc(_ sender: Any) {
        
      
        imagePostZoomView.isHidden = false
               
             
               
          
    }
    @IBAction func EditProfileMenuBtnClick(_ sender: Any) {
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
                    ppc!.sourceView = EditProfileMenuBtn
                    ppc?.sourceRect = EditProfileMenuBtn.bounds
                    
                    present(vc, animated: true, completion: nil)
    }
    @IBAction func EditProfileBackBtnClick(_ sender: Any) {
        

        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let therapiescall = storyBoard.instantiateViewController(withIdentifier: "MyProfileHomeVCpuch") as! MyProfileHomeVC
           self.navigationController?.pushViewController(therapiescall, animated: true)
    }
    
           // MARK: - Functions
func CheckFields() -> Bool{
    
    if (FirstNameTxt.text?.trimmingCharacters(in: .whitespaces).isEmpty)!{
        
                                                            self.FirstNameTxt.shake(10,withDelta: 5.0,speed: 0.03,shakeDirection: ShakeDirection.horizontal)
                                                            
                                                            let alert = CDAlertView(title: GLocalizedString(key: "Hang On"), message: GLocalizedString(key: "EnterFirstName"), type: .warning)
                                                            let doneAction = CDAlertViewAction(title: GLocalizedString(key: "OK"), font: nil, textColor: UIColor.black, backgroundColor: UIColor.white) { (doneAction) -> Bool in
                                                                return true
                                                            }
                                                            alert.add(action: doneAction)
                                                            alert.circleFillColor = ALERT_COLOR
                                                            alert.show()
                                                            let test = false
                                                            return test
    }
    if (LastNameTxt.text?.trimmingCharacters(in: .whitespaces).isEmpty)!{
        
                                                   self.LastNameTxt.shake(10,withDelta: 5.0,speed: 0.03,shakeDirection: ShakeDirection.horizontal)
                                                   
                                                   let alert = CDAlertView(title: GLocalizedString(key: "Hang On"), message: GLocalizedString(key: "EnterLastName"), type: .warning)
                                                   let doneAction = CDAlertViewAction(title: GLocalizedString(key: "OK"), font: nil, textColor: UIColor.black, backgroundColor: UIColor.white) { (doneAction) -> Bool in
                                                       return true
                                                   }
                                                   alert.add(action: doneAction)
                                                   alert.circleFillColor = ALERT_COLOR
                                                   alert.show()
                                                   let test = false
                                                   return test
    }
  
//        if (SelectMonthTxt.text?.trimmingCharacters(in: .whitespaces).isEmpty)!
//                     {
//                         self.SelectMonthTxt.shake(10,withDelta: 5.0,speed: 0.03,shakeDirection: ShakeDirection.horizontal)
//                         
//                         let alert = CDAlertView(title: "Hang On!", message: "Please select Birth month", type: .warning)
//                         let doneAction = CDAlertViewAction(title: "Ok", font: nil, textColor: UIColor.black, backgroundColor: UIColor.white) { (doneAction) -> Bool in
//                             return true
//                         }
//                         alert.add(action: doneAction)
//                         alert.circleFillColor = ALERT_COLOR
//                         alert.show()
//                         let test = false
//                         return test
//                     }
//    if (SelectDatTxt.text?.trimmingCharacters(in: .whitespaces).isEmpty)!
//                 {
//                     self.SelectDatTxt.shake(10,withDelta: 5.0,speed: 0.03,shakeDirection: ShakeDirection.horizontal)
//                     
//                     let alert = CDAlertView(title: "Hang On!", message: "Please select Birth day", type: .warning)
//                     let doneAction = CDAlertViewAction(title: "Ok", font: nil, textColor: UIColor.black, backgroundColor: UIColor.white) { (doneAction) -> Bool in
//                         return true
//                     }
//                     alert.add(action: doneAction)
//                     alert.circleFillColor = ALERT_COLOR
//                     alert.show()
//                     let test = false
//                     return test
//                 }
                 
                 let test = true
                    return test
                }
    
    func CheckpasswordFields() -> Bool{
    

        if (PasswordTxt.text?.trimmingCharacters(in: .whitespaces).isEmpty)!
       {
           self.PasswordTxt.shake(10,withDelta: 5.0,speed: 0.03,shakeDirection: ShakeDirection.horizontal)
           
           let alert = CDAlertView(title: GLocalizedString(key: "Hang On"), message: GLocalizedString(key: "EnterPassword"), type: .warning)
           let doneAction = CDAlertViewAction(title: GLocalizedString(key: "OK"), font: nil, textColor: UIColor.black, backgroundColor: UIColor.white) { (doneAction) -> Bool in
               return true
           }
           alert.add(action: doneAction)
           alert.circleFillColor = ALERT_COLOR
           alert.show()
           let test = false
           return test
       }
        if (ConfirmPasswordTxt.text?.trimmingCharacters(in: .whitespaces).isEmpty)!
                    {
                        self.ConfirmPasswordTxt.shake(10,withDelta: 5.0,speed: 0.03,shakeDirection: ShakeDirection.horizontal)
                        
                        let alert = CDAlertView(title: GLocalizedString(key: "Hang On"), message: GLocalizedString(key: "EnterConfirmPassword"), type: .warning)
                        let doneAction = CDAlertViewAction(title: GLocalizedString(key: "OK"), font: nil, textColor: UIColor.black, backgroundColor: UIColor.white) { (doneAction) -> Bool in
                            return true
                        }
                        alert.add(action: doneAction)
                        alert.circleFillColor = ALERT_COLOR
                        alert.show()
                        let test = false
                        return test
        }else if PasswordTxt.text != ConfirmPasswordTxt.text{
            
            self.ConfirmPasswordTxt.shake(10,withDelta: 5.0,speed: 0.03,shakeDirection: ShakeDirection.horizontal)
            self.PasswordTxt.shake(10,withDelta: 5.0,speed: 0.03,shakeDirection: ShakeDirection.horizontal)
                                           let alert = CDAlertView(title: GLocalizedString(key: "Hang On"), message: GLocalizedString(key: "PasswordValidationMessage"), type: .warning)
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
    //MARK:- == FUNCTION FOR CHANGE PASSWORD API ==
    func SubmituserimageAPI(){
        let sdata = UserProfilePicimageview.image!.jpegData(compressionQuality: 0.3)!
        if sdata.isEmpty
        {
            let alert = CDAlertView(title: GLocalizedString(key: "cm_SelectImage"), message: GLocalizedString(key: "SelectAnyImage"), type: .error)
                                                                                               let doneAction = CDAlertViewAction(title: GLocalizedString(key: GLocalizedString(key: "OK")), font: nil, textColor: UIColor.black, backgroundColor: UIColor.white) { (doneAction) -> Bool in
                                                                                                 
                                                                                                  
                                                                                                 
                                                                                                   return true
                                                                                               }
                                                                                               alert.add(action: doneAction)
                                                                                               alert.circleFillColor = ALERT_COLOR
                                                                                               alert.show()
            
            return
        }

        APIHelper.shared.UserUpdateProfilePicAPIcall(userpostimage: UserProfilePicimageview.image!.jpegData(compressionQuality: 0.3)!, completion:{ (success, response) in
                    
                    
                        if(success){
                          
                         let alert = CDAlertView(title: GLocalizedString(key: "Success"), message: GLocalizedString(key: "ProfilePictureUpdated"), type: .success)
                                                                                    let doneAction = CDAlertViewAction(title: GLocalizedString(key: "OK"), font: nil, textColor: UIColor.black, backgroundColor: UIColor.white) { (doneAction) -> Bool in
                                                                                      
                                                                                        self.PasswordTxt.text = ""
                                                                                        self.ConfirmPasswordTxt.text = ""
                                                                                        
                                                                                                     self.GetUserdetailsAPICall()
                                                                                      
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
    
    //MARK:- == FUNCTION FOR submit user profile pic API ==
    func ChnagepasswordAPI(){

        
                        let user:LoginData = HELPER.getSession()
        
                       let param = [
                           "language":"english",
                           "password":ConfirmPasswordTxt.text!,
                           "email":user.email
                           ] as [String : AnyObject]
                       
                       print(param)
                       
                       APIHelper.shared.ChnagepasswordAPIcall(parameter: param) { (success, result) in
                           
                          if(result.error == 200){
                               if(success){
                                  
                                  let alert = CDAlertView(title: GLocalizedString(key: "Success"), message: GLocalizedString(key: "PasswordChanged"), type: .success)
                                                     let doneAction = CDAlertViewAction(title: GLocalizedString(key: "OK"), font: nil, textColor: UIColor.black, backgroundColor: UIColor.white) { (doneAction) -> Bool in
                                                      self.GetUserdetailsAPICall()
                                                         return true
                                                     }
                                                     alert.add(action: doneAction)
                                                     alert.circleFillColor = ALERT_COLOR
                                                     alert.show()
                                  
                               }
                           } else{
                               
                        
                               print("Not Success")
                           }
                       }
     }
    //MARK:- == FUNCTION FOR submit user details API ==
             func SubmitUserdetailsAPICall(){
                 //let TokenId = UserDefaults.value(forKey: "TokenId") as! String
                 
                 
                 let param = [
                     "language":"english",
                     "firstname":FirstNameTxt.text!,
                     "lastname":LastNameTxt.text!,
                     "birth_date":SelectDatTxt.text!,
                     "birth_month":SelectMonthTxt.text!,
                     "bio":BioTextView.text!
                     ] as [String : AnyObject]
                 
                 print(param)
                 
                 APIHelper.shared.SubmitUserDetailaPIcall(parameter: param) { (success, result) in
                     
                    if(result.error == 200){
                         if(success){
                            
                            let alert = CDAlertView(title: GLocalizedString(key: "Success"), message: result.message, type: .success)
                                               let doneAction = CDAlertViewAction(title: GLocalizedString(key: "OK"), font: nil, textColor: UIColor.black, backgroundColor: UIColor.white) { (doneAction) -> Bool in
                                                self.GetUserdetailsAPICall()
                                                   return true
                                               }
                                               alert.add(action: doneAction)
                                               alert.circleFillColor = ALERT_COLOR
                                               alert.show()
                            
                         }
                     } else{
                         
                  
                         print("Not Success")
                     }
                 }
                 
             }
    //MARK:- == FUNCTION FOR get user details API ==
          func GetUserdetailsAPICall(){
              //let TokenId = UserDefaults.value(forKey: "TokenId") as! String
              
              
              let param = [
                  "language":"english"
                  ] as [String : AnyObject]
              
              print(param)
              
              APIHelper.shared.GetUserDetailaPIcall(parameter: param) { (success, result) in
                  
                if(result.data != nil){
                      if(success){
                 
                        self.userdatails = result.data
                      
                        self.FirstNameTxt.text = result.data.firstname
                        self.LastNameTxt.text = result.data.lastname
                        self.SelectMonthTxt.text = result.data.birthMonth
                        self.SelectDatTxt.text = result.data.birthDay
                        self.BioTextView.text = result.data.bio
                          UserDefaults.standard.set(result.data.profileImage, forKey: GlobalDefaultsKey.KUserMainImage)
                        UserDefaults.standard.set(result.data.username, forKey: GlobalDefaultsKey.KUserMainName)
                          if let urlt = result.data.profileImage
                                        {
                                            if (urlt != ""){
                                                let urlf = URL(string: urlt)!

                                               self.UserProfilePicimageview.sd_setImage(with: urlf, placeholderImage:UIImage(named: "GirlVentLogo"), options: .delayPlaceholder, completed: { (image, error, cacheType, imageURL) in
                                                })
                                               self.imagePostZoomImageView.sd_setImage(with: urlf, placeholderImage:UIImage(named: "GirlVentLogo"), options: .delayPlaceholder, completed: { (image, error, cacheType, imageURL) in
                                                            })
                                            }
                        }
                        
                        
                      }
                  } else{
                      
               
                      print("Not Success")
                  }
              }
              
          }
    //MARK: - Change Photo
             func changePhoto()
             {
                 let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
                 
                 let cameraAction = UIAlertAction(title: GLocalizedString(key: "PhotoFromCamera"), style: .default, handler: {
                     (alert: UIAlertAction!) -> Void in
                     
                     if UIImagePickerController.isSourceTypeAvailable(.camera)
                     {
                         self.UIPicker.allowsEditing = false
                       self.UIPicker.sourceType = UIImagePickerController.SourceType.camera
                         self.UIPicker.cameraCaptureMode = .photo
                         self.UIPicker.modalPresentationStyle = .fullScreen
                         self.present(self.UIPicker, animated: true, completion: nil)
                     }
                 })
                 
                 let libraryAction = UIAlertAction(title: GLocalizedString(key: "ChooseFromGallery"), style: .default, handler: {
                     (alert: UIAlertAction!) -> Void in
                     
                     self.UIPicker.allowsEditing = false
                  self.UIPicker.sourceType = UIImagePickerController.SourceType.photoLibrary
                     self.UIPicker.modalPresentationStyle = .fullScreen
                     self.present(self.UIPicker, animated: true, completion: nil)
                 })
                 
                 let cancelAction = UIAlertAction(title: GLocalizedString(key: "Cancel"), style: .default, handler: {
                     (alert: UIAlertAction!) -> Void in
                     
                 })
                 
                 actionSheet.addAction(cameraAction)
                 actionSheet.addAction(libraryAction)
                 actionSheet.addAction(cancelAction)
                 
                 self.present(actionSheet, animated: true, completion: nil)
             }
      //MARK: -ImagePickerView Delegates
     
              func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
               
                
                   if let chosenImage = info[.originalImage] as? UIImage {
                 UserProfilePicimageview.image = chosenImage
                   // self.EditUserProfileAPIcell()
                  } else{
                      print("Something went wrong")
                  }
                
                self.SubmituserimageAPI()
                  dismiss(animated: true, completion: nil)
              }
              func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
              {
                  dismiss(animated: true, completion: nil)
              }
    
}
extension EditProfileVc : MyProfileMenuOptionCellDelegate{
    
    
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
extension EditProfileVc : UIPopoverPresentationControllerDelegate{
    
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
extension EditProfileVc : UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if monthListPicker == pickerView {
            
               return Montharray.count
        }else{
               return dayarray.count
        }
      
    }
    // MARK: UIPickerView Delegation

    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if monthListPicker == pickerView {
                  
                     return Montharray[row]
              }else{
                     return dayarray[row]
              }
        
       
    }

    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
   if monthListPicker == pickerView {
  
           SelectMonthTxt.text =  Montharray[row]
   }else{
          SelectDatTxt.text =  dayarray[row]
    
        }
 
    }
    
    
}
