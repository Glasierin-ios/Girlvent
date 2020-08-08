//
//  CategoriesPostCell.swift
//  Girlvent
//
//  Created by Glasier Inc. on 24/01/20.
//  Copyright © 2020 Glasier Inc. All rights reserved.
//

import UIKit
import youtube_ios_player_helper
import AVKit
import AVFoundation
protocol categoriesPostCellDelegate{
    func CommentButtonTapped(at index:IndexPath)
    func UserprofileButtonTapped(at index:IndexPath)
    func optionBtnapped(at index:IndexPath,optionButton: UIButton,tablecell : UITableViewCell)
     func imagepostZoomButtonTapped(at index:IndexPath)
    func VideoTapped(at index:IndexPath)

}
class CategoriesPostCell: UITableViewCell,YTPlayerViewDelegate {

    
     var delegate:categoriesPostCellDelegate!
    
         var indexPath:IndexPath!
    
    
    @IBOutlet weak var UserProfilePicImageview: UIImageView!
    @IBOutlet weak var MoreoptionButton: UIButton!
    @IBOutlet weak var UsernameLable: UILabel!
    @IBOutlet weak var TimeLable: UILabel!
    @IBOutlet weak var PostPicImageview: UIImageView!
    @IBOutlet weak var PostPicBackgroundImageview: UIImageView!
    @IBOutlet weak var PostMediaHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var CommentsCountLable: UILabel!
    @IBOutlet weak var CommentButton: UIButton!
    @IBOutlet weak var UserProfileImageButton: UIButton!
    @IBOutlet weak var UserPostContainLable: UILabel!
    @IBOutlet weak var YoutubeView: YTPlayerView!
    @IBOutlet weak var VideoView: PlayerView!
    @IBOutlet weak var videoPlayButtonButton: UIButton!
    @IBOutlet weak var ImagepostZoomButton: UIButton!
    
