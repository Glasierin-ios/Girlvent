//
//  ShareVC.swift
//  GirlventShareExtension
//
//  Created by geet on 21/07/20.
//  Copyright © 2020 Glasier Inc. All rights reserved.
//

import UIKit
//import CDAlertView
import Alamofire
import SwiftyJSON
import IQKeyboardManagerSwift
import SwiftSpinner
import CDAlertView
import MobileCoreServices
import AVFoundation

class ShareVC: UIViewController {

    //MARK:- Outlets
       @IBOutlet weak var ImageTextTextView: UITextView!
       @IBOutlet weak var SelectimagePathLable: UILabel!
       @IBOutlet weak var SelectCategoriesTxt: UITextField!
       @IBOutlet var lblCreatePost: UILabel!
  
    
    //MARK:- Variables
    var  categoriesListArray = [GetCategoriesListData]()
    let categoriesListPicker = UIPickerView()
    var selectedcategoriid = 0
    var imageType = ""
    let VideoType = kUTTypeMovie as String
    let TextType = kUTTypePlainText as String
    var ImageData: Data!
    var videourl:URL!
    let POST_URL = "https://girlvent.glasier.in.glasier.in/api/mobile/post/create"
    let ALERT_COLOR = UIColor(red: 224/255, green: 60/255, blue: 113/255, alpha: 1.0)
    var postType = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        
          IQKeyboardManager.shared.enable = true
        
            self.categoriesListPicker.setValue(ALERT_COLOR, forKeyPath: "textColor")
            self.SelectCategoriesTxt.text =  "News feed"
                    
                    
            self.GetShareData()
          GetCategoriesListAPI()

