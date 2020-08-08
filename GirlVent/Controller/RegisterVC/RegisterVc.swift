//
//  RegisterVc.swift
//  Girlvent
//
//  Created by Glasier Inc. on 23/12/19.
//  Copyright © 2019 Glasier Inc. All rights reserved.
//

import UIKit
import DLRadioButton
import PasswordTextField
import UITextField_Shake
import CDAlertView


class RegisterVc: UIViewController,UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    //MARK:- Outlets
    @IBOutlet weak var BackButton: UIButton!
    @IBOutlet weak var FirstNameTxt: UITextField!
    @IBOutlet weak var LastNameTxt: UITextField!
    @IBOutlet weak var EmailTxt: UITextField!
    @IBOutlet weak var UserNameTxt: UITextField!
    @IBOutlet weak var PasswordTxt: PasswordTextField!
    @IBOutlet weak var ConfirmPasswordTxt: PasswordTextField!
    @IBOutlet weak var UploadProfilePictureLable: UILabel!
    @IBOutlet weak var UploadProfilePictureButton: UIButton!
    @IBOutlet weak var BioTextview: UITextView!
    @IBOutlet weak var SelectMonthTxt: UITextField!
    @IBOutlet weak var SelectDayTxt: UITextField!
    @IBOutlet weak var MaleButton: DLRadioButton!
    @IBOutlet weak var FemaleButton: DLRadioButton!
    @IBOutlet weak var TermLAble: UILabel!
    @IBOutlet weak var TermImageView: UIImageView!
    @IBOutlet weak var TermButton: UIButton!
    var profileimageview: UIImageView!
     @IBOutlet weak var SaveButton: UIButton!
    
    @IBOutlet var lblWelcome: UILabel!
    @IBOutlet var lblCreateAccount: UILabel!
    @IBOutlet var lblSelectBirthDate: UILabel!
    
    
    //MARK:- Variables
    var iscompanyimage = "0"
          var UIPicker = UIImagePickerController()
    var genderselection = 0
      let text = GLocalizedString(key: "Register_TermsCondition")
    
    let monthListPicker = UIPickerView()
     let daysListPicker = UIPickerView()
    let Montharray = ["1","2","3","4","5","6","7","8","9","10","11","12"]
    let dayarray = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31"]
    
    
    
    
    //MARK:-ViewLifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        lblWelcome.text = GLocalizedString(key: "Register_Welcome")
        lblCreateAccount.text = GLocalizedString(key: "Register_CreateAccount")
        FirstNameTxt.placeholder = GLocalizedString(key: "Register_FirstName")
        LastNameTxt.placeholder = GLocalizedString(key: "Register_LastName")
        EmailTxt.placeholder = GLocalizedString(key: "Register_Email")
        UserNameTxt.placeholder = GLocalizedString(key: "Register_UserName")
        PasswordTxt.placeholder = GLocalizedString(key: "Register_Password")
        ConfirmPasswordTxt.placeholder = GLocalizedString(key: "Register_ConfirmPassword")
        UploadProfilePictureLable.text = GLocalizedString(key: "Register_UploadProfilePicture")
        lblSelectBirthDate.text = GLocalizedString(key: "Register_SelectBirthdate")
        SelectMonthTxt.placeholder = GLocalizedString(key: "Register_SelectMonth")
        SelectDayTxt.placeholder = GLocalizedString(key: "Register_SelectDay")
        MaleButton.setTitle(GLocalizedString(key: "Register_Male"), for: .normal)
        FemaleButton.setTitle(GLocalizedString(key: "Register_Female"), for: .normal)
        TermLAble.text = GLocalizedString(key: "Register_TermsCondition")
        SaveButton.setTitle(GLocalizedString(key: "Register_Save"), for: .normal)
        
        
        profileimageview = UIImageView()
        
        SelectMonthTxt.inputView = monthListPicker
         SelectDayTxt.inputView = daysListPicker
             daysListPicker.delegate = self
         monthListPicker.delegate = self
        
        UIPicker.delegate = self
        // Do any additional setup after loading the view.
        PasswordTxt.showButtonWhile = .Always
        ConfirmPasswordTxt.showButtonWhile = .Always
        
        TermButton.setImage(UIImage(named: "unselect"), for: .normal)
               TermButton.setImage(UIImage(named: "selecticon"), for: .selected)
               
               
               self.TermLAble.textColor =  UIColor.black
               TermLAble.text = text
               let underlineAttriString = NSMutableAttributedString(string: text)
               let range1 = (text as NSString).range(of: GLocalizedString(key: "Register_TermsText"))
              
                      // underlineAttriString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range1)
               underlineAttriString.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 15.0), range: range1)
        underlineAttriString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(red: 224.0/255.0, green: 60.0/255.0, blue: 113.0/255.0, alpha: 1.0), range: range1)
               
          
               
               TermLAble.attributedText = underlineAttriString
               TermLAble.isUserInteractionEnabled = true
               TermLAble.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(tapLabel(gesture:))))

        
        
        
    }
    @IBAction func tapLabel(gesture: UITapGestureRecognizer) {
       let termsRange = (text as NSString).range(of: GLocalizedString(key: "Register_TermsText"))
       // comment for now
   //    let privacyRange = (text as NSString).range(of: "Privacy Policy")

       if gesture.didTapAttributedTextInLabel(label: TermLAble, inRange: termsRange) {

        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let therapiescall = storyBoard.instantiateViewController(withIdentifier: "TermsAndConditionVcpuch") as! TermsAndConditionVc
        self.navigationController?.pushViewController(therapiescall, animated: true)
        
        if TermButton.isSelected {
                             // set deselected
                             TermButton.isSelected = false
                         } else {
                             // set selected
                             TermButton.isSelected = true
                         }
        
       }else {
      
           print("Tapped none")
       }
    }
    

    @IBAction func TermButtonClick(_ sender: Any) {
        
        if TermButton.isSelected {
                        // set deselected
                        TermButton.isSelected = false
                    } else {
                        // set selected
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let therapiescall = storyBoard.instantiateViewController(withIdentifier: "TermsAndConditionVcpuch") as! TermsAndConditionVc
            self.navigationController?.pushViewController(therapiescall, animated: true)
                        TermButton.isSelected = true
                    }
                

        
        
    }
    @IBAction func GenderSelectionClick(_ sender: DLRadioButton) {
    
    
            if sender.tag == 1 {
                   print(sender.tag)
              genderselection = 1
                   
               }else if sender.tag == 2 {
                   print(sender.tag)
                   genderselection = 2
               }
        
        
        
    }
    @IBAction func SaveButtonClick(_ sender: Any) {
        
        if TermButton.isSelected {
            if CheckFields()
                            {
                              RegisterApicell()
                            }
              
        }else{
            
            let alert = CDAlertView(title: GLocalizedString(key: "Hang On"), message: GLocalizedString(key: "AcceptTerms&conditions"), type: .warning)
                                 let doneAction = CDAlertViewAction(title: GLocalizedString(key: "OK"), font: nil, textColor: UIColor.black, backgroundColor: UIColor.white) { (doneAction) -> Bool in
                                     return true
                                 }
                                 alert.add(action: doneAction)
                                 alert.circleFillColor = ALERT_COLOR
                                 alert.show()
        }
  
        
      }
    @IBAction func UploadProfilePictureButtonClick(_ sender: Any) {
        
          changePhoto()
    }
    @IBAction func BackButtonClick(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
  //MARK:- == Update User profile ==
            func RegisterApicell(){
                
                 // let user:LoginResult = HELPER.getSession()
               
//                let param = ["firstname":FirstNameTxt.text!,"lastname":LastNameTxt.text!,"email":EmailTxt.text!,"password":PasswordTxt.text!,"username":UserNameTxt.text!,"birth_date":SelectDayTxt.text!,"birth_month":SelectMonthTxt.text!,"gender":genderselection,"bio":BioTextview.text!] as [String : AnyObject]
////
//               print(param)
//
                var companydata : Data!
                       
                       if iscompanyimage == "0"{
                           
                           companydata = Data()
                           
                       }else{
                           companydata = profileimageview.image!.jpegData(compressionQuality: 0.3)!
                           
                       }
                       
                
                APIHelper.shared.RegisterAPIcall(Firstname: FirstNameTxt.text!, lastname: LastNameTxt.text!, email: EmailTxt.text!, username: UserNameTxt.text!, password: PasswordTxt.text!, bio: BioTextview.text!, birthmonth: SelectMonthTxt.text!, birthday: SelectDayTxt.text!, gender: String(genderselection), userProfileimage: companydata, completion:{ (success, response) in
                    
                    if(success){
                       
                        let alert = CDAlertView(title: GLocalizedString(key: "Congratulations"), message: GLocalizedString(key: "RegistrationSuccessful"), type: .success)
                                                          let doneAction = CDAlertViewAction(title: GLocalizedString(key: "OK"), font: nil, textColor: UIColor.black, backgroundColor: UIColor.white) { (doneAction) -> Bool in


                                                            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                                                               let therapiescall = storyBoard.instantiateViewController(withIdentifier: "HomeViewVCpuch") as! HomeViewVC
                                                                               self.navigationController?.pushViewController(therapiescall, animated: true)
                                                            HELPER.saveUserSession(u: response!.data)
                                                            UserDefaults.standard.set(response!.data.profilePicUrl, forKey: GlobalDefaultsKey.KUserMainImage)
                                                            UserDefaults.standard.set(response!.data.username, forKey: GlobalDefaultsKey.KUserMainName)
                                                              return true
                                                          }
                                                          alert.add(action: doneAction)
                                                          alert.circleFillColor = ALERT_COLOR
                                                          alert.show()
                   
                   
                        
                    }else{
                        
                       let alert = CDAlertView(title: GLocalizedString(key: "Error"), message: response!.message, type: .error)
                       let doneAction = CDAlertViewAction(title: GLocalizedString(key: "OK"), font: nil, textColor: UIColor.black, backgroundColor: UIColor.white) { (doneAction) -> Bool in
                                   return true
                               }
                       alert.add(action: doneAction)
                       alert.circleFillColor = ALERT_COLOR
                       
                       alert.show()
                       
                    }
                    
                })
                
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
    //      func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    //      {
    //          let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
    //          self.imgProfile.layer.cornerRadius = imgProfile.frame.size.width/2
    //          self.imgProfile.clipsToBounds = true
    //          self.imgProfile.image = chosenImage
    //
    //          dismiss(animated: true, completion: nil)
    //      }
          func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
           
            
               if let chosenImage = info[.originalImage] as? UIImage {
          
            if let url = info[UIImagePickerController.InfoKey.imageURL] as? URL {
                 UploadProfilePictureLable.text  = url.lastPathComponent
          
            }else{
                
                if (picker.sourceType == UIImagePickerController.SourceType.camera) {

                    let imgName = UUID().uuidString
                    let documentDirectory = NSTemporaryDirectory()
                    let localPath = documentDirectory.appending(imgName)

                    let data = chosenImage.jpegData(compressionQuality: 0.3)! as NSData
                    data.write(toFile: localPath, atomically: true)
                    let photoURL = URL.init(fileURLWithPath: localPath)
                    
                    UploadProfilePictureLable.text  = photoURL.lastPathComponent

                }
            }
                
                self.iscompanyimage = "1"
            
          
                
                //  Userimageview.contentMode = .scaleAspectFill
               

             profileimageview.image = chosenImage
               // self.EditUserProfileAPIcell()
              } else{
                  print("Something went wrong")
              }
              dismiss(animated: true, completion: nil)
          }
          func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
          {
              dismiss(animated: true, completion: nil)
          }
          // MARK: - Functions
               func CheckFields() -> Bool
               {
                   if (FirstNameTxt.text?.trimmingCharacters(in: .whitespaces).isEmpty)!
                {
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
        if (LastNameTxt.text?.trimmingCharacters(in: .whitespaces).isEmpty)!
       {
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
                if (EmailTxt.text?.trimmingCharacters(in: .whitespaces).isEmpty)!
                {
                       self.EmailTxt.shake(10,withDelta: 5.0,speed: 0.03,shakeDirection: ShakeDirection.horizontal)
                       
                       let alert = CDAlertView(title: GLocalizedString(key: "Hang On"), message: GLocalizedString(key: "ValidEmail"), type: .warning)
                       let doneAction = CDAlertViewAction(title: GLocalizedString(key: "OK"), font: nil, textColor: UIColor.black, backgroundColor: UIColor.white) { (doneAction) -> Bool in
                           return true
                       }
                       alert.add(action: doneAction)
                       alert.circleFillColor = ALERT_COLOR
                       alert.show()
                       let test = false
                       return test
                   }
                   else if !(HELPER.sharedInstance.isValidEmail(testStr:EmailTxt.text!))
                   {
                       self.EmailTxt.shake(10,withDelta: 5.0,speed: 0.03,shakeDirection: ShakeDirection.horizontal)
                       
                       let alert = CDAlertView(title: GLocalizedString(key: "Hang On"), message: GLocalizedString(key: "ValidEmail"), type: .warning)
                       let doneAction = CDAlertViewAction(title: GLocalizedString(key: "OK"), font: nil, textColor: UIColor.black, backgroundColor: UIColor.white) { (doneAction) -> Bool in
                           return true
                       }
                       alert.add(action: doneAction)
                       alert.circleFillColor = ALERT_COLOR
                       alert.show()
                       let test = false
                       return test
                   }
                if (UserNameTxt.text?.trimmingCharacters(in: .whitespaces).isEmpty)!
                       {
                                                                      self.UserNameTxt.shake(10,withDelta: 5.0,speed: 0.03,shakeDirection: ShakeDirection.horizontal)
                                                                             
                                                                      let alert = CDAlertView(title: GLocalizedString(key: "Hang On"), message: GLocalizedString(key: "EnterUsername"), type: .warning)
                                                                      let doneAction = CDAlertViewAction(title: GLocalizedString(key: "OK"), font: nil, textColor: UIColor.black, backgroundColor: UIColor.white) { (doneAction) -> Bool in
                                                                          return true
                                                                      }
                                                                      alert.add(action: doneAction)
                                                                      alert.circleFillColor = ALERT_COLOR
                                                                      alert.show()
                                                                      let test = false
                                                                      return test
                       }
                
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
                    }else if PasswordTxt.text!.count <= 5 {
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
                    }else if ConfirmPasswordTxt.text!.count <= 5 {
                        self.ConfirmPasswordTxt.shake(10,withDelta: 5.0,speed: 0.03,shakeDirection: ShakeDirection.horizontal)
                        
                        let alert = CDAlertView(title: GLocalizedString(key: "Hang On"), message: GLocalizedString(key: "PasswordValidationMessage"), type: .warning)
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
                                                       let alert = CDAlertView(title: GLocalizedString(key: "Hang On"), message: GLocalizedString(key: "PasswordNotMatch"), type: .warning)
                                                       let doneAction = CDAlertViewAction(title: GLocalizedString(key: "OK"), font: nil, textColor: UIColor.black, backgroundColor: UIColor.white) { (doneAction) -> Bool in
                                                           return true
                                                       }
                                                       alert.add(action: doneAction)
                                                       alert.circleFillColor = ALERT_COLOR
                                                       alert.show()
                                                       let test = false
                                                       return test
                }
//       if (SelectMonthTxt.text?.trimmingCharacters(in: .whitespaces).isEmpty)!
//                    {
//                        self.SelectMonthTxt.shake(10,withDelta: 5.0,speed: 0.03,shakeDirection: ShakeDirection.horizontal)
//
//                        let alert = CDAlertView(title: "Hang On!", message: "Please select Birth month", type: .warning)
//                        let doneAction = CDAlertViewAction(title: "Ok", font: nil, textColor: UIColor.black, backgroundColor: UIColor.white) { (doneAction) -> Bool in
//                            return true
//                        }
//                        alert.add(action: doneAction)
//                        alert.circleFillColor = ALERT_COLOR
//                        alert.show()
//                        let test = false
//                        return test
//                    }
//   if (SelectDayTxt.text?.trimmingCharacters(in: .whitespaces).isEmpty)!
//                {
//                    self.SelectDayTxt.shake(10,withDelta: 5.0,speed: 0.03,shakeDirection: ShakeDirection.horizontal)
//
//                    let alert = CDAlertView(title: "Hang On!", message: "Please select Birth day", type: .warning)
//                    let doneAction = CDAlertViewAction(title: "Ok", font: nil, textColor: UIColor.black, backgroundColor: UIColor.white) { (doneAction) -> Bool in
//                        return true
//                    }
//                    alert.add(action: doneAction)
//                    alert.circleFillColor = ALERT_COLOR
//                    alert.show()
//                    let test = false
//                    return test
//                }
                
                let test = true
                   return test
               }
}
extension UITapGestureRecognizer {

    func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
        // Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: CGSize.zero)
        let textStorage = NSTextStorage(attributedString: label.attributedText!)

        // Configure layoutManager and textStorage
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)

        // Configure textContainer
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = .byWordWrapping
        textContainer.maximumNumberOfLines = label.numberOfLines
        let labelSize = label.bounds.size
        textContainer.size = labelSize

        // Find the tapped character location and compare it to the specified range
        let locationOfTouchInLabel = self.location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        //let textContainerOffset = CGPointMake((labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x,
                                              //(labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y);
        let textContainerOffset = CGPoint(x: (labelSize.width - textBoundingBox.size.width) * 0.3 - textBoundingBox.origin.x, y: (labelSize.height - textBoundingBox.size.height) * 0.3 - textBoundingBox.origin.y)

        //let locationOfTouchInTextContainer = CGPointMake(locationOfTouchInLabel.x - textContainerOffset.x,
                                                        // locationOfTouchInLabel.y - textContainerOffset.y);
        let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x, y: locationOfTouchInLabel.y - textContainerOffset.y)
        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        return NSLocationInRange(indexOfCharacter, targetRange)
    }

}
extension RegisterVc : UIPickerViewDelegate, UIPickerViewDataSource{
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
          SelectDayTxt.text =  dayarray[row]
    
        }
 
    }
    
    
}
