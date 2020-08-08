//
//  MyImageclCell.swift
//  Girlvent
//
//  Created by Glasier Inc. on 09/01/20.
//  Copyright © 2020 Glasier Inc. All rights reserved.
//

import UIKit
protocol MyImageclCellDelegate{
     func PostDeleteTapped(at index:IndexPath)
   func imagepostZoomButtonTapped(at index:IndexPath)
 }

class MyImageclCell: UICollectionViewCell {
 
    @IBOutlet weak var Postimageview: UIImageView!
    @IBOutlet weak var PostdeletButton: UIButton!
         @IBOutlet weak var ImagepostZoomButton: UIButton!
    var delegate:MyImageclCellDelegate!
      
           var indexPath:IndexPath!
    
    
    @IBAction func PostdeleteButtonClick(_ sender: Any) {
         self.delegate?.PostDeleteTapped(at: indexPath)
    }
    @IBAction func ImagePostZoommButtonClick(_ sender: Any) {
                self.delegate?.imagepostZoomButtonTapped(at: indexPath)
       }
    
    var Mypostimagesdata : UserMyImagesListPostDetail! {
     
         didSet{
            
            

               if let urlt = Mypostimagesdata!.media
                            {
                                if (urlt != ""){
                                    let urlf = URL(string: urlt)!
                                    // let image2 = UIImageView()
                                    self.Postimageview.sd_setImage(with: urlf, placeholderImage:UIImage(named: "GirlVentLogo"), options: .delayPlaceholder, completed: { (image, error, cacheType, imageURL) in
                                    })
                                }
                            }
        }
        
        
    }
    
 
}
