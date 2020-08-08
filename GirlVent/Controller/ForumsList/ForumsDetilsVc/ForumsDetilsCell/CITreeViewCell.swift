//
//  CITreeViewCell.swift
//  CITreeView
//
//  Created by Apple on 24.01.2018.
//  Copyright © 2018 Cenk Işık. All rights reserved.
//

import UIKit
protocol ForumDetilsCellDelegate{
    func FourmDetilsMoreTapped(at index:IndexPath ,fourm_Post_id: Int,prent_id :Int,Conten : String,Fourm_tokan:String)
    
}

class CITreeViewCell: UITableViewCell {
    
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var imagewidhtConstraint: NSLayoutConstraint!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    var delegate:ForumDetilsCellDelegate!
                
                     var indexPath:IndexPath!
       
       
    
    let leadingValueForChildrenCell:CGFloat = 30
    var formPrentId = 0
    var formposttId = 0
    var Conenstring = ""
    
    
    var Fourn_user_tokan = ""
    
    var ForumDetilsedataArray : ForumDetilsData!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    @IBAction func MoreOptionBtnClick(_ sender: Any) {
        
    
       
        self.delegate?.FourmDetilsMoreTapped(at: indexPath, fourm_Post_id: ForumDetilsedataArray.forumPostId, prent_id: ForumDetilsedataArray.parentId,Conten: ForumDetilsedataArray.content,Fourm_tokan:ForumDetilsedataArray.token )
    
    
    }
    func setupCell(level:Int)
    {
       
       // self.avatarImageView.layer.cornerRadius = self.avatarImageView.frame.size.height / 2
        switch level {
        case 0:
            self.leadingConstraint.constant = 0
            imagewidhtConstraint.constant = 0
            self.avatarImageView.image = UIImage(named: "")
        case 1:
            self.leadingConstraint.constant = leadingValueForChildrenCell * CGFloat(level )
            imagewidhtConstraint.constant = 40
            self.avatarImageView.image = UIImage(named: "RightArrow")
        case 2:
            self.leadingConstraint.constant = leadingValueForChildrenCell * CGFloat(level )
            imagewidhtConstraint.constant = 40
            self.avatarImageView.image = UIImage(named: "RightArrow")
        default:
            self.leadingConstraint.constant = leadingValueForChildrenCell * CGFloat(level + 1)
            imagewidhtConstraint.constant = 40
            self.avatarImageView.image = UIImage(named: "RightArrow")
        }
        
        self.layoutIfNeeded()
    }

var ForumDetilsedata : ForumDetilsData! {
        
            didSet{
    
//                formPrentId = ForumDetilsedata.parentId
//                formposttId = ForumDetilsedata.forumPostId
//                Conenstring = ForumDetilsedata!.content
//                Fourn_user_tokan = ForumDetilsedata!.token
                    let text = "\(ForumDetilsedata.username ?? "") \n(" + "\(ForumDetilsedata!.postTime ?? "")" + ") \n " + "\(ForumDetilsedata!.content ?? "")" + "\n"
    
                                     self.nameLabel.textColor =  UIColor.darkGray
                                           nameLabel.text = text
    
    
                                                            let underlineAttriString = NSMutableAttributedString(string: text)
                                                            let range1 = (text as NSString).range(of: "\(ForumDetilsedata!.username ?? "")")
                                                            underlineAttriString.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 15.0), range: range1)
    
                                                            underlineAttriString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(red: 224.0/255.0, green: 60.0/255.0, blue: 113.0/255.0, alpha: 1.0), range: range1)
    
    
                                                            let range2 = (text as NSString).range(of: "(\(ForumDetilsedata!.postTime ?? ""))")
                                                            underlineAttriString.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 10.0), range: range2)
                                                            nameLabel.attributedText = underlineAttriString
            }
            
            
        }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
