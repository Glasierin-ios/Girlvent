//
//  CreateVideoPostVC.swift
//  Girlvent
//
//  Created by Glasier Inc. on 02/01/20.
//  Copyright © 2020 Glasier Inc. All rights reserved.
//

import UIKit
import UITextField_Shake
import CDAlertView
import MobileCoreServices

import AVFoundation

class CreateVideoPostVC: UIViewController,UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    //MARK:- Outlets
    @IBOutlet weak var VideoPostCancelButton: UIButton!
    @IBOutlet weak var VideoCategoryListButton: UIButton!
    @IBOutlet weak var VideoTextTextView: UITextView!
    @IBOutlet weak var VideoPathLable: UILabel!

    @IBOutlet weak var SelectVideoButton: UIButton!
    @IBOutlet weak var VideoPostButton: UIButton!
   
    @IBOutlet weak var SelectCategoriesTxt: UITextField!
    
    @IBOutlet var lblCreatePost: UILabel!
    
    //MARK:- Variables
    var videourl:URL!
    var profileimageview: UIImageView!
    var iscompanyimage = "0"
    var UIPicker = UIImagePickerController()
    
    let categoriesListPicker = UIPickerView()
    var selectedcategoriid = 0
    var categoriesListArray = [GetCategoriesListData]()
      
    var textforEditString = ""
    var linkforEditStirng = ""
    var wheretoCome = 0
    var postidString = 0
    
    
    //MARK:- ViewLifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()

        lblCreatePost.text = GLocalizedString(key: "CreatePost")
        VideoCategoryListButton.setTitle(GLocalizedString(key: "NewsFeed"), for: .normal)
        SelectCategoriesTxt.text = GLocalizedString(key: "NewsFeed")
        VideoTextTextView.placeholder = GLocalizedString(key: "PostTextView")
        VideoPathLable.text = GLocalizedString(key: "cv_SelectVideo")
        VideoPostButton.setTitle(GLocalizedString(key: "Post"), for: .normal)
        
        
        
         categoriesListPicker.setValue(ALERT_COLOR, forKeyPath: "textColor")
        profileimageview = UIImageView()
        UIPicker.delegate = self
        GetCategoriesListAPI()
        SelectCategoriesTxt.inputView = categoriesListPicker
                   categoriesListPicker.delegate = self
        
        
        if wheretoCome == 0{
                
                
            }else{
                
                videourl =  URL(string: linkforEditStirng)
                VideoTextTextView.text = textforEditString
                VideoPathLable.text = linkforEditStirng
                 self.VideoPathLable.isHidden = false
            }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func VideoPostCancelButtonClick(_ sender: Any) {
        let savedata =  UserDefaults.init(suiteName: "group.com.Glasierinc.Girlventdemo")
               savedata?.removeObject(forKey: "Video")
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func VideoCategoryListButtonClick(_ sender: Any) {
    }
    @IBAction func SelectVideoButtonClick(_ sender: Any) {
         changePhoto()
    }
    @IBAction func VideoPostButtonClick(_ sender: Any) {
        
        if wheretoCome == 0{
            
            
            if VideoPathLable.text == GLocalizedString(key: "cv_SelectVideo"){
                let alert = CDAlertView(title: GLocalizedString(key: "GirlVent"), message: GLocalizedString(key: "SelectVideo"), type: .error)
                                                                                                                       let doneAction = CDAlertViewAction(title: GLocalizedString(key: "OK"), font: nil, textColor: UIColor.black, backgroundColor: UIColor.white) { (doneAction) -> Bool in

                                                                                                                           return true
                                                                                                                       }
                                                                                                                       alert.add(action: doneAction)
                                                                                                                       alert.circleFillColor = ALERT_COLOR
                                                                                                                       alert.show()
            }else{
                 SubmitPostvideoAPI()
            }
           

        }else{
            
            UpdatePostvideoAPI()
        }
    }
    
    
    
           //MARK:- == FUNCTION FOR GET Categories POST API ==
                func GetCategoriesListAPI(){
                    //let TokenId = UserDefaults.value(forKey: "TokenId") as! String
                    
                    
                   let param = [:] as [String : AnyObject]
                    
                    print(param)
                    
                    APIHelper.shared.GetCategoriesListAPIcall(parameter: param) { (success, result) in
                        
                        if(result.data != nil){
                            if(success){
                             
                               self.categoriesListArray = result.data
                                if self.wheretoCome == 1{
                                    for obj in self.categoriesListArray{
                                        if obj.id == self.selectedcategoriid{
                                            self.VideoCategoryListButton.setTitle(obj.name, for: .normal)
                                            self.SelectCategoriesTxt.text = obj.name

                                        }
                                    }
                                }
                            }
                        } else{
                            
                         
                            print("Not Success")
                        }
                    }
           }
    //MARK:- == FUNCTION FOR Submit POST API ==
             func SubmitPostvideoAPI(){

                
                if videourl == nil{
                    let alert = CDAlertView(title: GLocalizedString(key: "Waiting"), message: GLocalizedString(key: "VideoCompress"), type: .error)
                                                                                                        let doneAction = CDAlertViewAction(title: GLocalizedString(key: "OK"), font: nil, textColor: UIColor.black, backgroundColor: UIColor.white) { (doneAction) -> Bool in

                                                                                                            return true
                                                                                                        }
                                                                                                        alert.add(action: doneAction)
                                                                                                        alert.circleFillColor = ALERT_COLOR
                                                                                                        alert.show()
                    return
                }
                 
                 APIHelper.shared.UserPostvideoAPIcall(Type: "video", Content: VideoTextTextView.text!, Categoriyid: selectedcategoriid, Language: "english", userPostVideo: videourl, completion:{ (success, response) in
                     
                     
                         if(success){
                             self.navigationController?.popViewController(animated: true)
//                          let alert = CDAlertView(title: "Congratulations", message: response!.message, type: .success)
//                                                                                     let doneAction = CDAlertViewAction(title: "Ok", font: nil, textColor: UIColor.black, backgroundColor: UIColor.white) { (doneAction) -> Bool in
//
//                                                                                     
//                                                                                         return true
//                                                                                     }
//                                                                                     alert.add(action: doneAction)
//                                                                                     alert.circleFillColor = ALERT_COLOR
//                                                                                     alert.show()
                       
                         }else{
                         
                      
                         print("Not Success")
                     }
                 })
      }
    //MARK:- == FUNCTION FOR Submit POST API ==
                 func UpdatePostvideoAPI(){

                    if videourl == nil{
                        let alert = CDAlertView(title: GLocalizedString(key: "Waiting"), message: GLocalizedString(key: "VideoCompress"), type: .error)
                                                                                                            let doneAction = CDAlertViewAction(title: GLocalizedString(key: "OK"), font: nil, textColor: UIColor.black, backgroundColor: UIColor.white) { (doneAction) -> Bool in

                                                                                                                return true
                                                                                                            }
                                                                                                            alert.add(action: doneAction)
                                                                                                            alert.circleFillColor = ALERT_COLOR
                                                                                                            alert.show()
                        return
                    }
                     var pasevalue = ""

                    if iscompanyimage == "1"{
                         pasevalue = String(describing: videourl!)
                        
                    }else{
                        if wheretoCome == 1{
                            pasevalue = "nil"
                        }else{
                            pasevalue = String(describing: videourl!)
                        }
                        
                    }
                     APIHelper.shared.UpdateUserPostvideoAPIcall(Type: "video", Content: VideoTextTextView.text!, Categoriyid: selectedcategoriid, Language: "english", userPostVideo: pasevalue, PostId:String(postidString),completion:{ (success, response) in
                         
                         
                             if(success){
                                 self.navigationController?.popViewController(animated: true)
    //                          let alert = CDAlertView(title: "Congratulations", message: response!.message, type: .success)
    //                                                                                     let doneAction = CDAlertViewAction(title: "Ok", font: nil, textColor: UIColor.black, backgroundColor: UIColor.white) { (doneAction) -> Bool in
    //
    //
    //                                                                                         return true
    //                                                                                     }
    //                                                                                     alert.add(action: doneAction)
    //                                                                                     alert.circleFillColor = ALERT_COLOR
    //                                                                                     alert.show()
                           
                             }else{
                             
                          
                             print("Not Success")
                         }
                     })
          }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    //MARK: - Change Photo
             func changePhoto()
             {
                 let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
                 
                 let cameraAction = UIAlertAction(title: GLocalizedString(key: "VideoFromCamera"), style: .default, handler: {
                     (alert: UIAlertAction!) -> Void in
                     
                     if UIImagePickerController.isSourceTypeAvailable(.camera)
                     {
                         self.UIPicker.allowsEditing = false
                       self.UIPicker.sourceType = UIImagePickerController.SourceType.camera
                        self.UIPicker.mediaTypes = [
                                             "public.movie"]

                         self.UIPicker.cameraCaptureMode = .video
                         self.UIPicker.modalPresentationStyle = .fullScreen
                         self.present(self.UIPicker, animated: true, completion: nil)
                     }
                 })
                 
                 let libraryAction = UIAlertAction(title: GLocalizedString(key: "ChooseFromGallery"), style: .default, handler: {
                     (alert: UIAlertAction!) -> Void in
                     
                     self.UIPicker.allowsEditing = false
                   
                  self.UIPicker.sourceType = UIImagePickerController.SourceType.photoLibrary
                    self.UIPicker.mediaTypes = [
                        "public.movie"]

                     self.UIPicker.modalPresentationStyle = .fullScreen
                     self.present(self.UIPicker, animated: true, completion: nil)
                 })
                 
                 let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: {
                     (alert: UIAlertAction!) -> Void in
                     
                 })
                 
                 actionSheet.addAction(cameraAction)
                 actionSheet.addAction(libraryAction)
                 actionSheet.addAction(cancelAction)
                 
                 self.present(actionSheet, animated: true, completion: nil)
             }
      //MARK: -ImagePickerView Delegates
     
              func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
                                
                if let mediaType = info[UIImagePickerController.InfoKey.mediaType] as? String {

                             if mediaType == "public.movie" {
                                 print("Video Selected")
                                
                                let videoURL = info[UIImagePickerController.InfoKey.mediaURL] as! URL
//                                let videoURsL = info[UIImagePickerController.InfoKey.mediaURL] as! String
//                                if UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(videoURsL) {
//                                    UISaveVideoAtPathToSavedPhotosAlbum(videoURsL, self, nil, nil)
//                                           } else {
//                                               print("Cannot find file to save")
//                                           }
                                    VideoPathLable.text  = videoURL.lastPathComponent
                                
                         
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
                                                    
                                                    self.videourl = compressedURL
                                                       self.iscompanyimage = "1"
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
                    
//                    if (picker.sourceType == UIImagePickerController.SourceType.camera) {
//
//                        let imgName = UUID().uuidString
//                        let documentDirectory = NSTemporaryDirectory()
//                        let localPath = documentDirectory.appending(imgName)
//
//                        let data = chosenImage.jpegData(compressionQuality: 0.3)! as NSData
//                        data.write(toFile: localPath, atomically: true)
//                        let photoURL = URL.init(fileURLWithPath: localPath)
//
//                        VideoPathLable.text  = photoURL.lastPathComponent
//
//
//                }
                    
                 
                      self.SelectVideoButton.isHidden = true
                      self.VideoPathLable.isHidden = false
              
                  dismiss(animated: true, completion: nil)
              }
              func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
              {
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
}
extension CreateVideoPostVC : UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
       
            
               return categoriesListArray.count + 1
       
      
    }
    // MARK: UIPickerView Delegation

    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
       
                  
        if row == 0{
            
             return "News feed"
        }else{
             return categoriesListArray[row - 1].name
        }
        
       
             
        
       
    }

    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
  
                if row == 0{
                      
                      SelectCategoriesTxt.text =  "News feed"
                    selectedcategoriid = 0
                  }else{
                       SelectCategoriesTxt.text =  categoriesListArray[row - 1].name
                    selectedcategoriid = categoriesListArray[row - 1].id
                  }
           

 
    }
    
    
}
