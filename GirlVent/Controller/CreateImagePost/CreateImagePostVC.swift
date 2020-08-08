//
//  CreateImagePostVC.swift
//  Girlvent
//
//  Created by Glasier Inc. on 02/01/20.
//  Copyright © 2020 Glasier Inc. All rights reserved.
//

import UIKit
import UITextField_Shake
import CDAlertView

class CreateImagePostVC: UIViewController,UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    //MARK:- Outlets
    @IBOutlet weak var ImagePostCancelButton: UIButton!
    @IBOutlet weak var ImageCatagoryListButton: UIButton!
    @IBOutlet weak var ImageTextTextView: UITextView!
    @IBOutlet weak var SelectimageButton: UIButton!
    @IBOutlet weak var SelectimahePathLable: UILabel!
    @IBOutlet weak var ImagePostButton: UIButton!
 //    @IBOutlet weak var ImageUrlView: UIView!
    @IBOutlet weak var SelectCategoriesTxt: UITextField!
    
    @IBOutlet var lblCreatePost: UILabel!
    
    
    
    //MARK:- Variables
     var profileimageview: UIImageView!
     var iscompanyimage = "0"
     var UIPicker = UIImagePickerController()
     let categoriesListPicker = UIPickerView()
     var selectedcategoriid = 0
     var  categoriesListArray = [GetCategoriesListData]()
     var textforEditString = ""
     var linkforEditStirng = ""
     var wheretoCome = 0
     var postidString = 0
    var isfromShare = Bool()
    
    //MARK:- ViewLifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblCreatePost.text = GLocalizedString(key: "CreatePost")
        ImageCatagoryListButton.setTitle(GLocalizedString(key: "NewsFeed"), for: .normal)
        SelectCategoriesTxt.text = GLocalizedString(key: "NewsFeed")
        
        
        ImagePostButton.setTitle(GLocalizedString(key: "Post"), for: .normal)
        
        if isfromShare == false
        {
            SelectimahePathLable.text = GLocalizedString(key: "cm_SelectImage")
            ImageTextTextView.placeholder = GLocalizedString(key: "PostTextView")
        }
        
        
        
         categoriesListPicker.setValue(ALERT_COLOR, forKeyPath: "textColor")
            profileimageview = UIImageView()
        UIPicker.delegate = self
        GetCategoriesListAPI()
        SelectCategoriesTxt.inputView = categoriesListPicker
                   categoriesListPicker.delegate = self
        //ImageUrlView.isHidden = true
        
        if wheretoCome == 0{
               
               
        }else{
            if (linkforEditStirng != ""){
                                         let urlf = URL(string: linkforEditStirng)!
                                         // let image2 = UIImageView()
                                         profileimageview.sd_setImage(with: urlf, placeholderImage:UIImage(named: "GirlVentLogo"), options: .delayPlaceholder, completed: { (image, error, cacheType, imageURL) in

                                            self.iscompanyimage = "1"
                                         })
                                     }
                                 
            
            
               ImageTextTextView.text = textforEditString
                     SelectimahePathLable.text = linkforEditStirng
           //  ImageUrlView.isHidden = false
           }
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func ImagePostCancelButtonClick(_ sender: Any) {
        
       let savedata =  UserDefaults.init(suiteName: "group.com.Glasierinc.Girlventdemo")
       savedata?.removeObject(forKey: "img")
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                         let therapiescall = storyBoard.instantiateViewController(withIdentifier: "HomeViewVCpuch") as! HomeViewVC
                         self.navigationController?.pushViewController(therapiescall, animated: true)
       // self.navigationController?.popViewController(animated: true)
    }
    
    //MARK:- == FUNCTION FOR Submit POST API ==
           func SubmitPostimageAPI(){
               //let TokenId = UserDefaults.value(forKey: "TokenId") as! String
               
               var companydata : Data!
                                    
                                    if iscompanyimage == "0"{
                                        
                                        companydata = Data()
                                        
                                    }else{
                                        companydata = profileimageview.image!.jpegData(compressionQuality: 0.3)!
                                        
                                    }
            
            
            
               
               APIHelper.shared.UserPostImageAPIcall(Type: "image", Content: ImageTextTextView.text!, Categoriyid: selectedcategoriid, Language: "english", userPostimage: companydata, completion:{ (success, response) in
                   
                   
                       if(success){
                           self.navigationController?.popViewController(animated: true)
//                        let alert = CDAlertView(title: "Congratulations", message: response!.message, type: .success)
//                                                                                   let doneAction = CDAlertViewAction(title: "Ok", font: nil, textColor: UIColor.black, backgroundColor: UIColor.white) { (doneAction) -> Bool in
//
//                                                                                   
//                                                                                       return true
//                                                                                   }
//                                                                                   alert.add(action: doneAction)
//                                                                                   alert.circleFillColor = ALERT_COLOR
//                                                                                   alert.show()
                     
                       }else{
                       
                    
                       print("Not Success")
                   }
               })
    }
    @IBAction func ImageCatagoryListButtonClick(_ sender: Any) {
    }
    @IBAction func SelectimageButtonClick(_ sender: Any) {
        changePhoto()
    }
    @IBAction func ImagePostButtonClick(_ sender: Any) {
        if wheretoCome == 0{
            if SelectimahePathLable.text == GLocalizedString(key: "cm_SelectImage"){
                let alert = CDAlertView(title: GLocalizedString(key: "GirlVent"), message: GLocalizedString(key: "SelectImage"), type: .error)
                let doneAction = CDAlertViewAction(title: GLocalizedString(key: "OK"), font: nil, textColor: UIColor.black, backgroundColor: UIColor.white) { (doneAction) -> Bool in

                    return true
                }
                alert.add(action: doneAction)
                alert.circleFillColor = ALERT_COLOR
                alert.show()
            }else{
                  SubmitPostimageAPI()
            }
                     
                  }else{
        UpdatePostimageAPI()
        }
      
    }
    //MARK:- == FUNCTION FOR Submit POST API ==
               func UpdatePostimageAPI(){
                   //let TokenId = UserDefaults.value(forKey: "TokenId") as! String
                   
                   var companydata : Data!
                                        
                                        if iscompanyimage == "0"{
                                            
                                            companydata = Data()
                                            
                                        }else{
                                            companydata = profileimageview.image!.jpegData(compressionQuality: 0.3)!
                                            
                                        }
                
                
                
                   
                APIHelper.shared.UpdateUserPostImageAPIcall(Type: "image", Content: ImageTextTextView.text!, Categoriyid: selectedcategoriid, Language: "english", PostId:String(postidString),userPostimage: companydata, completion:{ (success, response) in
                       
                       
                           if(success){
                               self.navigationController?.popViewController(animated: true)
    //                        let alert = CDAlertView(title: "Congratulations", message: response!.message, type: .success)
    //                                                                                   let doneAction = CDAlertViewAction(title: "Ok", font: nil, textColor: UIColor.black, backgroundColor: UIColor.white) { (doneAction) -> Bool in
    //
    //
    //                                                                                       return true
    //                                                                                   }
    //                                                                                   alert.add(action: doneAction)
    //                                                                                   alert.circleFillColor = ALERT_COLOR
    //                                                                                   alert.show()
                         
                           }else{
                           
                        
                           print("Not Success")
                       }
                   })
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
                                                                   self.ImageCatagoryListButton.setTitle(obj.name, for: .normal)
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
            
              if let url = info[UIImagePickerController.InfoKey.imageURL] as? URL {
                   SelectimahePathLable.text  = url.lastPathComponent
            
              }else{
                  
                  if (picker.sourceType == UIImagePickerController.SourceType.camera) {

                      let imgName = UUID().uuidString
                      let documentDirectory = NSTemporaryDirectory()
                      let localPath = documentDirectory.appending(imgName)

                      let data = chosenImage.jpegData(compressionQuality: 0.3)! as NSData
                      data.write(toFile: localPath, atomically: true)
                      let photoURL = URL.init(fileURLWithPath: localPath)
                      
                      SelectimahePathLable.text  = photoURL.lastPathComponent

                  }
              }
                 // ImageUrlView.isHidden = false
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
}
extension CreateImagePostVC : UIPickerViewDelegate, UIPickerViewDataSource{
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
