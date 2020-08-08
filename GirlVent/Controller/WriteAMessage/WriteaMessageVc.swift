//
//  WriteaMessageVc.swift
//  Girlvent
//
//  Created by Glasier Inc. on 28/01/20.
//  Copyright © 2020 Glasier Inc. All rights reserved.
//

import UIKit
import UITextField_Shake
import CDAlertView
import AVFoundation
import SearchTextField
import UITextView_Placeholder


class WriteaMessageVc: UIViewController,UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    //MARK:- Outlets
    @IBOutlet weak var SendMessageView: UIView!
    @IBOutlet weak var SendMsgCancelBtn: UIButton!
    @IBOutlet weak var SendMsgTextview: UITextView!
    @IBOutlet weak var SendMsgAttachmentLable: UILabel!
    @IBOutlet weak var SendMsgBtn: UIButton!
    @IBOutlet weak var AddAttachmentBtn: UIButton!
    @IBOutlet weak var SelectUserTxt: SearchTextField!
    
    @IBOutlet var lblNewMessage: UILabel!
    
    
    //MARK:- Variables
    var mediaUrl:URL?
    var imageData:Data?
    
    var whoselectmedia = ""
    
    var UIPicker = UIImagePickerController()
    
   // let userListPicker = UIPickerView()
    var otheruserids = 0
    
    var userListarray = [AllUserListData]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        lblNewMessage.text = GLocalizedString(key: "message_title")
        SelectUserTxt.placeholder = GLocalizedString(key: "message_SelectUser")
        SendMsgTextview.placeholder = GLocalizedString(key: "message_WriteMessage")
        AddAttachmentBtn.setTitle(GLocalizedString(key: "message_AddAttachment"), for: .normal)
        SendMsgBtn.setTitle(GLocalizedString(key: "message_SendMessage"), for: .normal)
        
        
        UIPicker.delegate = self
        GetUserListAPICall()
       // SelectUserTxt.inputView = userListPicker
       // userListPicker.delegate = self
        // Set the array of strings you want to suggest
     
        // Do any additional setup after loading the view.
        SelectUserTxt.startVisible = true
        SelectUserTxt.theme.bgColor = .white
        SelectUserTxt.theme.font = UIFont.systemFont(ofSize: 20)
        
        SelectUserTxt.itemSelectionHandler = { filteredResults, itemPosition in
            // Just in case you need the item position
            let item = filteredResults[itemPosition]
            print("Item at position \(itemPosition): \(item.title)")
           
            
            
            
            for value in self.userListarray {
                                   print(value.username!)
                if value.username == item.title{
                    
                    self.otheruserids = value.useId
                }
            }
               print("Item at position \(self.otheruserids):")
            
            
            // Do whatever you want with the picked item
            self.SelectUserTxt.text = item.title
        }
        
    }
    
    @IBAction func AddAttachmentBtnClick(_ sender: Any) {
           

                self.UIPicker.allowsEditing = false
                self.UIPicker.mediaTypes = ["public.image","public.movie"]
                self.UIPicker.sourceType = UIImagePickerController.SourceType.photoLibrary
                self.UIPicker.modalPresentationStyle = .fullScreen
           
           
                self.present(self.UIPicker, animated: true, completion: nil)
           
       }
       @IBAction func SendMsgBtnClick(_ sender: Any) {
        
        if CheckFields(){
              SendMsgAPI()
        }
             
            
       }
       @IBAction func SendMsgCancelBtnClick(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
                                                                DispatchQueue.main.async {
                                                                    
                                                                    self.mediaUrl =  videoURL
                                                                    self.SendMsgAttachmentLable.text  = videoURL.lastPathComponent
                                                                    guard let compressedData = NSData(contentsOf: compressedURL) else {
                                                                            return
                                                                        }
                                                                      print("File size after compression: \(Double(compressedData.length / 1048576)) mb")
                                                                     }
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
    //MARK:- == FUNCTION FOR  get user List API ==
       func GetUserListAPICall(){
           //let TokenId = UserDefaults.value(forKey: "TokenId") as! String
           
           let param = [
               "language":"english"
               ] as [String : AnyObject]
           
           print(param)
           
           APIHelper.shared.GetUserListAPIcall(parameter: param) { (success, result) in
               
               if(result.data != nil){
                   if(success){
              
                      
                    self.userListarray = result.data
                       
          
                    var usernamearray = [String]()

                    for value in self.userListarray {
                        print(value.username!)
                        usernamearray.append(value.username)
                    }
                    self.SelectUserTxt.filterStrings(usernamearray)
                    
                    
                }
               } else{
                   print("Not Success")
               }
           }
           
       }
    
    //MARK:- == FUNCTION FOR Submit POST API ==
    
    func SendMsgAPI(){
                    
                    
                    let otheruserString = String(otheruserids)
                    
                    if whoselectmedia == ""{
                        imageData = nil
                        mediaUrl = nil
                        
                    }
                    APIHelper.shared.SendMsgAPIcall(Messge: SendMsgTextview.text!, toUserid: otheruserString, Language: "english", userPostvideo:mediaUrl ?? NSURL() as URL,userpostimage:imageData ?? NSData() as Data,whocome:whoselectmedia,completion:{ (success, response) in

                        if(success){
                              
//                             let alert = CDAlertView(title: "", message: response!.message, type: .success)
//                                                                                        let doneAction = CDAlertViewAction(title: "Ok", font: nil, textColor: UIColor.black, backgroundColor: UIColor.white) { (doneAction) -> Bool in
//                                                                                        
//                                                                                            return true
//                                                                                        }
//                                                                                        alert.add(action: doneAction)
//                                                                                        alert.circleFillColor = ALERT_COLOR
//                                                                                        alert.show()
                            
                            
                            let alert = CDAlertView(title: "", message: GLocalizedString(key: "MessageSent"), type: .success)
                            alert.hideAnimations = { (center, transform, alpha) in
                                transform = CGAffineTransform(scaleX: 3, y: 3)
                                alpha = 0
                            }
                            alert.hideAnimationDuration = 0.88
                            alert.show()
                            
                            self.SendMsgTextview.text = ""
                            self.SendMsgAttachmentLable.text = ""
                            self.navigationController?.popViewController(animated: true)
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                  alert.hide(isPopupAnimated: true)
                            }

                          
                            }else{
                            
                         
                            print("Not Success")
                        }
                    })
         }

    // MARK: - Functions
