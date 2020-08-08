//
//  APIHelper.swift
//  Testkart
//
//  Created by Apple on 28/12/17.
//  Copyright © 2017 ZetrixWeb Infotech LLP. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


 
 
 class APIHelper: NSObject {
    
    //var AF = SessionManager()
    
    static let shared = APIHelper()
    
   



                             
         
    
    //MARK : USER Login API
        
        func loginAPIcall(parameter:[String:AnyObject],completion:@escaping (_ success : Bool, _ result : LoginRootClass) -> Void){



    //        if let authorizationHeader = Request.authorizationHeader(user: "YazanHijazi_2018", password: "CSsp2018@NotDeadYet") {
    //            header[authorizationHeader.key] = authorizationHeader.value
    //        }
    //        header["Accept-Language" ] = HELPER.getAppLanguageWithCapital()

               AppUtility.showProgress()
            AF.request(GlobalURL.LOGIN,method:.post,parameters:parameter,encoding: URLEncoding.default, headers: nil).responseJSON
                {
                    response in switch response.result {
                    case .success(let value):

                                    AppUtility.hideProgress()
                        let json = JSON(value)
                        print(json)

                        let objRootClass = LoginRootClass(fromJson: json)
                        if(objRootClass.error == 200){

                             completion(true,objRootClass)
                        }else  {
                            //  HELPER.sharedInstance.globalAlert(message: "\(objRootClass.message!)")
                            completion(false,objRootClass)
                        }

                            case.failure(_):
                                                AppUtility.hideProgress()
                        print("fail")
                        break
                    }
            }
        }
    
        //MARK: USER Registration API
        
        func RegisterAPIcall(Firstname :String ,lastname :String,email :String,username :String,password :String,bio :String,birthmonth :String,birthday :String,gender :String,userProfileimage: Data,completion:@escaping (_ success : Bool, _ result : RegisterRootClass?) -> Void){
            
    //        if let authorizationHeader = Request.authorizationHeader(user: "YazanHijazi_2018", password: "CSsp2018@NotDeadYet") {
    //            header[authorizationHeader.key] = authorizationHeader.value
    //        }
            
           // SVProgressHUD.show()
            // SVProgressHUD.setDefaultMaskType(.custom)
            // SVProgressHUD.setBackgroundLayerColor(UIColor.lightGray.withAlphaComponent(0.5))
            
            
        
           // let URL = try! URLRequest(url: GlobalURL.REGISTERUSER, method:.post, headers: headers)
            
              AppUtility.showProgress()
            AF.upload(multipartFormData: { (multipartFormData) in
                multipartFormData.append(Firstname.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!, withName: "firstname")
                multipartFormData.append(lastname.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!, withName: "lastname")
                multipartFormData.append(email.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!, withName: "email")
                multipartFormData.append(username.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!, withName: "username")
                multipartFormData.append(password.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!, withName: "password")
                multipartFormData.append(bio.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!, withName: "bio")
                multipartFormData.append(birthmonth.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!, withName: "birth_month")
                multipartFormData.append(birthday.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!, withName: "birth_date")
                multipartFormData.append(gender.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!, withName: "gender")
            
                print(multipartFormData)
                
                    multipartFormData.append(userProfileimage, withName: "profile_image", fileName: "userprofile.jpg" , mimeType: "image/jpg")
     
                
                
                },to:GlobalURL.REGISTERUSER,method:.post,headers:nil) .responseJSON{ response in
                
                    switch response.result {
                case .success(let value):
                    
                  
                        
                         //SVProgressHUD.dismiss()
                        AppUtility.hideProgress()
                        if (response.value != nil) {
                                //let statusCode = response.response?.statusCode
                            let json = JSON(value)
                            let objRootClass = RegisterRootClass(fromJson: json)
                            if (objRootClass.error == 200){
                            
                                //HELPER.sharedInstance.globalAlert(message: objRootClass.message)
                                completion(true,objRootClass)
                            }else{
                               //  HELPER.sharedInstance.globalAlert(message: objRootClass.message)
                                completion(false,objRootClass)
                            }
                            
                        }else{
                            completion(false,nil)
                           // HELPER.sharedInstance.globalAlert(message: "\(response.description)")

                        }
                        
                    
                case .failure(let encodingError):
                     //SVProgressHUD.dismiss()
                    completion(false,nil)
                    HELPER.sharedInstance.globalAlert(message: GLocalizedString(key: "ServerNotResponding"))
                }
            }
        }
    
    //MARK: USER Forgot password API

           func ForgotPasswordAPIcall(parameter:[String:AnyObject],completion:@escaping (_ success : Bool, _ result : ForgotPasswordRootClass) -> Void){

            
                  AppUtility.showProgress()
               AF.request(GlobalURL.FORGOTPASSWORD,method:.post,parameters:parameter,encoding: URLEncoding.default, headers: nil).responseJSON
                   {
                       response in switch response.result {
                       case .success(let value):

                                       AppUtility.hideProgress()
                           let json = JSON(value)
                           print(json)

                           let objRootClass = ForgotPasswordRootClass(fromJson: json)
                           if(objRootClass.error == 200){

                                completion(true,objRootClass)
                           }
                           else  {
                                 HELPER.sharedInstance.globalAlert(message: "\(objRootClass.message!)")
                               completion(false,objRootClass)
                           }

                               case.failure(_):
                                                   AppUtility.hideProgress()
                           print("fail")
                           break
                       }
               }
           }
       
    //MARK: USER Home post  API
              
              func GetHomePostAPIcall(parameter:[String:AnyObject],completion:@escaping (_ success : Bool, _ result : GetHomePostRootClass) -> Void){

               
                    // AppUtility.showProgress()
                let user:LoginData = HELPER.getSession()
                            
                            let usertokan = user.token
                                                       
                             let header: HTTPHeaders = [
                                 "Accept-Language"    :  HELPER.getAppLanguageWithCapital(),
                                 "token" : usertokan!
                             ]
                           
                
                
                  AF.request(GlobalURL.GETHOMEPOST,method:.post,parameters:parameter,encoding: URLEncoding.default, headers: header).responseJSON
                      {
                          response in switch response.result {
                          case .success(let value):

                                          //AppUtility.hideProgress()
                              let json = JSON(value)
                              print(json)

                              let objRootClass = GetHomePostRootClass(fromJson: json)
                              if(objRootClass.error == 200){

                                   completion(true,objRootClass)
                              }
                              else  {
                                    HELPER.sharedInstance.globalAlert(message: "\(objRootClass.message!)")
                                  completion(false,objRootClass)
                              }

                            case.failure(_):
                                   // completion(false,objRootClass)
                                                      //AppUtility.hideProgress()
                              print("fail")
                              break
                          }
                  }
              }
    //MARK: USER PostHome Text API
                 
                 func SubmitHomeTextPostAPIcall(parameter:[String:AnyObject],completion:@escaping (_ success : Bool, _ result : PostHomeTextRootClass) -> Void){
                       let user:LoginData = HELPER.getSession()
                   
                   let usertokan = user.token
                                              
                    let header: HTTPHeaders = [
                        "Accept-Language"    :  HELPER.getAppLanguageWithCapital(),
                        "token" : usertokan!
                    ]
                  
                        AppUtility.showProgress()
                    AF.request(GlobalURL.SUBMITHOMEPOSTTEXT,method:.post,parameters:parameter,encoding: URLEncoding.default, headers: header).responseJSON
                         {
                             response in switch response.result {
                             case .success(let value):

                                             AppUtility.hideProgress()
                                 let json = JSON(value)
                                 print(json)

                                 let objRootClass = PostHomeTextRootClass(fromJson: json)
                                 if(objRootClass.error == 200){

                                      completion(true,objRootClass)
                                 }
                                 else  {
                                       HELPER.sharedInstance.globalAlert(message: "\(objRootClass.message!)")
                                     completion(false,objRootClass)
                                 }

                                     case.failure(_):
                                                         AppUtility.hideProgress()
                                 print("fail")
                                 break
                             }
                     }
                 }
    //MARK:Get Categories List API
                 
                 func GetCategoriesListAPIcall(parameter:[String:AnyObject],completion:@escaping (_ success : Bool, _ result : GetCategoriesListRootClass) -> Void){

                  
                        AppUtility.showProgress()
                     AF.request(GlobalURL.GETCATEGORIESLIST,method:.get,parameters:parameter,encoding: URLEncoding.default, headers: nil).responseJSON
                         {
                             response in switch response.result {
                             case .success(let value):

                                             AppUtility.hideProgress()
                                 let json = JSON(value)
                                 print(json)

                                 let objRootClass = GetCategoriesListRootClass(fromJson: json)
                                 if(objRootClass.error == 200){

                                      completion(true,objRootClass)
                                 }
                                 else  {
                                       HELPER.sharedInstance.globalAlert(message: "\(objRootClass.message!)")
                                     completion(false,objRootClass)
                                 }

                                     case.failure(_):
                                                         AppUtility.hideProgress()
                                 print("fail")
                                 break
                             }
                     }
                 }
    
    
    //MARK:Get Comment List API
                 
                 func GetCommentListAPIcall(parameter:[String:AnyObject],completion:@escaping (_ success : Bool, _ result : GetCommentListRootClass) -> Void){
//                    let user:LoginData = HELPER.getSession()
//                                 
//                                 let usertokan = user.token
//                                  let header : HTTPHeaders  = [
//                                     "Accept-Language"    :  HELPER.getAppLanguageWithCapital(),
//                                     "token" : usertokan!
//                                     ]
                                            
                                         
                  
                        AppUtility.showProgress()
                    AF.request(GlobalURL.GETCOMMENTLIST,method:.post,parameters:parameter,encoding: URLEncoding.default, headers:nil).responseJSON
                         {
                             response in switch response.result {
                             case .success(let value):

                                             AppUtility.hideProgress()
                                 let json = JSON(value)
                                 print(json)

                                 let objRootClass = GetCommentListRootClass(fromJson: json)
                                 if(objRootClass.error == 200){

                                      completion(true,objRootClass)
                                 }
                                 else  {
                                      // HELPER.sharedInstance.globalAlert(message: "\(objRootClass.message!)")
                                     completion(false,objRootClass)
                                 }

                                     case.failure(_):
                                        print(response.description)
                                                         AppUtility.hideProgress()
                                 print("fail")
                                 break
                             }
                     }
                 }
        //MARK:Add Comment API
                     
                     func AddCommentAPIcall(parameter:[String:AnyObject],completion:@escaping (_ success : Bool, _ result : AddCommentRootClass) -> Void){
                        let user:LoginData = HELPER.getSession()
    
                                     let usertokan = user.token
                                      let header : HTTPHeaders = [
                                         "Accept-Language"    :  HELPER.getAppLanguageWithCapital(),
                                         "token" : usertokan!
                                         ]
                                                
                                             
                      
                            AppUtility.showProgress()
                        AF.request(GlobalURL.ADDCOMMENT,method:.post,parameters:parameter,encoding: URLEncoding.default, headers: header).responseJSON
                             {
                                 response in switch response.result {
                                 case .success(let value):

                                                 AppUtility.hideProgress()
                                     let json = JSON(value)
                                     print(json)

                                     let objRootClass = AddCommentRootClass(fromJson: json)
                                     if(objRootClass.error == 200){

                                          completion(true,objRootClass)
                                     }
                                     else  {
                                           HELPER.sharedInstance.globalAlert(message: "\(objRootClass.message!)")
                                         completion(false,objRootClass)
                                     }

                                case.failure(_):
                                            print(response.description)
                                                             AppUtility.hideProgress()
                                     print("fail")
                                     break
                                 }
                         }
                     }
    
      //MARK: Edit Comment API
          func EditCommentAPIcall(parameter:[String:AnyObject],completion:@escaping (_ success : Bool, _ result : EditCommnetsRootClass) -> Void){
    //                    let user:LoginData = HELPER.getSession()
    //
    //                                 let usertokan = user.token
    //                                  let header : HTTPHeaders  = [
    //                                     "Accept-Language"    :  HELPER.getAppLanguageWithCapital(),
    //                                     "token" : usertokan!
    //                                     ]
                                                
                                             
                      
                            AppUtility.showProgress()
                        AF.request(GlobalURL.EDITCOMMENT,method:.post,parameters:parameter,encoding: URLEncoding.default, headers:nil).responseJSON
                             {
                                 response in switch response.result {
                                 case .success(let value):

                                                 AppUtility.hideProgress()
                                     let json = JSON(value)
                                     print(json)

                                     let objRootClass = EditCommnetsRootClass(fromJson: json)
                                     if(objRootClass.error == 200){

                                          completion(true,objRootClass)
                                     }
                                     else  {
                                           HELPER.sharedInstance.globalAlert(message: "\(objRootClass.message!)")
                                         completion(false,objRootClass)
                                     }

                                         case.failure(_):
                                            print(response.description)
                                                             AppUtility.hideProgress()
                                     print("fail")
                                     break
                                 }
                         }
                     }
    
       
    //MARK: USER  post  API
              
    func GetUserPostListAPIcall(parameter:[String:AnyObject],UserTokan:String,completion:@escaping (_ success : Bool, _ result : UserPostListRootClass) -> Void){
        
//        let user:LoginData = HELPER.getSession()
//         let usertokan = user.token
                         
            let header : HTTPHeaders = [
                        "Accept-Language"    :  HELPER.getAppLanguageWithCapital(),
                        "token" : UserTokan
                    ]
        
                     AppUtility.showProgress()
        AF.request(GlobalURL.GETUSERPOSTLIST,method:.post,parameters:parameter,encoding: URLEncoding.default, headers: header ).responseJSON
                      {
                          response in switch response.result {
                          case .success(let value):

                                          AppUtility.hideProgress()
                              let json = JSON(value)
                              print(json)

                              let objRootClass = UserPostListRootClass(fromJson: json)
                              if(objRootClass.error == 200){

                                   completion(true,objRootClass)
                              }
                              else  {
                                    HELPER.sharedInstance.globalAlert(message: "\(objRootClass.message!)")
                                  completion(false,objRootClass)
                              }

                                  case.failure(_):
                                                      AppUtility.hideProgress()
                              print("fail")
                              break
                          }
                  }
              }
    //MARK: USER Post Image API
          
    func UserPostImageAPIcall(Type :String ,Content :String,Categoriyid :Int,Language :String,userPostimage: Data,completion:@escaping (_ success : Bool, _ result : UserPostImageRootClass?) -> Void){
              
        let user:LoginData = HELPER.getSession()
                     
                                                      let usertokan = user.token
                                                       let header : HTTPHeaders = [
                                                          "Accept-Language"    :  HELPER.getAppLanguageWithCapital(),
                                                          "token" : usertokan!
                                                          ]
              
                AppUtility.showProgress()
        
        let categorystring = String(Categoriyid)
              AF.upload(multipartFormData: { (multipartFormData) in
                  multipartFormData.append(Type.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!, withName: "type")
                  multipartFormData.append(Content.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!, withName: "content")
                  multipartFormData.append(categorystring.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!, withName: "forum_id")
                  multipartFormData.append(Language.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!, withName: "language")
                  
                  print(multipartFormData)
                  
                      multipartFormData.append(userPostimage, withName: "media_file", fileName: "userPost.jpg" , mimeType: "image/jpg")
       
                  
                      },to:GlobalURL.SUBMITHOMEPOSTTEXT,method:.post,headers:header) .responseJSON{ response in
            
                  
                   switch response.result {
                   case .success(let value):
                          print("response  \(response)")
                          
                           //SVProgressHUD.dismiss()
                          AppUtility.hideProgress()
                          if (response.value != nil) {
                                  //let statusCode = response.response?.statusCode
                              let json = JSON(value)
                              let objRootClass = UserPostImageRootClass(fromJson: json)
                              if (objRootClass.error == 200){
                              
                                  //HELPER.sharedInstance.globalAlert(message: objRootClass.message)
                                  completion(true,objRootClass)
                              }else{
                                   HELPER.sharedInstance.globalAlert(message: objRootClass.message)
                                  completion(false,objRootClass)
                              }
                              
                          }else{
                              completion(false,nil)
                              HELPER.sharedInstance.globalAlert(message: "\(response.description)")

                          }
                          
                      
                  case .failure(let encodingError):
                       //SVProgressHUD.dismiss()
                      completion(false,nil)
                      HELPER.sharedInstance.globalAlert(message: GLocalizedString(key: "ServerNotResponding"))
                  }
              }
          }
    //MARK: USER Post Image API
          
    func UserPostvideoAPIcall(Type :String ,Content :String,Categoriyid :Int,Language :String,userPostVideo: URL,completion:@escaping (_ success : Bool, _ result : UserPostVideoRootClass?) -> Void){
              
        let user:LoginData = HELPER.getSession()
                     
                                                      let usertokan = user.token
                                                       let header : HTTPHeaders = [
                                                          "Accept-Language"    :  HELPER.getAppLanguageWithCapital(),
                                                          "token" : usertokan!
                                                          ]
              
                AppUtility.showProgress()
        
        let categorystring = String(Categoriyid)
              AF.upload(multipartFormData: { (multipartFormData) in
                  multipartFormData.append(Type.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!, withName: "type")
                  multipartFormData.append(Content.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!, withName: "content")
                  multipartFormData.append(categorystring.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!, withName: "forum_id")
                  multipartFormData.append(Language.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!, withName: "language")
                  
                  print(multipartFormData)
                  multipartFormData.append(userPostVideo, withName: "media_file", fileName: "video.mp4", mimeType: "video/mp4")

                      //multipartFormData.append(userPostimage, withName: "media_file", fileName: "userPost.jpg" , mimeType: "image/jpg")
       
                  
                  },to:GlobalURL.SUBMITHOMEPOSTTEXT,method:.post,headers:header) .responseJSON{ response in

           
                  
                   switch response.result {
                   case .success(let value):
                    
                          print("response  \(response)")
                          
                           //SVProgressHUD.dismiss()
                          AppUtility.hideProgress()
                          if (response.value != nil) {
                                  //let statusCode = response.response?.statusCode
                              let json = JSON(value)
                              let objRootClass = UserPostVideoRootClass(fromJson: json)
                              if (objRootClass.error == 200){
                              
                                  //HELPER.sharedInstance.globalAlert(message: objRootClass.message)
                                  completion(true,objRootClass)
                              }else{
                                   HELPER.sharedInstance.globalAlert(message: objRootClass.message)
                                  completion(false,objRootClass)
                              }
                              
                          }else{
                              completion(false,nil)
                              HELPER.sharedInstance.globalAlert(message: "\(response.description)")

                          }
                          
                      
                  case .failure(let encodingError):
                       //SVProgressHUD.dismiss()
                      completion(false,nil)
                      HELPER.sharedInstance.globalAlert(message: GLocalizedString(key: "ServerNotResponding"))
                  }
              }
          }
    
    
    
       
    //MARK: USER My Images  API
              
              func GetUserMyimagesListAPIcall(parameter:[String:AnyObject],completion:@escaping (_ success : Bool, _ result : UserMyImagesListRootClass) -> Void){

                                   let user:LoginData = HELPER.getSession()
                  
                                                   let usertokan = user.token
                                                    let header : HTTPHeaders  = [
                                                       "Accept-Language"    :  HELPER.getAppLanguageWithCapital(),
                                                       "token" : usertokan!
                                                       ]
                
 
                     AppUtility.showProgress()
                AF.request(GlobalURL.GETMYIMAGESLIST,method:.post,parameters:parameter,encoding: URLEncoding.default, headers: header).responseJSON
                      {
                          response in switch response.result {
                          case .success(let value):

                                          AppUtility.hideProgress()
                              let json = JSON(value)
                              print(json)

                              let objRootClass = UserMyImagesListRootClass(fromJson: json)
                              if(objRootClass.error == 200){

                                   completion(true,objRootClass)
                              }
                              else  {
                                   // HELPER.sharedInstance.globalAlert(message: "\(objRootClass.message!)")
                                  completion(false,objRootClass)
                              }

                                  case.failure(_):
                                                      AppUtility.hideProgress()
                              print("fail")
                              break
                          }
                  }
              }
    
      //MARK: USER My Video  API
                 
                 func GetUserMyVideoListAPIcall(parameter:[String:AnyObject],completion:@escaping (_ success : Bool, _ result : UserMyVideoListRootClass) -> Void){

                                      let user:LoginData = HELPER.getSession()
                     
                                                      let usertokan = user.token
                                                      let header : HTTPHeaders  = [
                                                          "Accept-Language"    :  HELPER.getAppLanguageWithCapital(),
                                                          "token" : usertokan!
                                                          ]
                   
    
                        AppUtility.showProgress()
                   AF.request(GlobalURL.GETMYVIDEOLIST,method:.post,parameters:parameter,encoding: URLEncoding.default, headers: header).responseJSON
                         {
                             response in switch response.result {
                             case .success(let value):

                                             AppUtility.hideProgress()
                                 let json = JSON(value)
                                 print(json)

                                 let objRootClass = UserMyVideoListRootClass(fromJson: json)
                                 if(objRootClass.error == 200){

                                      completion(true,objRootClass)
                                 }
                                 else  {
                                     //  HELPER.sharedInstance.globalAlert(message: "\(objRootClass.message!)")
                                     completion(false,objRootClass)
                                 }

                                     case.failure(_):
                                                         AppUtility.hideProgress()
                                 print("fail")
                                 break
                             }
                     }
                 }
    //MARK:Delete Post API
             func DeletePostAPIcall(parameter:[String:AnyObject],completion:@escaping (_ success : Bool, _ result : PostDeleteRootClass) -> Void){
     
                
                               AppUtility.showProgress()
                           AF.request(GlobalURL.DELETEPOST,method:.post,parameters:parameter,encoding: URLEncoding.default, headers:nil).responseJSON
                                {
                                    response in switch response.result {
                                    case .success(let value):

                                                    AppUtility.hideProgress()
                                        let json = JSON(value)
                                        print(json)

                                        let objRootClass = PostDeleteRootClass(fromJson: json)
                                        if(objRootClass.error == 200){

                                             completion(true,objRootClass)
                                        }
                                        else  {
                                              HELPER.sharedInstance.globalAlert(message: "\(objRootClass.message!)")
                                            completion(false,objRootClass)
                                        }

                                            case.failure(_):
                                               print(response.description)
                                                                AppUtility.hideProgress()
                                        print("fail")
                                        break
                                    }
                            }
                        }
    //MARK:Delete Comment API
                func DeleteCommentAPIcall(parameter:[String:AnyObject],completion:@escaping (_ success : Bool, _ result : CommentDeleteRootClass) -> Void){
        
                   
                                  AppUtility.showProgress()
                              AF.request(GlobalURL.DELETECOMMENT,method:.post,parameters:parameter,encoding: URLEncoding.default, headers:nil).responseJSON
                                   {
                                       response in switch response.result {
                                       case .success(let value):

                                                       AppUtility.hideProgress()
                                           let json = JSON(value)
                                           print(json)

                                           let objRootClass = CommentDeleteRootClass(fromJson: json)
                                           if(objRootClass.error == 200){

                                                completion(true,objRootClass)
                                           }
                                           else  {
                                                 HELPER.sharedInstance.globalAlert(message: "\(objRootClass.message!)")
                                               completion(false,objRootClass)
                                           }

                                               case.failure(_):
                                                  print(response.description)
                                                                   AppUtility.hideProgress()
                                           print("fail")
                                           break
                                       }
                               }
                           }
       
    
    
    //MARK:Get Categories List API
                 
                 func GetCategoriesPostListAPIcall(parameter:[String:AnyObject],completion:@escaping (_ success : Bool, _ result : CategoriesPostListRootClass) -> Void){

                  
                        AppUtility.showProgress()
                     AF.request(GlobalURL.GETCATEGORIESPOSTLIST,method:.post,parameters:parameter,encoding: URLEncoding.default, headers: nil).responseJSON
                         {
                             response in switch response.result {
                             case .success(let value):

                                             AppUtility.hideProgress()
                                 let json = JSON(value)
                                 print(json)

                                 let objRootClass = CategoriesPostListRootClass(fromJson: json)
                                 if(objRootClass.error == 200){

                                      completion(true,objRootClass)
                                 }
                                 else  {
                                      // HELPER.sharedInstance.globalAlert(message: "\(objRootClass.message!)")
                                     completion(false,objRootClass)
                                 }

                            case.failure(_):
                                
                                             
                                AppUtility.hideProgress()
                                print(response.description)
                                print("fail")
                                 break
                             }
                     }
                 }
    
    //MARK: USER Post Image API
          
    func SendMsgAPIcall(Messge :String ,toUserid :String,Language :String,userPostvideo: URL,userpostimage:Data,whocome:String,completion:@escaping (_ success : Bool, _ result : SendMsgRootClass?) -> Void){
              
        let user:LoginData = HELPER.getSession()
                     
                                                      let usertokan = user.token
                                                       let header : HTTPHeaders  = [
                                                          "Accept-Language"    :  HELPER.getAppLanguageWithCapital(),
                                                          "token" : usertokan!
                                                          ]
              
                AppUtility.showProgress()
        
    
              AF.upload(multipartFormData: { (multipartFormData) in
                  multipartFormData.append(Messge.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!, withName: "message")
                  multipartFormData.append(toUserid.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!, withName: "to_user_id")
                  multipartFormData.append(Language.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!, withName: "language")
                  
                  print(multipartFormData)
                if whocome == "0"{
                            multipartFormData.append(userpostimage, withName: "media_file", fileName: "userPost.jpg" , mimeType: "image/jpg")
                    
                }else if whocome == "1"{
                     multipartFormData.append(userPostvideo, withName: "media_file", fileName: "video.mp4", mimeType: "video/mp4")
                }else{
                    
                }
                 
                  
                      //multipartFormData.append(userPostimage, withName: "media_file", fileName: "userPost.jpg" , mimeType: "image/jpg")
       
                  
                  },to:GlobalURL.SENDMESSAGE,method:.post,headers:header) .responseJSON{ response in

        
                  
                    switch response.result {
                        case .success(let value):
                          print("response  \(response)")
                          
                           //SVProgressHUD.dismiss()
                          AppUtility.hideProgress()
                          if (response.value != nil) {
                                  //let statusCode = response.response?.statusCode
                              let json = JSON(value)
                              let objRootClass = SendMsgRootClass(fromJson: json)
                              if (objRootClass.error == 200){
                              
                                  //HELPER.sharedInstance.globalAlert(message: objRootClass.message)
                                  completion(true,objRootClass)
                              }else{
                                   HELPER.sharedInstance.globalAlert(message: objRootClass.message)
                                  completion(false,objRootClass)
                              }
                              
                          }else{
                              completion(false,nil)
                              HELPER.sharedInstance.globalAlert(message: "\(response.description)")

                          }
                          
                      
                  case .failure(let encodingError):
                       //SVProgressHUD.dismiss()
                      completion(false,nil)
                      HELPER.sharedInstance.globalAlert(message: GLocalizedString(key: "ServerNotResponding"))
                  }
              }
          }
    
    //MARK:Get User List API
                 
                 func GetUserListAPIcall(parameter:[String:AnyObject],completion:@escaping (_ success : Bool, _ result : AllUserListRootClass) -> Void){

                  let user:LoginData = HELPER.getSession()
                                    
                                                                     let usertokan = user.token
                                                                      let header : HTTPHeaders  = [
                                                                         "Accept-Language"    :  HELPER.getAppLanguageWithCapital(),
                                                                         "token" : usertokan!
                                                                         ]
                        AppUtility.showProgress()
                    AF.request(GlobalURL.GETUSERLIST,method:.post,parameters:parameter,encoding: URLEncoding.default, headers: header).responseJSON
                         {
                             response in switch response.result {
                             case .success(let value):

                                             AppUtility.hideProgress()
                                 let json = JSON(value)
                                 print(json)

                                 let objRootClass = AllUserListRootClass(fromJson: json)
                                 if(objRootClass.error == 200){

                                      completion(true,objRootClass)
                                 }
                                 else  {
                                       HELPER.sharedInstance.globalAlert(message: "\(objRootClass.message!)")
                                     completion(false,objRootClass)
                                 }

                            case.failure(_):
                                
                                             
                                AppUtility.hideProgress()
                                print(response.description)
                                print("fail")
                                 break
                             }
                     }
                 }
    
    func GetUserDetailaPIcall(parameter:[String:AnyObject],completion:@escaping (_ success : Bool, _ result : UserDetailsRootClass) -> Void){

                  let user:LoginData = HELPER.getSession()
                                    
                let usertokan = user.token
                    let header : HTTPHeaders  = [
                            "Accept-Language"    :  HELPER.getAppLanguageWithCapital(),
                            "token" : usertokan!
                            ]
                        AppUtility.showProgress()
        AF.request(GlobalURL.GETUSERDETAIL,method:.post,parameters:parameter,encoding: URLEncoding.default, headers: header).responseJSON
                         {
                             response in switch response.result {
                             case .success(let value):

                                             AppUtility.hideProgress()
                                 let json = JSON(value)
                                 print(json)

                                 let objRootClass = UserDetailsRootClass(fromJson: json)
                                 if(objRootClass.error == 200){

                                      completion(true,objRootClass)
                                 }
                                 else  {
                                       HELPER.sharedInstance.globalAlert(message: "\(objRootClass.message!)")
                                     completion(false,objRootClass)
                                 }

                            case.failure(_):
                                
                                             
                                AppUtility.hideProgress()
                                print(response.description)
                                print("fail")
                                 break
                             }
                     }
                 }
    
    func SubmitUserDetailaPIcall(parameter:[String:AnyObject],completion:@escaping (_ success : Bool, _ result : SubmitUserDetailsRootClass) -> Void){

                  let user:LoginData = HELPER.getSession()
                  let usertokan = user.token
                  let header : HTTPHeaders  = [
                    "Accept-Language"    :  HELPER.getAppLanguageWithCapital(),
                    "token" : usertokan!
                    ]
        
        AppUtility.showProgress()
        
        AF.request(GlobalURL.SUBMITUSERDETAIL,method:.post,parameters:parameter,encoding: URLEncoding.default, headers: header).responseJSON
                        {
                             response in switch response.result {
                             case .success(let value):

                                 AppUtility.hideProgress()
                                 let json = JSON(value)
                                 print(json)

                                 let objRootClass = SubmitUserDetailsRootClass(fromJson: json)
                                 if(objRootClass.error == 200){

                                      completion(true,objRootClass)
                                 }
                                 else  {
                                     HELPER.sharedInstance.globalAlert(message: "\(objRootClass.message!)")
                                     completion(false,objRootClass)
                                 }

                             case.failure(_):
                                
                                             
                                 AppUtility.hideProgress()
                                 print(response.description)
                                 print("fail")
                                 break
                             }
                        }
                 }
    
    //MARK: USER update profile Image API
             
       func UserUpdateProfilePicAPIcall(userpostimage:Data,completion:@escaping (_ success : Bool, _ result : SubmitUserProfilePicRootClass?) -> Void){
                 
           let user:LoginData = HELPER.getSession()
                        
                                                         let usertokan = user.token
                                                          let header : HTTPHeaders  = [
                                                             "Accept-Language"    :  HELPER.getAppLanguageWithCapital(),
                                                             "token" : usertokan!
                                                             ]
                 
                   AppUtility.showProgress()
           
       
                 AF.upload(multipartFormData: { (multipartFormData) in
                   
                               multipartFormData.append(userpostimage, withName: "profile_file", fileName: "userPost.jpg" , mimeType: "image/jpg")
                   
                     
                     },to:GlobalURL.SUBMITUSERPROFILEPIC,method:.post,headers:header) .responseJSON{ response in

                     
                        switch response.result {
                           case .success(let value):
                         
                    
                             print("response  \(response)")
                             
                              //SVProgressHUD.dismiss()
                             AppUtility.hideProgress()
                             if (response.value != nil) {
                                     //let statusCode = response.response?.statusCode
                                 let json = JSON(value)
                                 let objRootClass = SubmitUserProfilePicRootClass(fromJson: json)
                                 if (objRootClass.error == 200){
                                 
                                     //HELPER.sharedInstance.globalAlert(message: objRootClass.message)
                                     completion(true,objRootClass)
                                 }else{
                                      HELPER.sharedInstance.globalAlert(message: objRootClass.message)
                                     completion(false,objRootClass)
                                 }
                                 
                             }else{
                                 completion(false,nil)
                                 HELPER.sharedInstance.globalAlert(message: "\(response.description)")

                             }
                             
                         
                     case .failure(let encodingError):
                          //SVProgressHUD.dismiss()
                         completion(false,nil)
                         HELPER.sharedInstance.globalAlert(message: GLocalizedString(key: "ServerNotResponding"))
                     }
                 }
             }
    
    func ChnagepasswordAPIcall(parameter:[String:AnyObject],completion:@escaping (_ success : Bool, _ result : ChangepasswordRootClass) -> Void){

                  let user:LoginData = HELPER.getSession()
                  let usertokan = user.token
                  let header : HTTPHeaders  = [
                    "Accept-Language"    :  HELPER.getAppLanguageWithCapital(),
                    "token" : usertokan!
                    ]
        
        AppUtility.showProgress()
        
        AF.request(GlobalURL.CHANEGEPASSWORD,method:.post,parameters:parameter,encoding: URLEncoding.default, headers: header).responseJSON
                         {
                             response in switch response.result {
                             case .success(let value):

                                
                                 AppUtility.hideProgress()
                                 let json = JSON(value)
                                 print(json)

                                 let objRootClass = ChangepasswordRootClass(fromJson: json)
                                 if(objRootClass.error == 200){

                                      completion(true,objRootClass)
                                 }
                                 else  {
                                       HELPER.sharedInstance.globalAlert(message: "\(objRootClass.message!)")
                                     completion(false,objRootClass)
                                 }

                            case.failure(_):
                                
                                             
                                AppUtility.hideProgress()
                                print(response.description)
                                print("fail")
                                 break
                             }
                     }
                 }
    
    func GetMyMessageListAPIcall(parameter:[String:AnyObject],completion:@escaping (_ success : Bool, _ result : GetMyMessageListRootClass) -> Void){

                   let user:LoginData = HELPER.getSession()
                   let usertokan = user.token
                   let header : HTTPHeaders  = [
                     "Accept-Language"    :  HELPER.getAppLanguageWithCapital(),
                     "token" : usertokan!
                     ]
         
         AppUtility.showProgress()
         
         AF.request(GlobalURL.GETMYMESSAGELIST,method:.post,parameters:parameter,encoding: URLEncoding.default, headers: header).responseJSON
                          {
                              response in switch response.result {
                              case .success(let value):

                                 
                                  AppUtility.hideProgress()
                                  let json = JSON(value)
                                  print(json)

                                  let objRootClass = GetMyMessageListRootClass(fromJson: json)
                                  if(objRootClass.error == 200){

                                       completion(true,objRootClass)
                                  }
                                  else  {
                                       // HELPER.sharedInstance.globalAlert(message: "\(objRootClass.message!)")
                                      completion(false,objRootClass)
                                  }

                             case.failure(_):
                                 
                                              
                                 AppUtility.hideProgress()
                                 print(response.description)
                                 print("fail")
                                  break
                              }
                      }
                  }
    
    
    //MARK:Delete My Message API
                   func DeleteMyMessageAPIcall(parameter:[String:AnyObject],completion:@escaping (_ success : Bool, _ result : DeleteMyMessageRootClass) -> Void){
           
                      
                                     AppUtility.showProgress()
                                 AF.request(GlobalURL.DELETEMYMESSAGE,method:.post,parameters:parameter,encoding: URLEncoding.default, headers:nil).responseJSON
                                      {
                                          response in switch response.result {
                                          case .success(let value):

                                                          AppUtility.hideProgress()
                                              let json = JSON(value)
                                              print(json)

                                              let objRootClass = DeleteMyMessageRootClass(fromJson: json)
                                              if(objRootClass.error == 200){

                                                   completion(true,objRootClass)
                                              }
                                              else  {
                                                    HELPER.sharedInstance.globalAlert(message: "\(objRootClass.message!)")
                                                  completion(false,objRootClass)
                                              }

                                                  case.failure(_):
                                                     print(response.description)
                                                                      AppUtility.hideProgress()
                                              print("fail")
                                              break
                                          }
                                  }
                              }
    //MARK: Get ForumList API
    
      func GetForumListAPIcall(parameter:[String:AnyObject],completion:@escaping (_ success : Bool, _ result : ForumListRootClass) -> Void){
            
                       let user:LoginData = HELPER.getSession()
                                  let usertokan = user.token
                                  let header : HTTPHeaders  = [
                                    "Accept-Language"    :  HELPER.getAppLanguageWithCapital(),
                                    "token" : usertokan!
                                    ]
            AppUtility.showProgress()
        AF.request(GlobalURL.GETFORUMLIST,method:.post,parameters:parameter,encoding: URLEncoding.default, headers:header).responseJSON
              {
                response in switch response.result {
                   case .success(let value):

                                                  AppUtility.hideProgress()
                                               let json = JSON(value)
                                               print(json)

                                               let objRootClass = ForumListRootClass(fromJson: json)
                                               if(objRootClass.error == 200){

                                                    completion(true,objRootClass)
                                               }
                                               else  {
                                                    // HELPER.sharedInstance.globalAlert(message: GLocalizedString(key: "mymessage_NoMessages"))
                                                   completion(false,objRootClass)
                                               }

                case.failure(_):
                    
                                                      print(response.description)
                                                                       AppUtility.hideProgress()
                                               print("fail")
                                               break
                                           }
                                   }
                               }
           //MARK: Create Forum API
              
                func CreateForumAPIcall(parameter:[String:AnyObject],completion:@escaping (_ success : Bool, _ result : CreateForumRootClass) -> Void){
                      
                                 
                      AppUtility.showProgress()
                    let user:LoginData = HELPER.getSession()
                                      let usertokan = user.token
                                      let header : HTTPHeaders  = [
                                        "Accept-Language"    :  HELPER.getAppLanguageWithCapital(),
                                        "token" : usertokan!
                                        ]
                    
                    AF.request(GlobalURL.CREATEFORUM,method:.post,parameters:parameter,encoding: URLEncoding.default, headers:header).responseJSON
                        {
                          response in switch response.result {
                             case .success(let value):

                                                            AppUtility.hideProgress()
                                                         let json = JSON(value)
                                                         print(json)

                                                         let objRootClass = CreateForumRootClass(fromJson: json)
                                                         if(objRootClass.error == 200){

                                                              completion(true,objRootClass)
                                                         }
                                                         else  {
                                                               HELPER.sharedInstance.globalAlert(message: "\(objRootClass.message!)")
                                                             completion(false,objRootClass)
                                                         }

                          case.failure(_):
                              
                                                                print(response.description)
                                                                                 AppUtility.hideProgress()
                                                         print("fail")
                                                         break
                                                     }
                                             }
                                         }
    //MARK: Create Forum API
       
         func ForumDetilsListAPIcall(parameter:[String:AnyObject],completion:@escaping (_ success : Bool, _ result : ForumDetilsRootClass) -> Void){
               
                          
               AppUtility.showProgress()
             let user:LoginData = HELPER.getSession()
                               let usertokan = user.token
                               let header : HTTPHeaders  = [
                                 "Accept-Language"    :  HELPER.getAppLanguageWithCapital(),
                                 "token" : usertokan!
                                 ]
             
            AF.request(GlobalURL.FORUMDETILSLIST,method:.post,parameters:parameter,encoding: URLEncoding.default, headers:header).responseJSON
                 {
                   response in switch response.result {
                      case .success(let value):

                                                     AppUtility.hideProgress()
                                                  let json = JSON(value)
                                                  print(json)

                                                  let objRootClass = ForumDetilsRootClass(fromJson: json)
                                                  if(objRootClass.error == 200){

                                                       completion(true,objRootClass)
                                                  }
                                                  else  {
                                                        HELPER.sharedInstance.globalAlert(message: "\(objRootClass.message!)")
                                                      completion(false,objRootClass)
                                                  }

                   case.failure(_):
                       
                                                         print(response.description)
                                                                          AppUtility.hideProgress()
                                                  print("fail")
                                                  break
                                              }
                                      }
                                  }
    
    
    //MARK: Create Forum API
       
         func ForumReplyAPIcall(parameter:[String:AnyObject],completion:@escaping (_ success : Bool, _ result : ForumReplyRootClass) -> Void){
               
                          
               AppUtility.showProgress()
             let user:LoginData = HELPER.getSession()
                               let usertokan = user.token
                               let header : HTTPHeaders  = [
                                 "Accept-Language"    :  HELPER.getAppLanguageWithCapital(),
                                 "token" : usertokan!
                                 ]
             
            AF.request(GlobalURL.FORUMREPLY,method:.post,parameters:parameter,encoding: URLEncoding.default, headers:header).responseJSON
                 {
                   response in switch response.result {
                      case .success(let value):

                                                     AppUtility.hideProgress()
                                                  let json = JSON(value)
                                                  print(json)

                                                  let objRootClass = ForumReplyRootClass(fromJson: json)
                                                  if(objRootClass.error == 200){

                                                       completion(true,objRootClass)
                                                  }
                                                  else  {
                                                        HELPER.sharedInstance.globalAlert(message: "\(objRootClass.message!)")
                                                      completion(false,objRootClass)
                                                  }

                   case.failure(_):
                       
                                                         print(response.description)
                                                                          AppUtility.hideProgress()
                                                  print("fail")
                                                  break
                                              }
                                      }
                                  }
    //MARK: Create Forum API
          
            func ForumdeleteAPIcall(parameter:[String:AnyObject],completion:@escaping (_ success : Bool, _ result : ForumReplyRootClass) -> Void){
                  
                             
                  AppUtility.showProgress()
                let user:LoginData = HELPER.getSession()
                                  let usertokan = user.token
                                  let header : HTTPHeaders  = [
                                    "Accept-Language"    :  HELPER.getAppLanguageWithCapital(),
                                    "token" : usertokan!
                                    ]
                
               AF.request(GlobalURL.FORUMDELETE,method:.post,parameters:parameter,encoding: URLEncoding.default, headers:header).responseJSON
                    {
                      response in switch response.result {
                         case .success(let value):

                                                        AppUtility.hideProgress()
                                                     let json = JSON(value)
                                                     print(json)

                                                     let objRootClass = ForumReplyRootClass(fromJson: json)
                                                     if(objRootClass.error == 200){

                                                          completion(true,objRootClass)
                                                     }
                                                     else  {
                                                           HELPER.sharedInstance.globalAlert(message: "\(objRootClass.message!)")
                                                         completion(false,objRootClass)
                                                     }

                      case.failure(_):
                          
                                                            print(response.description)
                                                                             AppUtility.hideProgress()
                                                     print("fail")
                                                     break
                                                 }
                                         }
                                     }
    
    //MARK: Create Forum API
           
             func ForumRenameAPIcall(parameter:[String:AnyObject],completion:@escaping (_ success : Bool, _ result : ForumReplyRootClass) -> Void){
                   
                              
                   AppUtility.showProgress()
                 let user:LoginData = HELPER.getSession()
                                   let usertokan = user.token
                                   let header : HTTPHeaders  = [
                                     "Accept-Language"    :  HELPER.getAppLanguageWithCapital(),
                                     "token" : usertokan!
                                     ]
                 
                AF.request(GlobalURL.FORUMRENAME,method:.post,parameters:parameter,encoding: URLEncoding.default, headers:header).responseJSON
                     {
                       response in switch response.result {
                          case .success(let value):

                                                         AppUtility.hideProgress()
                                                      let json = JSON(value)
                                                      print(json)

                                                      let objRootClass = ForumReplyRootClass(fromJson: json)
                                                      if(objRootClass.error == 200){

                                                           completion(true,objRootClass)
                                                      }
                                                      else  {
                                                            HELPER.sharedInstance.globalAlert(message: "\(objRootClass.message!)")
                                                          completion(false,objRootClass)
                                                      }

                       case.failure(_):
                           
                                                             print(response.description)
                                                                              AppUtility.hideProgress()
                                                      print("fail")
                                                      break
                                                  }
                                          }
                                      }
    //MARK: Create Forum API
           
             func ForumReplyDeleteResponseAPIcall(parameter:[String:AnyObject],completion:@escaping (_ success : Bool, _ result : ForumReplyRootClass) -> Void){
                   
                              
                   AppUtility.showProgress()
                 let user:LoginData = HELPER.getSession()
                                   let usertokan = user.token
                                   let header : HTTPHeaders  = [
                                     "Accept-Language"    :  HELPER.getAppLanguageWithCapital(),
                                     "token" : usertokan!
                                     ]
                 
                AF.request(GlobalURL.FORUMDELETEREPLYRESPONSE,method:.post,parameters:parameter,encoding: URLEncoding.default, headers:header).responseJSON
                     {
                       response in switch response.result {
                          case .success(let value):

                                                         AppUtility.hideProgress()
                                                      let json = JSON(value)
                                                      print(json)

                                                      let objRootClass = ForumReplyRootClass(fromJson: json)
                                                      if(objRootClass.error == 200){

                                                           completion(true,objRootClass)
                                                      }
                                                      else  {
                                                            HELPER.sharedInstance.globalAlert(message: "\(objRootClass.message!)")
                                                          completion(false,objRootClass)
                                                      }

                       case.failure(_):
                           
                                                             print(response.description)
                                                                              AppUtility.hideProgress()
                                                      print("fail")
                                                      break
                                                  }
                                          }
                                      }
    
    //MARK: Create Forum API
           
             func ForumReplyEditResponseAPIcall(parameter:[String:AnyObject],completion:@escaping (_ success : Bool, _ result : ForumReplyRootClass) -> Void){
                   
                              
                   AppUtility.showProgress()
                 let user:LoginData = HELPER.getSession()
                                   let usertokan = user.token
                                   let header : HTTPHeaders  = [
                                     "Accept-Language"    :  HELPER.getAppLanguageWithCapital(),
                                     "token" : usertokan!
                                     ]
                 
                AF.request(GlobalURL.FORUMEDITREPLYRESPONSE,method:.post,parameters:parameter,encoding: URLEncoding.default, headers:header).responseJSON
                     {
                       response in switch response.result {
                          case .success(let value):

                                                         AppUtility.hideProgress()
                                                      let json = JSON(value)
                                                      print(json)

                                                      let objRootClass = ForumReplyRootClass(fromJson: json)
                                                      if(objRootClass.error == 200){

                                                           completion(true,objRootClass)
                                                      }
                                                      else  {
                                                            HELPER.sharedInstance.globalAlert(message: "\(objRootClass.message!)")
                                                          completion(false,objRootClass)
                                                      }

                       case.failure(_):
                           
                                                             print(response.description)
                                                                              AppUtility.hideProgress()
                                                      print("fail")
                                                      break
                                                  }
                                          }
                                      }
    //MARK: Create Forum API
              
                func ForumReplyResponseAPIcall(parameter:[String:AnyObject],completion:@escaping (_ success : Bool, _ result : ForumReplyRootClass) -> Void){
                      
                                 
                      AppUtility.showProgress()
                    let user:LoginData = HELPER.getSession()
                                      let usertokan = user.token
                                      let header : HTTPHeaders  = [
                                        "Accept-Language"    :  HELPER.getAppLanguageWithCapital(),
                                        "token" : usertokan!
                                        ]
                    
                   AF.request(GlobalURL.FORUMREPLYRESPONSE,method:.post,parameters:parameter,encoding: URLEncoding.default, headers:header).responseJSON
                        {
                          response in switch response.result {
                             case .success(let value):

                                                            AppUtility.hideProgress()
                                                         let json = JSON(value)
                                                         print(json)

                                                         let objRootClass = ForumReplyRootClass(fromJson: json)
                                                         if(objRootClass.error == 200){

                                                              completion(true,objRootClass)
                                                         }
                                                         else  {
                                                               HELPER.sharedInstance.globalAlert(message: "\(objRootClass.message!)")
                                                             completion(false,objRootClass)
                                                         }

                          case.failure(_):
                              
                                                                print(response.description)
                                                                                 AppUtility.hideProgress()
                                                         print("fail")
                                                         break
                                                     }
                                             }
                                         }
    //MARK: Create Forum API
               
                 func ReportSpamAPIcall(parameter:[String:AnyObject],completion:@escaping (_ success : Bool, _ result : ForumReplyRootClass) -> Void){
                       
                                  
                       AppUtility.showProgress()
                     let user:LoginData = HELPER.getSession()
                                       let usertokan = user.token
                                       let header : HTTPHeaders  = [
                                         "Accept-Language"    :  HELPER.getAppLanguageWithCapital(),
                                         "token" : usertokan!
                                         ]
                     
                    AF.request(GlobalURL.REPORTSPAMPOST,method:.post,parameters:parameter,encoding: URLEncoding.default, headers:header).responseJSON
                         {
                           response in switch response.result {
                              case .success(let value):

                                                             AppUtility.hideProgress()
                                                          let json = JSON(value)
                                                          print(json)

                                                          let objRootClass = ForumReplyRootClass(fromJson: json)
                                                          if(objRootClass.error == 200){

                                                               completion(true,objRootClass)
                                                          }
                                                          else  {
                                                                HELPER.sharedInstance.globalAlert(message: "\(objRootClass.message!)")
                                                              completion(false,objRootClass)
                                                          }

                           case.failure(_):
                               
                                                                 print(response.description)
                                                                                  AppUtility.hideProgress()
                                                          print("fail")
                                                          break
                                                      }
                                              }
                                          }
  func CheckUserStatusAPIcall(parameter:[String:AnyObject],completion:@escaping (_ success : Bool, _ result : UserStatusCheckRootClass) -> Void){
                   
                              
                   //AppUtility.showProgress()
                 let user:LoginData = HELPER.getSession()
                                   let usertokan = user.token
                                   let header : HTTPHeaders  = [
                                     "Accept-Language"    :  HELPER.getAppLanguageWithCapital(),
                                     "token" : usertokan!
                                     ]
                 
                 AF.request(GlobalURL.CHECKUSERSTATUS,method:.post,parameters:parameter,encoding: URLEncoding.default, headers:header).responseJSON
                     {
                       response in switch response.result {
                          case .success(let value):

                                                        // AppUtility.hideProgress()
                                                      let json = JSON(value)
                                                      print(json)

                                                      let objRootClass = UserStatusCheckRootClass(fromJson: json)
                                                      if(objRootClass.error == 200){

                                                           completion(true,objRootClass)
                                                      }
                                                      else  {
                                                          completion(false,objRootClass)
                                                      }

                       case.failure(_):
                           
                                                             print(response.description)
                                                                             // AppUtility.hideProgress()
                                                      print("fail")
                                                      break
                                                  }
                                          }
                                      }
    
    
    func UpdatePostAPIcall(parameter:[String:AnyObject],completion:@escaping (_ success : Bool, _ result : UpdatePostRootClass) -> Void){
                     
                                
                     AppUtility.showProgress()
                   let user:LoginData = HELPER.getSession()
                                     let usertokan = user.token
                                     let header : HTTPHeaders  = [
                                       "Accept-Language"    :  HELPER.getAppLanguageWithCapital(),
                                       "token" : usertokan!
                                       ]
                   
                   AF.request(GlobalURL.UPDATEPOST,method:.post,parameters:parameter,encoding: URLEncoding.default, headers:header).responseJSON
                       {
                         response in switch response.result {
                            case .success(let value):

                                        AppUtility.hideProgress()
                                        let json = JSON(value)
                                        print(json)
                                        let objRootClass = UpdatePostRootClass(fromJson: json)
                                        if(objRootClass.error == "200"){
                                                    completion(true,objRootClass)
                                        }else{
                                                    completion(false,objRootClass)
                                        }

                            case.failure(_):
                             
                                        print(response.description)
                                        AppUtility.hideProgress()
                                        print("fail")
                                        break
                        }
                    }
                }
    func UpdateUserPostImageAPIcall(Type :String ,Content :String,Categoriyid :Int,Language :String,PostId :String,userPostimage: Data,completion:@escaping (_ success : Bool, _ result : UpdatePostRootClass?) -> Void){
                 
           let user:LoginData = HELPER.getSession()
                        
                                                         let usertokan = user.token
                                                          let header : HTTPHeaders  = [
                                                             "Accept-Language"    :  HELPER.getAppLanguageWithCapital(),
                                                             "token" : usertokan!
                                                             ]
                 
                   AppUtility.showProgress()
           
           let categorystring = String(Categoriyid)
                 AF.upload(multipartFormData: { (multipartFormData) in
                     multipartFormData.append(Type.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!, withName: "type")
                     multipartFormData.append(Content.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!, withName: "content")
                     multipartFormData.append(categorystring.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!, withName: "forum_id")
                     multipartFormData.append(Language.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!, withName: "language")
                     multipartFormData.append(PostId.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!, withName: "post_id")
                     print(multipartFormData)
                     
                         multipartFormData.append(userPostimage, withName: "media_file", fileName: "userPost.jpg" , mimeType: "image/jpg")
          
                     
                },to:GlobalURL.UPDATEPOST,method:.post,headers:header) .responseJSON{ response in

            
                     
                    switch response.result {
                          case .success(let value):
                         
                      
                             print("response  \(response)")
                             
                              //SVProgressHUD.dismiss()
                             AppUtility.hideProgress()
                             if (response.value != nil) {
                                     //let statusCode = response.response?.statusCode
                                 let json = JSON(value)
                                 let objRootClass = UpdatePostRootClass(fromJson: json)
                                 if (objRootClass.error == "200"){
                                 
                                     //HELPER.sharedInstance.globalAlert(message: objRootClass.message)
                                     completion(true,objRootClass)
                                 }else{
                                      HELPER.sharedInstance.globalAlert(message: objRootClass.message)
                                     completion(false,objRootClass)
                                 }
                                 
                             }else{
                                 completion(false,nil)
                                 HELPER.sharedInstance.globalAlert(message: "\(response.description)")

                             }
                             
                         
                     case .failure(let encodingError):
                          //SVProgressHUD.dismiss()
                         completion(false,nil)
                         HELPER.sharedInstance.globalAlert(message: GLocalizedString(key: "ServerNotResponding"))
                     }
                 }
             }
    func UpdateUserPostvideoAPIcall(Type :String ,Content :String,Categoriyid :Int,Language :String,userPostVideo: String,PostId:String,completion:@escaping (_ success : Bool, _ result : UpdatePostRootClass?) -> Void){
           
     let user:LoginData = HELPER.getSession()
                  
                                                   let usertokan = user.token
                                                    let header : HTTPHeaders  = [
                                                       "Accept-Language"    :  HELPER.getAppLanguageWithCapital(),
                                                       "token" : usertokan!
                                                       ]
           
             AppUtility.showProgress()
        
     let categorystring = String(Categoriyid)
           AF.upload(multipartFormData: { (multipartFormData) in
               multipartFormData.append(Type.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!, withName: "type")
               multipartFormData.append(Content.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!, withName: "content")
               multipartFormData.append(categorystring.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!, withName: "forum_id")
               multipartFormData.append(Language.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!, withName: "language")
                 multipartFormData.append(PostId.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!, withName: "post_id")
               print(multipartFormData)
            
            if userPostVideo != "nil"{
                
            let finalurl = URL(string: userPostVideo)!
                
                multipartFormData.append(finalurl, withName: "media_file", fileName: "video.mp4", mimeType: "video/mp4")
            }
                

           

                   //multipartFormData.append(userPostimage, withName: "media_file", fileName: "userPost.jpg" , mimeType: "image/jpg")
    
               
               },to:GlobalURL.UPDATEPOST,method:.post,headers:header) .responseJSON{ response in
               
               switch response.result {
                     case .success(let value):
             
                       print("response  \(response)")
                       
                        //SVProgressHUD.dismiss()
                       AppUtility.hideProgress()
                       if (response.value != nil) {
                               //let statusCode = response.response?.statusCode
                           let json = JSON(value)
                           let objRootClass = UpdatePostRootClass(fromJson: json)
                           if (objRootClass.error == "200"){
                           
                               //HELPER.sharedInstance.globalAlert(message: objRootClass.message)
                               completion(true,objRootClass)
                           }else{
                                HELPER.sharedInstance.globalAlert(message: objRootClass.message)
                               completion(false,objRootClass)
                           }
                           
                       }else{
                           completion(false,nil)
                           HELPER.sharedInstance.globalAlert(message: "\(response.description)")

                       }
                       
                   
               case .failure(let encodingError):
                    //SVProgressHUD.dismiss()
                AppUtility.hideProgress()
                   completion(false,nil)
                   HELPER.sharedInstance.globalAlert(message: GLocalizedString(key: "ServerNotResponding"))
               }
           }
       }
    
    
    //MARK:Get Report spam List API
                 
                 func GetReportSpamListAPIcall(parameter:[String:AnyObject],completion:@escaping (_ success : Bool, _ result : ReportSpamListRootClass) -> Void){

                  
                        AppUtility.showProgress()
                     AF.request(GlobalURL.GETREPORTSPAM,method:.get,parameters:parameter,encoding: URLEncoding.default, headers: nil).responseJSON
                         {
                             response in switch response.result {
                             case .success(let value):

                                             AppUtility.hideProgress()
                                 let json = JSON(value)
                                 print(json)

                                 let objRootClass = ReportSpamListRootClass(fromJson: json)
                                 if(objRootClass.error == 200){

                                      completion(true,objRootClass)
                                 }
                                 else  {
                                       HELPER.sharedInstance.globalAlert(message: "\(objRootClass.message!)")
                                     completion(false,objRootClass)
                                 }

                            case.failure(_):
                                
                                             
                                AppUtility.hideProgress()
                                print(response.description)
                                print("fail")
                                 break
                             }
                     }
                 }
    

}


