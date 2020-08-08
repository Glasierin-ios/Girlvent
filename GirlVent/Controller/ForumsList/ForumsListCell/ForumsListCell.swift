//
//  ForumsListCell.swift
//  Girlvent
//
//  Created by Glasier Inc. on 30/01/20.
//  Copyright © 2020 Glasier Inc. All rights reserved.
//

import UIKit

class ForumsListCell: UITableViewCell {

    @IBOutlet weak var ForumTitleLable: UILabel!
   
    @IBOutlet weak var ForumUserNameLAble: UILabel!
    @IBOutlet weak var RepliesLable: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var ForumTitledata : ForumListData! {
    
        didSet{
            ForumTitleLable.text = ForumTitledata.title
            let text = "\(ForumTitledata.username ?? "") (" + "\(ForumTitledata!.postTime ?? "")" + ")"
                      
                      self.ForumUserNameLAble.textColor =  UIColor.black
                                           ForumUserNameLAble.text = text
                                           let underlineAttriString = NSMutableAttributedString(string: text)
                                           let range1 = (text as NSString).range(of: "\(ForumTitledata!.username ?? "")")
                                           underlineAttriString.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 15.0), range: range1)
                                           
                                           underlineAttriString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(red: 224.0/255.0, green: 60.0/255.0, blue: 113.0/255.0, alpha: 1.0), range: range1)
                                           ForumUserNameLAble.attributedText = underlineAttriString
            
            RepliesLable.text = String(ForumTitledata.replyCount)
        
        }
        
        
    }
}
