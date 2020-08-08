//
//  MyImagesVC.swift
//  Girlvent
//
//  Created by Glasier Inc. on 09/01/20.
//  Copyright © 2020 Glasier Inc. All rights reserved.
//

import UIKit
import UITextField_Shake
import CDAlertView
class MyImagesVC: UIViewController {

    
    var MyimagesListarray = [UserMyImagesListPostDetail]()
    
    
        @IBOutlet weak var UserMyimagepostlistTable: UICollectionView!
       @IBOutlet weak var MyimageMenuButton: UIButton!
       @IBOutlet weak var MyimageBackButton: UIButton!
       @IBOutlet weak var UserProfilePicImageview: UIImageView!
       @IBOutlet weak var UserNameLable: UILabel!
       @IBOutlet weak var UserbioTextview: UITextView!
    @IBOutlet weak var MyProfileImageButton: UIButton!

    @IBOutlet var lblTitle: UILabel!
    
    
    @IBOutlet weak var imagePostZoomView: UIView!

        @IBOutlet weak var imagePostZoomImageView: UIImageView!
        @IBOutlet weak var imagepostZoomimagescrolView: UIScrollView!
                var offset = 0
       @IBOutlet weak var ImageZoomCamcelButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lblTitle.text = GLocalizedString(key: "pm_MyImages")
        
              // Do any additional setup after loading the view.
        
        
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
        
    }
    @IBAction func MyProfileImageButtonClick(_ sender: Any) {
        
        imagePostZoomView.isHidden = false
        
        
        
        self.imagePostZoomImageView.image = self.UserProfilePicImageview.image
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
    //MARK:- ======================  Recevie Notification Method  ==========================
         // Take Action on Notification
      @objc func MyPostVcComeChange(notification: Notification) {
        
              setAlphaOfBackgroundViews(alpha: 1)
              self.dismiss(animated: true, completion: nil)

          
       
      }
    override func viewWillAppear(_ animated: Bool) {
          
          super.viewWillAppear(true)
               setAlphaOfBackgroundViews(alpha: 1)
               GetMyimagesListAPICall()
      }
    @IBAction func MyimageBackButtonClick(_ sender: Any) {
        
             let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                   let therapiescall = storyBoard.instantiateViewController(withIdentifier: "MyProfileHomeVCpuch") as! MyProfileHomeVC
                  self.navigationController?.pushViewController(therapiescall, animated: true)
    }
    @IBAction func MyimageMenuButtonClick(_ sender: Any) {
        
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
            ppc!.sourceView = MyimageMenuButton
            ppc?.sourceRect = MyimageMenuButton.bounds
            
            present(vc, animated: true, completion: nil)
       //  NotificationCenter.default.post(name: NSNotification.Name(rawValue: "myvideostop"), object: nil)
        
        
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
                                                                                                                                              self.GetMyimagesListAPICall()
                                                                                                                                                return true
                                                                                                                                            }
                                                                                                                                            alert.add(action: doneAction)
                                                                                                                                            alert.circleFillColor = ALERT_COLOR
                                                                                                                                            alert.show()
                            }
                           
                           
                         
                       
                    
                 }
                 
             }
    //MARK:- == FUNCTION FOR Home Post get API ==
      func GetMyimagesListAPICall(){
          //let TokenId = UserDefaults.value(forKey: "TokenId") as! String
          
          
          let param = [
              "language":"english"
              ] as [String : AnyObject]
          
          print(param)
          
          APIHelper.shared.GetUserMyimagesListAPIcall(parameter: param) { (success, result) in
              
            if(result.data != nil){
                  if(success){
             
                    self.MyimagesListarray = result.data.postDetail
                    
                    if self.MyimagesListarray.count == 0{
                                                            let alert = CDAlertView(title: nil, message:GLocalizedString(key: "mi_NoImageFound"), type: .error)
                                                                                    let doneAction = CDAlertViewAction(title: GLocalizedString(key: "OK"), font: nil, textColor: UIColor.black, backgroundColor: UIColor.white) { (doneAction) -> Bool in
                                                                                     
                                                                                        return true
                                                                                    }
                                                                                    alert.add(action: doneAction)
                                                                                    alert.circleFillColor = ALERT_COLOR
                                                                                    alert.show()
                                                        }else{
                                                        }
                    
                    
                    print(result.data.postDetail!)
                    self.UserNameLable.text = result.data.userInfo.username
                    self.UserbioTextview.text = result.data.userInfo.bio
                      if let urlt = result.data.userInfo.profileUrl
                                    {
                                        if (urlt != ""){
                                            let urlf = URL(string: urlt)!
                                            // let image2 = UIImageView()
                                            self.UserProfilePicImageview.sd_setImage(with: urlf, placeholderImage:UIImage(named: "GirlVentLogo"), options: .delayPlaceholder, completed: { (image, error, cacheType, imageURL) in
                                            })
                                        }
                                    }
                      self.UserMyimagepostlistTable.reloadData()
                  }
              } else{
                  
                self.MyimagesListarray.removeAll()
                 self.UserMyimagepostlistTable.reloadData()
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
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
     //        if (dropper.isHidden == false) { // Checks if Dropper is visible
     //            dropper.hideWithAnimation(0.1) // Hides Dropper
     //        }
         }
         
         
         func viewForZooming(in scrollView: UIScrollView) -> UIView? {
             return imagePostZoomImageView
         }
}
extension MyImagesVC:UICollectionViewDelegate,UICollectionViewDataSource,MyImageclCellDelegate {
    
    
    func imagepostZoomButtonTapped(at index: IndexPath) {
         imagePostZoomView.isHidden = false
        
        if let urlt = self.MyimagesListarray[index.row].media
                                              {
                                                  if (urlt != ""){
                                                      let urlf = URL(string: urlt)!
                                                      // let image2 = UIImageView()
                                                      self.imagePostZoomImageView.sd_setImage(with: urlf, placeholderImage:UIImage(named: "GirlVentLogo"), options: .delayPlaceholder, completed: { (image, error, cacheType, imageURL) in
                                                      })
                                                  }
                                              }
     }
    
    
    func PostDeleteTapped(at index: IndexPath) {
        
        let alert = CDAlertView(title: GLocalizedString(key: "Confirmation"), message: GLocalizedString(key: "mi_ImageDeleteConfirmation"), type: .warning)
                let doneAction = CDAlertViewAction(title: GLocalizedString(key: "OK"), font: nil, textColor: UIColor.black, backgroundColor: UIColor.white) { (doneAction) -> Bool in
                    self.DeletePostAPICall(postids: self.MyimagesListarray[index.row].postId)
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
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.MyimagesListarray.count
    }

    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyImageclCellpuch", for: indexPath as IndexPath) as! MyImageclCell

     cell.Mypostimagesdata = self.MyimagesListarray[indexPath.row]
     cell.delegate = self
     cell.indexPath = indexPath
        
        return cell
    }

    // MARK: - UICollectionViewDelegate protocol

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
    }
}
extension MyImagesVC : UIPopoverPresentationControllerDelegate{
    
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
extension MyImagesVC : MyProfileMenuOptionCellDelegate{
    
    
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
