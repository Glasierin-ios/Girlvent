//
//  ForumDetilsCell.swift
//  Girlvent
//
//  Created by Glasier Inc. on 30/01/20.
//  Copyright © 2020 Glasier Inc. All rights reserved.
//

import UIKit


class ForumDetilsCell: UITableViewCell {

    @IBOutlet weak var MsgDetilsLable: UILabel!
    @IBOutlet weak var MoreOptionBtn: UIButton!
    
   // var delegate:ForumDetilsCellDelegate!
             
           //       var indexPath:IndexPath!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
//    @IBAction func MoreOptionBtnClick(_ sender: Any) {
//         self.delegate?.FourmDetilsMoreTapped(at: indexPath)
//    }
   

}