    @IBOutlet var lblWriteAComment: UILabel!
    @IBOutlet var btnPost: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lblWriteAComment.text = GLocalizedString(key: "home_WriteComment")
        btnPost.setTitle(GLocalizedString(key: "Post"), for: .normal)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.videostopview), name: NSNotification.Name(rawValue:"videostop"), object: nil)
       
        self.layoutIfNeeded()
        
    }
    @objc func videostopview() -> Void {
        
    
        VideoView.player?.pause()
        VideoView.player = nil
        
    }
    var categoriepostdata : CategoriesPostListData! {
    
        didSet{
              

            
            if categoriepostdata!.categoryName == ""{
                
              //  self.UsernameLable.text = "\(Homepostdata!.firstname ?? "") \(Homepostdata!.lastname ?? "") posted"
                
                   let text = "\(categoriepostdata!.username ?? "") \(GLocalizedString(key: "posted"))"
                
                self.UsernameLable.textColor =  UIColor.lightGray
                                     UsernameLable.text = text
                                     let underlineAttriString = NSMutableAttributedString(string: text)
                                     let range1 = (text as NSString).range(of: "\(categoriepostdata!.username ?? "")")
                                     underlineAttriString.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 15.0), range: range1)
                                     underlineAttriString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black, range: range1)
                                    
                                     UsernameLable.attributedText = underlineAttriString
                                     UsernameLable.isUserInteractionEnabled = true
                                     UsernameLable.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(tapLabel(gesture:))))
                
                
            }else{
                
              //  self.UsernameLable.text = "\(Homepostdata!.firstname ?? "") \(Homepostdata!.lastname ?? "") posted in \(Homepostdata!.forumName ?? "")"
                
                
                let text = "\(categoriepostdata!.username ?? "") \(GLocalizedString(key: "posted in")) \(categoriepostdata!.categoryName ?? "")"
                               
                               self.UsernameLable.textColor =  UIColor.lightGray
                                                    UsernameLable.text = text
                                                    let underlineAttriString = NSMutableAttributedString(string: text)
                                                    let range1 = (text as NSString).range(of: "\(categoriepostdata!.username ?? "")")
                                                    let range2 = (text as NSString).range(of: "\(categoriepostdata!.categoryName ?? "")")
                                                    underlineAttriString.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 15.0), range: range1)
                                                    underlineAttriString.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 15.0), range: range2)
                               underlineAttriString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black, range: range1)
                               underlineAttriString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(red: 224.0/255.0, green: 60.0/255.0, blue: 113.0/255.0, alpha: 1.0), range: range2)
                                               
                                                    
                                                    UsernameLable.attributedText = underlineAttriString
                                                    UsernameLable.isUserInteractionEnabled = true
                                                    UsernameLable.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(tapLabel(gesture:))))
                
                
                
            }
            
            if let urlt = categoriepostdata!.profileUrl
                         {
                             if (urlt != ""){
                                 let urlf = URL(string: urlt)!
                                 // let image2 = UIImageView()
                                 self.UserProfilePicImageview.sd_setImage(with: urlf, placeholderImage:UIImage(named: "GirlVentLogo"), options: .delayPlaceholder, completed: { (image, error, cacheType, imageURL) in
                                 })
                             }
                         }
            
            TimeLable.text = categoriepostdata!.postTime
            UserPostContainLable.text = categoriepostdata!.content
            
            if categoriepostdata!.type == "text"{
                
                PostMediaHeightConstraint.constant = 0
                PostPicImageview.isHidden = true
                YoutubeView.isHidden = true
                VideoView.isHidden = true
                ImagepostZoomButton.isHidden = true
                PostPicBackgroundImageview.isHidden = true
                
                
            }else if categoriepostdata!.type == "youtube" {
                
                PostMediaHeightConstraint.constant = 200
                PostPicImageview.isHidden = true
                VideoView.isHidden = true
                 YoutubeView.isHidden = false
                 PostPicBackgroundImageview.isHidden = true
                 ImagepostZoomButton.isHidden = true
                
               let dict = ["modestbranding" : 0,"controls" : 1 ,"autoplay" : 1,"playsinline" : 1,"autohide" : 1,"showinfo" : 0]
                
               
                YoutubeView.load(withVideoId: categoriepostdata!.youtube.youtubeID ?? "",playerVars: dict)
              //  YoutubeView.loadVideo(byURL: Homepostdata!.youtube, startSeconds: 0.5, suggestedQuality: .default)
                YoutubeView.delegate = self
               
                
                
            }else if categoriepostdata!.type == "video"{
                
                
                PostMediaHeightConstraint.constant = 200
                   VideoView.isHidden = false
                YoutubeView.isHidden = true
                 PostPicImageview.isHidden = true
                 PostPicBackgroundImageview.isHidden = true
                 ImagepostZoomButton.isHidden = true
                videoPlayButtonButton.setImage(UIImage(named: "Videoplay"), for: .normal)
                let url = NSURL(string: categoriepostdata!.media)
                let avPlayer = AVPlayer(url: url! as URL)
                VideoView.playerLayer.player = avPlayer
                
            }else if categoriepostdata!.type == "image"{
                
                
                PostMediaHeightConstraint.constant = 300
                   VideoView.isHidden = true
                    YoutubeView.isHidden = true
                 PostPicImageview.isHidden = false
                 PostPicBackgroundImageview.isHidden = false
                 ImagepostZoomButton.isHidden = false
                if let urlt = categoriepostdata!.media
                                       {
                                           if (urlt != ""){
                                               let urlf = URL(string: urlt)!
                                               // let image2 = UIImageView()
                                               self.PostPicImageview.sd_setImage(with: urlf, placeholderImage:UIImage(named: "GirlVentLogo"), options: .delayPlaceholder, completed: { (image, error, cacheType, imageURL) in
                                               })
                                           }
                                       }
                if let urlt = categoriepostdata!.media
                                            {
                                                if (urlt != ""){
                                                    let urlf = URL(string: urlt)!
                                                    // let image2 = UIImageView()
                                                    self.PostPicBackgroundImageview.sd_setImage(with: urlf, placeholderImage:UIImage(named: "GirlVentLogo"), options: .delayPlaceholder, completed: { (image, error, cacheType, imageURL) in
                                                    })
                                                }
                                            }
                self.PostPicBackgroundImageview.makeBlurImage(targetImageView:self.PostPicBackgroundImageview )
              
                
                
            }else{
                
                
                       PostMediaHeightConstraint.constant = 0
                    PostPicImageview.isHidden = true
                    YoutubeView.isHidden = true
                   VideoView.isHidden = true
                 PostPicBackgroundImageview.isHidden = true
                 ImagepostZoomButton.isHidden = true
                
                
            }
            if categoriepostdata!.commentCount == 0 || categoriepostdata!.commentCount == 1{
                CommentsCountLable.text = "\(categoriepostdata!.commentCount ?? 0) \(GLocalizedString(key: "Comment"))"
            }else{
                CommentsCountLable.text = "\(categoriepostdata!.commentCount ?? 0) \(GLocalizedString(key: "Comments"))"
            }
            
         
            
        }
        
    }
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
       // YoutubeView.playVideo()

    }
        @IBAction func tapLabel(gesture: UITapGestureRecognizer) {
            
         //   let usernameRange = (UsernameLable.text!).range(of: "\(Homepostdata!.firstname ?? "") \(Homepostdata!.lastname ?? "")")
            
             let text = UsernameLable.text!
            let checktext = "\(categoriepostdata!.username ?? "")"
            let checktext2 = "\(categoriepostdata!.categoryName ?? "")"
            
       let termsRange = (text as NSString).range(of: checktext)
          let termsRange1 = (text as NSString).range(of: checktext2)
           if gesture.didTapAttributedTextInLabel(label: UsernameLable, inRange: termsRange) {
                    print("Tapped none name")
               self.delegate?.UserprofileButtonTapped(at: indexPath)
           }else if gesture.didTapAttributedTextInLabel(label: UsernameLable, inRange: termsRange1) {
        
               print("Tapped none category")
           }else{
            
                  print("Tapped none ")
            }
        }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
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
    
    @IBAction func CommentButtonClick(_ sender: Any) {
        
        self.delegate?.CommentButtonTapped(at: indexPath)
            }
    @IBAction func MoreOptionButtonClick(_ sender: Any) {
        self.delegate?.optionBtnapped(at: indexPath,optionButton: sender as! UIButton,tablecell:self)

    }
    @IBAction func UserProfileImageButtonClick(_ sender: Any) {
             self.delegate?.UserprofileButtonTapped(at: indexPath)
    }
    @IBAction func ImagePostZoommButtonClick(_ sender: Any) {
                self.delegate?.imagepostZoomButtonTapped(at: indexPath)
       }
}
