//
//  MyMessageCell.swift
//  Girlvent
//
//  Created by Glasier Inc. on 29/01/20.
//  Copyright © 2020 Glasier Inc. All rights reserved.
//

import UIKit


protocol MyMessageCellDelegate{
        func MassgePostDeleteTapped(at index:IndexPath)
}
class MyMessageCell: UITableViewCell {

    @IBOutlet weak var MeassgeUserProfilePic: UIImageView!
    @IBOutlet weak var MessgeUserNameLable: UILabel!
    @IBOutlet weak var MessgeDeleteBtn: UIButton!
    @IBOutlet weak var TextMessgeTextView: UITextView!
    @IBOutlet weak var DownloadBtn: UIButton!
  @IBOutlet weak var previewMeassgedownload: UIImageView!
    @IBOutlet weak var DownloadView: UIView!
    var MaediURL = ""
    var delegate:MyMessageCellDelegate!
          
               var indexPath:IndexPath!
  
    
    
    
    @IBOutlet weak var DownlodViewHeight: NSLayoutConstraint!
    
    @IBOutlet var lblDownloadAttachment: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lblDownloadAttachment.text = GLocalizedString(key: "mymessage_DownloadAttachment")
          self.layoutIfNeeded()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var MyMessagedata : GetMyMessageListMyMessage! {
    
        didSet{
            
            
            if let urlt = MyMessagedata.profileUrl
                {
                    if (urlt != ""){
                        let urlf = URL(string: urlt)!

                        self.MeassgeUserProfilePic.sd_setImage(with: urlf, placeholderImage:UIImage(named: "GirlVentLogo"), options: .delayPlaceholder, completed: { (image, error, cacheType, imageURL) in
                        })
                                                                                 
                    }
            }
            MessgeUserNameLable.text = MyMessagedata.username
            TextMessgeTextView.text =  MyMessagedata.message
            if MyMessagedata.media == ""{
                
                DownlodViewHeight.constant = 0
                DownloadView.isHidden = true
                
            }else{
          
                if let urlt = MyMessagedata.thumbnail
                              {
                                  if (urlt != ""){
                                      let urlf = URL(string: urlt)!

                                      self.previewMeassgedownload.sd_setImage(with: urlf, placeholderImage:UIImage(named: "GirlVentLogo"), options: .delayPlaceholder, completed: { (image, error, cacheType, imageURL) in
                                      })
                                                                                               
                                  }
                          }
                
               DownlodViewHeight.constant = 80
                DownloadView.isHidden = false
            }
            
            MaediURL = MyMessagedata.media
        
        }
        
        
    }
   
    
    
    @IBAction func DownloadBtnClick(_ sender: Any) {
        
        guard let url = URL(string: MaediURL) else { return }
        UIApplication.shared.open(url)
    }
    @IBAction func MessgeDeleteBtnClick(_ sender: Any) {
            self.delegate?.MassgePostDeleteTapped(at: indexPath)
    }
}
