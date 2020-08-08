//
//  SideMenuVC.swift
//  IADVL
//
//  Created by Glasier Inc on 09/07/18.
//  Copyright © 2018 Glasier Inc. All rights reserved.
//

import UIKit
import SDWebImage
import CDAlertView
class SideMenuVC: UIViewController {

    //----------------------------------------------
    //MARK: - IBOutlets
    
    @IBOutlet weak var menuTbl: UITableView!
   

    @IBOutlet weak var MenuOrganizationImageview: UIImageView!
    @IBOutlet weak var MenuOrganizationNameLable: UILabel!
    @IBOutlet weak var UserProfileButton: UIButton!
    
    //----------------------------------------------
    //MARK: - Class Variable
   
//    var arrayTitles : [String] = ["Wall Post","News","Events","Directory","Blog","University","Greivence Cell","Testimonial","Logout","v\((Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String)!)"]
    
    var arrImg = ["Homeicon","categoriesicon","forumicon","Mymessage","createmsgicon","notificationicon","myprofileicon","logouticon"]
    
//    var arrayTitles = ["Home","Categories","Forums","Create a message","My Messages","Notification","My Profile","Logout"]
    var arrayTitles = ["menu_Home","menu_Categories","menu_Forums","menu_CreateMessage","menu_MyMessages","menu_Notification","menu_MyProfile","menu_Logout"]
    //----------------------------------------------
    //MARK: - Custom Methods
    
    func setUpView(){
        
        
        // let user:LoginData = HELPER.getSession()
        
       
        if let urlt =  UserDefaults.standard.string(forKey: GlobalDefaultsKey.KUserMainImage)
                                {
                                    if (urlt != ""){
                                        let urlf = URL(string: urlt)!
                                        // let image2 = UIImageView()
                                        MenuOrganizationImageview.sd_setImage(with: urlf, placeholderImage:UIImage(named: "GirlVentLogo"), options: .delayPlaceholder, completed: { (image, error, cacheType, imageURL) in
                                        })
                                    }
                                }
        MenuOrganizationNameLable.text = UserDefaults.standard.string(forKey: GlobalDefaultsKey.KUserMainName)
        
        menuTbl.delegate = self
        menuTbl.dataSource = self
    }
    
    func showLogoutAlert(){
        
        
                let alert = CDAlertView(title: "", message: GLocalizedString(key: "LogoutConfirmation"), type: .warning)
                let doneAction = CDAlertViewAction(title: GLocalizedString(key: "OK"), font: nil, textColor: UIColor.black, backgroundColor: UIColor.white) { (doneAction) -> Bool in
                    
                        UserDefaults.standard.removeObject(forKey: USER_LOGIN)
                    UserDefaults.standard.removeObject(forKey: GlobalDefaultsKey.KUserMainName)
                     UserDefaults.standard.removeObject(forKey: GlobalDefaultsKey.KUserMainImage)
                    UserDefaults.standard.removeObject(forKey: "GLanguage")
                    UserDefaults.standard.synchronize()
                    
                    let userdata = UserDefaults(suiteName: "group.com.Glasierinc.Girlventdemo")
                    userdata?.removeObject(forKey: USER_LOGIN)
                    userdata?.synchronize()
                    
                      let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                    let therapiescall = storyBoard.instantiateViewController(withIdentifier: "LoginVcPuch") as! LoginVc
                                    self.navigationController?.pushViewController(therapiescall, animated: true)
                 
                        return true
                        }
            
        let doneActionssd = CDAlertViewAction(title: GLocalizedString(key: "Cancel"), font: nil, textColor: UIColor.black, backgroundColor: UIColor.white) { (doneAction) -> Bool in
                          
                        
                              return true
                              }
        
                alert.add(action: doneAction)
                alert.add(action: doneActionssd)
                alert.circleFillColor = ALERT_COLOR
                alert.show()
        
        
//        let alert = UIAlertController(title: "", message: "Are you sure want to logout?", preferredStyle: UIAlertController.Style.alert)
//
//
//
//        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
//
//         UserDefaults.standard.removeObject(forKey: USER_LOGIN)
//                 let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//                               let therapiescall = storyBoard.instantiateViewController(withIdentifier: "LoginVcPuch") as! LoginVc
//                               self.navigationController?.pushViewController(therapiescall, animated: true)
//
//            //self.LogoutAPIcell()
//
//
//        }))
//        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:nil
//           ))
//        self.present(alert, animated: true, completion: nil)
    }
    
