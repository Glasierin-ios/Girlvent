//
//  SideMenuTableViewCell.swift
//  IADVL
//
//  Created by Glasier Inc on 09/07/18.
//  Copyright © 2018 Glasier Inc. All rights reserved.
//

import UIKit

class SideMenuTableViewCell: UITableViewCell {
    
    @IBOutlet weak var menutitle : UILabel!
    @IBOutlet weak var menuImageviewlist  : UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