func CheckFields() -> Bool
{
               
     if (SelectUserTxt.text?.trimmingCharacters(in: .whitespaces).isEmpty)!
                  {
                      self.SelectUserTxt.shake(10,withDelta: 5.0,speed: 0.03,shakeDirection: ShakeDirection.horizontal)
                      
                      let alert = CDAlertView(title: GLocalizedString(key: "Hang On"), message: GLocalizedString(key: "SelectUser"), type: .warning)
                      let doneAction = CDAlertViewAction(title: GLocalizedString(key: "OK"), font: nil, textColor: UIColor.black, backgroundColor: UIColor.white) { (doneAction) -> Bool in
                          return true
                      }
                      alert.add(action: doneAction)
                      alert.circleFillColor = ALERT_COLOR
                      alert.show()
                      let test = false
                      return test
                  }
                  
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
}
//extension WriteaMessageVc : UIPickerViewDelegate, UIPickerViewDataSource{
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//
//        return 1
//    }
//
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//
//               return self.userListarray.count
//
//
//    }
//    // MARK: UIPickerView Delegation
//
//    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//
//        return self.userListarray[row].firstname + self.userListarray[row].lastname
//
//
//
//    }
//
//    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//
//        SelectUserTxt.text = self.userListarray[row].firstname + self.userListarray[row].lastname
//        self.otheruserids = self.userListarray[row].useId
//    }
//
//
//}
