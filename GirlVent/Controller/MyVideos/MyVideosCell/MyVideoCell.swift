//
//  MyVideoCell.swift
//  Girlvent
//
//  Created by Glasier Inc. on 09/01/20.
//  Copyright © 2020 Glasier Inc. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
protocol MyMyVideoCellDelegate{
    func PostDeleteTapped(at index:IndexPath)
    func VideoTapped(at index:IndexPath)
}
class MyVideoCell: UICollectionViewCell {
    
        @IBOutlet weak var VideoView: PlayerView!
     @IBOutlet weak var PostdeletButton: UIButton!
     @IBOutlet weak var videoPlayButtonButton: UIButton!
     var delegate:MyMyVideoCellDelegate!
       
            var indexPath:IndexPath!
     @IBAction func PostdeleteButtonClick(_ sender: Any) {
          self.delegate?.PostDeleteTapped(at: indexPath)
     }
     
     var Mypostimagesdata : UserMyVideoListPostDetail! {
      
          didSet{
             
             

                if let urlt = Mypostimagesdata!.media
                             {
                                 if (urlt != ""){
                                    // let urlf = URL(string: urlt)!
                                     videoPlayButtonButton.setImage(UIImage(named: "Videoplay"), for: .normal)
                                                               let url = NSURL(string: Mypostimagesdata!.media)
                                                               let avPlayer = AVPlayer(url: url! as URL)
                                                               VideoView.playerLayer.player = avPlayer
                                 }
                             }
         }
         
         
     }
    
    @IBAction func videoPlayButtonButtonClick(_ sender: Any) {
        
        self.delegate?.VideoTapped(at: indexPath)

        

        
//        if videoPlayButtonButton.isSelected{
//
//                 videoPlayButtonButton.setImage(UIImage(named: "Videoplay"), for: .normal)
//             videoPlayButtonButton.isSelected = false
//              VideoView.player?.pause()
//        }else{
//            videoPlayButtonButton.setImage(UIImage(named: ""), for: .normal)
//            videoPlayButtonButton.isSelected = true
//            VideoView.player?.play()
//            NotificationCenter.default.addObserver(forName: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil, queue: nil) { notification in
//                self.VideoView.player?.seek(to: CMTime.zero)
//                self.VideoView.player?.play()
//               }
//
//        }
     
    
    }
}