    //----------------------------------------------
    //MARK: - Action Methods
    
  
    //----------------------------------------------
    //MARK: - Life Cycle Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpView()
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        MenuOrganizationImageview.clipsToBounds = true
        MenuOrganizationImageview.layer.cornerRadius = MenuOrganizationImageview.frame.width / 2
        
     
        
    
//        
//        VersionLAble.text = "v\((Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String)!)"
    }
    @IBAction func UserProfileButtonclick(_ sender: Any) {
        
               let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
              let therapiescall = storyBoard.instantiateViewController(withIdentifier: "EditProfileVc") as! EditProfileVc
              self.navigationController?.pushViewController(therapiescall, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
//    //MARK:- == FUNCTION FOR Logout  API ==
//    func LogoutAPIcell(){
//
//        startAnimating(CGSize(width: 100, height: 100), message: "")
//        let param = ["iUserId":HELPER.getUserId()] as [String : AnyObject]
//
//        print(param)
//
//        APIHelper.shared.LogoutAPI(parameter: param, completion:{ (success, result) in
//
//            self.stopAnimating()
//            if(success){
//
//
//                userdefault.set(false, forKey: LoginStatus)
//
//                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//                let destination = storyBoard.instantiateViewController(withIdentifier: "MFDANumberVerfyVCpuch") as! MFDANumberVerfyVC
//
//                self.navigationController?.pushViewController(destination, animated: true)
//
//
//
//            }else{
//
//
//            }
//
//        })
//
//    }
//
    
}

extension SideMenuVC : UITableViewDelegate , UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        
       
        return arrayTitles.count
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
      //  return 60
    
     return UITableView.automaticDimension
    }
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "sideMenuTableCell") as! SideMenuTableViewCell
        cell.selectionStyle = .none
      
     
           
             cell.menuImageviewlist.isHidden = false
            cell.menuImageviewlist.image = UIImage(named: arrImg[indexPath.row])
            cell.menutitle.text = GLocalizedString(key: arrayTitles[indexPath.row]) //arrayTitles[indexPath.row]
            
        
      
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
        
        if indexPath.row == 0{
            
             let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
             let therapiescall = storyBoard.instantiateViewController(withIdentifier: "HomeViewVCpuch") as! HomeViewVC
            self.navigationController?.pushViewController(therapiescall, animated: true)
        }
        if indexPath.row == 1{
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                 let therapiescall = storyBoard.instantiateViewController(withIdentifier: "CategoriesListVcpuch") as! CategoriesListVc
                self.navigationController?.pushViewController(therapiescall, animated: true)
        }
        if indexPath.row == 2{
                  
                  let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                       let therapiescall = storyBoard.instantiateViewController(withIdentifier: "ForumsListVc") as! ForumsListVc
                      self.navigationController?.pushViewController(therapiescall, animated: true)
              }
        
        if indexPath.row == 3{
                 
                 let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                       let therapiescall = storyBoard.instantiateViewController(withIdentifier: "WriteaMessageVc") as! WriteaMessageVc
                      self.navigationController?.pushViewController(therapiescall, animated: true)
                 
             }
        if indexPath.row == 4{
                
                     let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                         let therapiescall = storyBoard.instantiateViewController(withIdentifier: "MyMessagesVc") as! MyMessagesVc
            therapiescall.wheretoconform = "1"
                                         self.navigationController?.pushViewController(therapiescall, animated: true)
                
            }
        
        if indexPath.row == 6{
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                  let therapiescall = storyBoard.instantiateViewController(withIdentifier: "MyProfileHomeVCpuch") as! MyProfileHomeVC
            therapiescall.otheruser = "0"
                 self.navigationController?.pushViewController(therapiescall, animated: true)
            
        }
        if indexPath.row == 7{
            
            showLogoutAlert()
        }
        
    }
  
    
}