            self.SelectCategoriesTxt.inputView = self.categoriesListPicker
            self.categoriesListPicker.delegate = self
        
        
        
    }

    //MARK:- CustomMethods
    func GetShareData()
    {
        if let item = self.extensionContext?.inputItems[0] as? NSExtensionItem{
                                print("Item \(item)")
                                for ele in item.attachments!{
                                    print("item.attachments!======&gt;&gt;&gt; \(ele )")
                                    let itemProvider = ele
                                    print(itemProvider)

                                    if itemProvider.hasItemConformingToTypeIdentifier("public.jpeg"){
                                        imageType = "public.jpeg"
                                    }
                                    if itemProvider.hasItemConformingToTypeIdentifier("public.png"){
                                         imageType = "public.png"
                                    }
                                    print("imageType\(imageType)")

                                    if itemProvider.hasItemConformingToTypeIdentifier(imageType){
                                        
                                     
                                        
                                        
                                        print("True")
                                        itemProvider.loadItem(forTypeIdentifier: imageType, options: nil, completionHandler: { (data, error) in
                                            
                                            let myImage: UIImage?
                                            switch data {
                                            case let image as UIImage:
                                                myImage = image
                                            case let data as Data:
                                                myImage = UIImage(data: data)
                                                self.ImageData = data
                                            case let url as URL:
                                                 self.SelectimagePathLable.text = url.absoluteString
                                                myImage = UIImage(contentsOfFile: url.path)
                                            default:
                                                //There may be other cases...
                                                print("Unexpected data:", type(of: data))
                                                myImage = nil
                                            }
                                            
//                                            DispatchQueue.main.async {
//                                            self.postType = "Image"
//
//                                            var imgData: Data!
//                                            if let url = item as? URL{
//                                                self.SelectimagePathLable.text = url.absoluteString
//                                                imgData = try! Data(contentsOf: url)
//                                            }
//
//                                            if let img = item as? UIImage{
//                                                imgData = img.pngData()
//                                            }
//                                            print("Item ===\(String(describing: item))")
//                                            print("Image Data=====. \(String(describing: imgData)))")
//
//                                                self.ImageData = imgData
//
//
//                                            }

                                        })
                                    }
                                    else if itemProvider.hasItemConformingToTypeIdentifier(VideoType)
                                    {
                                       itemProvider.loadItem(forTypeIdentifier: VideoType, options: nil, completionHandler: { (item, error) in

                                            
                                        DispatchQueue.main.async {
                                            
                                            self.postType = "Video"
                                            
                                            let data : NSData!
                                            if let url = item as? URL{
                                                self.SelectimagePathLable.text = url.absoluteString
                                                self.videourl = url
                                                data = NSData(contentsOf: url)
                                                print("File size before compression: \(Double(data.length / 1048576)) mb")
                                            }

                                            
                                                     
                                                     let compressedURL = NSURL.fileURL(withPath: NSTemporaryDirectory() + NSUUID().uuidString + ".mp4")
                                            self.compressVideo(inputURL: self.videourl , outputURL: compressedURL) { (exportSession) in
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
                                        })
                                    }
                                    
                                    else if itemProvider.hasItemConformingToTypeIdentifier(TextType)
                                    {
                                       itemProvider.loadItem(forTypeIdentifier: TextType, options: nil, completionHandler: { (item, error) in

                                        DispatchQueue.main.async {
                                            
                                            self.postType = "Text"
                                            
                                            if let data = item as? String
                                            {
                                                print(data)
                                                self.ImageTextTextView.text = data
                                                self.SelectimagePathLable.isHidden = true
                                                
                                            }
                                            
                                            
                                        }
                                            
                                        })
                                    }
                                    
                                    
            }
        }
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
    
    func showAlert(message: String)
    {
        let alert = UIAlertController(title: "" , message: message, preferredStyle: .alert)
        
        let okaction = UIAlertAction(title:"OK", style: .cancel, handler: nil)
        alert.addAction(okaction)
        self.present(alert, animated: true, completion: nil)
    }
    func openApp()
    {

        //let url = URL(string: "Girlvent://dataUrl=\(self.sharedKey)")
        let url = URL(string: "Girlvent://")
        var responder = self as UIResponder?
        let selectorOpenURL = sel_registerName("openURL:")

        while (responder != nil) {
            if (responder?.responds(to: selectorOpenURL))! {
                if let application = responder as? UIApplication
                {
                    let _ = application.perform(selectorOpenURL, with: url)
                }
//                                            let _ = responder?.perform(selectorOpenURL, with: url)
            }
            responder = responder!.next
        }



//                                    self.extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
    }
    //MARK:- ButtonActions
    @IBAction func MsgPostCancelButtonClick(_ sender: Any) {
           self.extensionContext!.completeRequest(returningItems: [], completionHandler: nil)

       }

    @IBAction func MsgPostButtonClick(_ sender: Any)
    {

        if self.postType == "Image"
                 {
                     SubmitPostimageAPI()
                 }
                 else if self.postType == "Video"
                 {
                     if videourl == nil{
                         let alert = CDAlertView(title: "Waiting", message: "VideoCompress", type: .error)
                                                                                                             let doneAction = CDAlertViewAction(title: "OK", font: nil, textColor: UIColor.black, backgroundColor: UIColor.white) { (doneAction) -> Bool in

                                                                                                                 return true
                                                                                                             }
                                                                                                             alert.add(action: doneAction)
                                                                                                             alert.circleFillColor = ALERT_COLOR
                                                                                                             alert.show()
                         return
                     }
                     
                     UserPostvideoAPIcall(Type: "video", Content: ImageTextTextView.text!, Categoriyid: selectedcategoriid, Language: "english", userPostVideo: videourl, completion:{ (success, response) in
                                          
                                          
                                              if(success)
                                              {
                                                         self.openApp()
                                            
                                              }else{
                                              
                                           
                                              print("Not Success")
                                          }
                                      })
                 }
                 else if self.postType == "Text"
                 {
                    if ImageTextTextView.text == ""{
                                  let alert = CDAlertView(title: "GirlVent", message: "Please write something!", type: .error)
                                                       let doneAction = CDAlertViewAction(title: "Ok", font: nil, textColor: UIColor.black, backgroundColor: UIColor.white) { (doneAction) -> Bool in

                                                           return true
                                                       }
                                                       alert.add(action: doneAction)
                                                       alert.circleFillColor = ALERT_COLOR
                                                       alert.show()

                        
                    }else{
                               let param = [
                                                "type":"text",
                                                "content":ImageTextTextView.text!,
                                                "language":"english",
                                                "forum_id" : selectedcategoriid
                                                ] as [String : AnyObject]
                                                
                                                SubmitHomeTextPostAPIcall(parameter: param) { (success, result) in
                                                                 
                                                                 
                                                                     if(success){
                                                                       
                                                                        self.openApp()
                                                                   
                                                                     }else{
                                                                  
                                                                     print("Not Success")
                                                                 }
                                                             }
                              }
                    
                 
                     
                     
                 }
    }
   //MARK:- == FUNCTION FOR Submit POST API ==
    func SubmitPostimageAPI(){
                //let TokenId = UserDefaults.value(forKey: "TokenId") as! String


                let param = [
                    "type":"image",
                    "content":ImageTextTextView.text!,
                    "language":"english",
                    "forum_id" : selectedcategoriid
                    ] as [String : AnyObject]

                print(param)
                
        UserPostImageAPIcall(Type: "image", Content: ImageTextTextView.text!, Categoriyid: selectedcategoriid, Language: "english", userPostimage: ImageData) { (sucess, response) in
            
                    if sucess
                    {
                        self.openApp()
                    }
                    else{
                        
                     
                        print("Not Success")
                    }
            }

//                APIHelper.shared.SubmitHomeTextPostAPIcall(parameter: param) { (success, result) in
//
//
//                        if(success){
//
//                            self.openApp()
//                        }else{
//
//
//                        print("Not Success")
//                    }
//                }
       }
    
    func UserPostImageAPIcall(Type :String ,Content :String,Categoriyid :Int,Language :String,userPostimage: Data,completion:@escaping (_ success : Bool, _ result : UserPostImageRootClass?) -> Void){
        
        let userdata = UserDefaults(suiteName: "group.com.Glasierinc.Girlventdemo")
        let data = userdata?.value(forKey: "GIRLVENT") as! String
//        let decodedObj = NSKeyedUnarchiver.unarchiveObject(with: data!) as? LoginData
//        let user:LoginData = decodedObj!
                  
                                                   let usertokan = data
                                                    let header : HTTPHeaders = [
                                                       "Accept-Language"    :  "En",
                                                       "token" : usertokan
                                                       ]
           
             SwiftSpinner.show( "Loading")
        
     let categorystring = String(Categoriyid)
           AF.upload(multipartFormData: { (multipartFormData) in
               multipartFormData.append(Type.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!, withName: "type")
               multipartFormData.append(Content.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!, withName: "content")
               multipartFormData.append(categorystring.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!, withName: "forum_id")
               multipartFormData.append(Language.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!, withName: "language")
               
               print(multipartFormData)
               
                   multipartFormData.append(userPostimage, withName: "media_file", fileName: "userPost.jpg" , mimeType: "image/jpg")
    
               
           },to:POST_URL,method:.post,headers:header) .responseJSON{ response in
         
                    SwiftSpinner.hide()
                switch response.result {
                case .success(let value):
                       print("response  \(response)")
                       
                        //SVProgressHUD.dismiss()
                       if (response.value != nil) {
                               //let statusCode = response.response?.statusCode
                           let json = JSON(value)
                           let objRootClass = UserPostImageRootClass(fromJson: json)
                           if (objRootClass.error == 200){
                           
                               //HELPER.sharedInstance.globalAlert(message: objRootClass.message)
                               completion(true,objRootClass)
                           }else{
                            print(objRootClass.message as Any)
                            self.showAlert(message: objRootClass.message)
                               completion(false,objRootClass)
                           }
                           
                       }else{
                           completion(false,nil)
                           print(response.description)

                       }
                       
                   
               case .failure(let encodingError):
                    //SVProgressHUD.dismiss()
                   completion(false,nil)
                   print(encodingError)
                    self.showAlert(message: "Server Not Responding")
               }
           }
       }
    
    func UserPostvideoAPIcall(Type :String ,Content :String,Categoriyid :Int,Language :String,userPostVideo: URL,completion:@escaping (_ success : Bool, _ result : UserPostVideoRootClass?) -> Void){
              
        let userdata = UserDefaults(suiteName: "group.com.Glasierinc.Girlventdemo")
        let data = userdata?.value(forKey: "GIRLVENT") as! String
                     
                                                      let usertokan = data
                                                       let header : HTTPHeaders = [
                                                          "Accept-Language"    :  "En",
                                                          "token" : usertokan
                                                          ]
              
                SwiftSpinner.show( "Loading")
        
        let categorystring = String(Categoriyid)
              AF.upload(multipartFormData: { (multipartFormData) in
                  multipartFormData.append(Type.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!, withName: "type")
                  multipartFormData.append(Content.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!, withName: "content")
                  multipartFormData.append(categorystring.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!, withName: "forum_id")
                  multipartFormData.append(Language.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!, withName: "language")
                  
                  print(multipartFormData)
                  multipartFormData.append(userPostVideo, withName: "media_file", fileName: "video.mp4", mimeType: "video/mp4")

                      //multipartFormData.append(userPostimage, withName: "media_file", fileName: "userPost.jpg" , mimeType: "image/jpg")
       
                  
                  },to:POST_URL,method:.post,headers:header) .responseJSON{ response in

                    SwiftSpinner.hide()
                  
                   switch response.result {
                   case .success(let value):
                    
                          print("response  \(response)")
                          
                           //SVProgressHUD.dismiss()
                          if (response.value != nil) {
                                  //let statusCode = response.response?.statusCode
                              let json = JSON(value)
                              let objRootClass = UserPostVideoRootClass(fromJson: json)
                              if (objRootClass.error == 200){
                              
                                  //HELPER.sharedInstance.globalAlert(message: objRootClass.message)
                                  completion(true,objRootClass)
                              }else{
                                   self.showAlert(message: objRootClass.message)
                                  completion(false,objRootClass)
                              }
                              
                          }else{
                              completion(false,nil)
//                              HELPER.sharedInstance.globalAlert(message: "\(response.description)")
                            self.showAlert(message: response.description)

                          }
                          
                      
                   case .failure(let _):
                       //SVProgressHUD.dismiss()
                      completion(false,nil)
//                      HELPER.sharedInstance.globalAlert(message: GLocalizedString(key: "ServerNotResponding"))
                      self.showAlert(message: "Server Not Responding")
                  }
              }
          }
    
    func SubmitHomeTextPostAPIcall(parameter:[String:AnyObject],completion:@escaping (_ success : Bool, _ result : PostHomeTextRootClass) -> Void)
    {
      let userdata = UserDefaults(suiteName: "group.com.Glasierinc.Girlventdemo")
          let data = userdata?.value(forKey: "GIRLVENT") as! String
                       
        let usertokan = data
                                 
       let header: HTTPHeaders = [
           "Accept-Language"    :  "En",
           "token" : usertokan
       ]
     
           SwiftSpinner.show( "Loading")
       AF.request(POST_URL,method:.post,parameters:parameter,encoding: URLEncoding.default, headers: header).responseJSON
            {
                response in
                
                SwiftSpinner.hide()
                
                switch response.result {
                case .success(let value):

                    let json = JSON(value)
                    print(json)

                    let objRootClass = PostHomeTextRootClass(fromJson: json)
                    if(objRootClass.error == 200){

                         completion(true,objRootClass)
                    }
                    else  {
                         self.showAlert(message: objRootClass.message)
                        completion(false,objRootClass)
                    }

                case.failure(_):
                    print("fail")
                    break
                }
        }
    }
       //MARK:- == FUNCTION FOR GET Categories POST API ==
            func GetCategoriesListAPI(){
                //let TokenId = UserDefaults.value(forKey: "TokenId") as! String


               let param = [:] as [String : AnyObject]

                print(param)
                
                SwiftSpinner.show( "Loading")
                
                
                                   AF.request("https://girlvent.glasier.in.glasier.in/api/mobile/categories",method:.get,parameters:param,encoding: URLEncoding.default, headers: nil).responseJSON
                                       {
                                           response in
                                        
                                        SwiftSpinner.hide()
                                        switch response.result {
                                           case .success(let value):

                                                          
                                               let json = JSON(value)
                                               print(json)

                                               let objRootClass = GetCategoriesListRootClass(fromJson: json)
                                               if(objRootClass.error == 200){

                                                    self.categoriesListArray = objRootClass.data
                                               }
                                               else  {
                                                    
                                                   print("not sucess")
                                               }

                                            case.failure(_):
                                                                       
                                               print("fail")
                                               break
                                           }
                                   }

//                APIHelper.shared.GetCategoriesListAPIcall(parameter: param) { (success, result) in
//
//                    if(result.data != nil){
//                        if(success){
//
//                           self.categoriesListArray = result.data
//
//                        }
//                    } else{
//
//
//                        print("Not Success")
//                    }
//                }
       }
}
extension ShareVC : UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
       
            
        return self.categoriesListArray.count + 1
       
      
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
                       SelectCategoriesTxt.text = categoriesListArray[row - 1].name
                    selectedcategoriid = categoriesListArray[row - 1].id
                  }
           
        
 
    }
    
    
}
