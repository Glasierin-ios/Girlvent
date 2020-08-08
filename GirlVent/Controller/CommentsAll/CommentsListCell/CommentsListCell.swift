//
//  CommentsListCell.swift
//  Girlvent
//
//  Created by Glasier Inc. on 06/01/20.
//  Copyright © 2020 Glasier Inc. All rights reserved.
//

import UIKit
protocol CommentsListCellDelegate{
  
    func UserprofileButtonTapped(at index:IndexPath)
    func optionBtnapped(at index:IndexPath,optionButton: UIButton,tablecell : UITableViewCell)
}
class CommentsListCell: UITableViewCell {

    var delegate:CommentsListCellDelegate!
     
          var indexPath:IndexPath!
    
    
    
    @IBOutlet weak var UserProfilepicImageView: UIImageView!
    @IBOutlet weak var UserMoreOptionButton: UIButton!
    @IBOutlet weak var UserMsgNameLable: UILabel!
 //   @IBOutlet weak var UserTimeLable: UILabel!
    @IBOutlet weak var UserProfilepicButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
     self.layoutIfNeeded()
        
    }
    var CommentData : GetCommentListData! {
       
           didSet{
            
            
        
            let user:LoginData = HELPER.getSession()
                  
                  print(user.token!)
                
                              
                  if user.token == CommentData.token{
                          
                    UserMoreOptionButton.isHidden = false
                    
                  }else{
                    
                    UserMoreOptionButton.isHidden = true
                }
            
            //  self.UsernameLable.text = "\(Homepostdata!.firstname ?? "") \(Homepostdata!.lastname ?? "") posted"
                      
                         let text = CommentData.username + " " + CommentData.comment + "\n" + CommentData.postTime
                      
            self.UserMsgNameLable.textColor =  UIColor.black
                                           UserMsgNameLable.text = text
                                           let underlineAttriString = NSMutableAttributedString(string: text)
                                           let range1 = (text as NSString).range(of: "\(CommentData!.username ?? "")")
                                          
                                                  // underlineAttriString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range1)
                                           underlineAttriString.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 15.0), range: range1)
                      underlineAttriString.addAttribute(NSAttributedString.Key.foregroundColor, value:  UIColor(red: 224.0/255.0, green: 60.0/255.0, blue: 113.0/255.0, alpha: 1.0), range: range1)
                                           
                                      let range2 = (text as NSString).range(of: "\(CommentData.postTime ?? "")")
                                                          
                                                                  // underlineAttriString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range1)
                                                           underlineAttriString.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 14.0), range: range2)
            underlineAttriString.addAttribute(NSAttributedString.Key.foregroundColor, value:  UIColor.lightGray, range: range2)
            
            
                                           
                                           UserMsgNameLable.attributedText = underlineAttriString
                                           UserMsgNameLable.isUserInteractionEnabled = true
                                           UserMsgNameLable.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(tapLabel(gesture:))))
                      
            
            
            
            UserMsgNameLable.sizeToFit()
        //    UserTimeLable.text = CommentData.postTime
            
            if let urlt = CommentData!.profileUrl
                         {
                             if (urlt != ""){
                                 let urlf = URL(string: urlt)!
                                 // let image2 = UIImageView()
                                 self.UserProfilepicImageView.sd_setImage(with: urlf, placeholderImage:UIImage(named: "GirlVentLogo"), options: .delayPlaceholder, completed: { (image, error, cacheType, imageURL) in
                                 })
                             }
                         }
        
        }
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func UserMoreOptionButtonClick(_ sender: Any) {
             self.delegate?.optionBtnapped(at: indexPath,optionButton: sender as! UIButton,tablecell:self)
        
    }
    @IBAction func UserProfilepicButtonClick(_ sender: Any) {
        
         self.delegate?.UserprofileButtonTapped(at: indexPath)
        
    }
     @IBAction func tapLabel(gesture: UITapGestureRecognizer) {
         
      //   let usernameRange = (UsernameLable.text!).range(of: "\(Homepostdata!.firstname ?? "") \(Homepostdata!.lastname ?? "")")
         
            let text = UserMsgNameLable.text!
            let checktext = "\(CommentData!.username ?? "")"
            let termsRange = (text as NSString).range(of: checktext)
        
            if gesture.didTapAttributedTextInLabel(label: UserMsgNameLable, inRange: termsRange) {
                    print("Tapped none name")
                     self.delegate?.UserprofileButtonTapped(at: indexPath)
            }else{
         
                    print("Tapped none ")
         }
     }
}
