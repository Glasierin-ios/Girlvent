
//
//  HomePostListCell.swift
//  Girlvent
//
//  Created by Glasier Inc. on 02/01/20.
//  Copyright © 2020 Glasier Inc. All rights reserved.
//

import UIKit
import youtube_ios_player_helper
import AVKit
import AVFoundation
protocol HomePostCellDelegate{
    func CommentButtonTapped(at index:IndexPath)
    func UserprofileButtonTapped(at index:IndexPath)
    func CategoriesButtonTapped(at index:IndexPath)
    func optionBtnapped(at index:IndexPath,optionButton: UIButton,tablecell : UITableViewCell)
     func imagepostZoomButtonTapped(at index:IndexPath)
     func VideoTapped(at index:IndexPath)
    
}

class HomePostListCell: UITableViewCell,YTPlayerViewDelegate {

     var delegate:HomePostCellDelegate!
    
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
    @IBOutlet weak var lblWriteAComment: UILabel!
    
    @IBOutlet weak var btnPost: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.videostopview), name: NSNotification.Name(rawValue:"videostop"), object: nil)
       
        self.layoutIfNeeded()
        
        
    
    }
    @objc func videostopview() -> Void {
        
    
        VideoView.player?.pause()
        VideoView.player = nil
        
    }
    var Homepostdata : GetHomePostData! {
    
        didSet{
              

            
            if Homepostdata!.categoryName == ""{
                
              //  self.UsernameLable.text = "\(Homepostdata!.firstname ?? "") \(Homepostdata!.lastname ?? "") posted"
                
//                   let text = "\(Homepostdata!.username ?? "") posted"
                
                let text = "\(Homepostdata!.username ?? "") \(GLocalizedString(key: "posted"))"
                
                self.UsernameLable.textColor =  UIColor.lightGray
                                     UsernameLable.text = text
                                     let underlineAttriString = NSMutableAttributedString(string: text)
                                     let range1 = (text as NSString).range(of: "\(Homepostdata!.username ?? "")")
                                     underlineAttriString.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 15.0), range: range1)
                                     underlineAttriString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black, range: range1)
                                    
                                     UsernameLable.attributedText = underlineAttriString
                                     UsernameLable.isUserInteractionEnabled = true
                                     UsernameLable.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(tapLabel(gesture:))))
                
                
            }else{
                
              //  self.UsernameLable.text = "\(Homepostdata!.firstname ?? "") \(Homepostdata!.lastname ?? "") posted in \(Homepostdata!.forumName ?? "")"
               
                //for localize api response
//                let myString = GLocalization.sharedInstance.localizedString(forKey: "user_name", value: 1, value2: 9)
                
                
//                let text = "\(Homepostdata!.username ?? "") posted in \(Homepostdata!.categoryName ?? "")"
                let text = "\(Homepostdata!.username ?? "") \(GLocalizedString(key: "posted in")) \(Homepostdata!.categoryName ?? "")"
                               
                               self.UsernameLable.textColor =  UIColor.lightGray
                                                    UsernameLable.text = text
                                                    let underlineAttriString = NSMutableAttributedString(string: text)
                                                    let range1 = (text as NSString).range(of: "\(Homepostdata!.username ?? "")")
                                                    let range2 = (text as NSString).range(of: "\(Homepostdata!.categoryName ?? "")")
                                                    underlineAttriString.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 15.0), range: range1)
                                                    underlineAttriString.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 15.0), range: range2)
                               underlineAttriString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black, range: range1)
                               underlineAttriString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(red: 224.0/255.0, green: 60.0/255.0, blue: 113.0/255.0, alpha: 1.0), range: range2)
                                               
                                                    
                                                    UsernameLable.attributedText = underlineAttriString
                                                    UsernameLable.isUserInteractionEnabled = true
                                                    UsernameLable.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(tapLabel(gesture:))))
                
                
                
            }
            
            if let urlt = Homepostdata!.profileUrl
                         {
                             if (urlt != ""){
                                 let urlf = URL(string: urlt)!
                                 // let image2 = UIImageView()GirlVentLogo
                                 self.UserProfilePicImageview.sd_setImage(with: urlf, placeholderImage:UIImage(named: "GirlVentLogo"), options: .delayPlaceholder, completed: { (image, error, cacheType, imageURL) in
                                 })
                             }
                         }
            
            TimeLable.text = Homepostdata!.postTime
            UserPostContainLable.text = Homepostdata!.content
            
            if Homepostdata!.type == "text"{
                
                PostMediaHeightConstraint.constant = 0
                PostPicImageview.isHidden = true
                YoutubeView.isHidden = true
                VideoView.isHidden = true
                ImagepostZoomButton.isHidden = true
                PostPicBackgroundImageview.isHidden = true
                
                
            }else if Homepostdata!.type == "youtube" {
                
                PostMediaHeightConstraint.constant = 200
                PostPicImageview.isHidden = true
                VideoView.isHidden = true
                 YoutubeView.isHidden = false
                 PostPicBackgroundImageview.isHidden = true
                 ImagepostZoomButton.isHidden = true
                
                let dict = ["modestbranding" : 1,"controls" : 1 ,"autoplay" : 1,"playsinline" : 1,"autohide" : 1,"showinfo" : 0,"enablejsapi" : 1,"rel" : 0,"origin" : "http://www.youtube.com"] as [String : Any]
                
               
                YoutubeView.load(withVideoId: Homepostdata!.youtube.youtubeID ?? "",playerVars: dict)
              //  YoutubeView.loadVideo(byURL: Homepostdata!.youtube, startSeconds: 0.5, suggestedQuality: .default)
                YoutubeView.delegate = self

            }else if Homepostdata!.type == "video"{
                
                
                PostMediaHeightConstraint.constant = 200
                   VideoView.isHidden = false
                YoutubeView.isHidden = true
                 PostPicImageview.isHidden = true
                 PostPicBackgroundImageview.isHidden = true
                 ImagepostZoomButton.isHidden = true
                videoPlayButtonButton.setImage(UIImage(named: "Videoplay"), for: .normal)
                let url = NSURL(string: Homepostdata!.media)
                let avPlayer = AVPlayer(url: url! as URL)
                VideoView.playerLayer.player = avPlayer
                
            }else if Homepostdata!.type == "image"{
                
                
                PostMediaHeightConstraint.constant = 300
                   VideoView.isHidden = true
                    YoutubeView.isHidden = true
                 PostPicImageview.isHidden = false
                 PostPicBackgroundImageview.isHidden = false
                 ImagepostZoomButton.isHidden = false
                if let urlt = Homepostdata!.media
                                       {
                                           if (urlt != ""){
                                               let urlf = URL(string: urlt)!
                                               // let image2 = UIImageView()
                                               self.PostPicImageview.sd_setImage(with: urlf, placeholderImage:UIImage(named: "GirlVentLogo"), options: .delayPlaceholder, completed: { (image, error, cacheType, imageURL) in
                                               })
                                           }
                                       }
                if let urlt = Homepostdata!.media
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
            
            if Homepostdata!.commentCount == 0 || Homepostdata!.commentCount == 1{
                CommentsCountLable.text = "\(Homepostdata!.commentCount ?? 0) \(GLocalizedString(key: "Comment"))"
            }else{
                CommentsCountLable.text = "\(Homepostdata!.commentCount ?? 0) \(GLocalizedString(key: "Comments"))"
            }
   
            
        }
        
    }
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
       // YoutubeView.playVideo()

    }
        @IBAction func tapLabel(gesture: UITapGestureRecognizer) {
            
         //   let usernameRange = (UsernameLable.text!).range(of: "\(Homepostdata!.firstname ?? "") \(Homepostdata!.lastname ?? "")")
            
             let text = UsernameLable.text!
            let checktext = "\(Homepostdata!.username ?? "")"
            let checktext2 = "\(Homepostdata!.categoryName ?? "")"
            
       let termsRange = (text as NSString).range(of: checktext)
          let termsRange1 = (text as NSString).range(of: checktext2)
           if gesture.didTapAttributedTextInLabel(label: UsernameLable, inRange: termsRange) {
                    print("Tapped none name")
               self.delegate?.UserprofileButtonTapped(at: indexPath)
           }else if gesture.didTapAttributedTextInLabel(label: UsernameLable, inRange: termsRange1) {
        
             self.delegate?.CategoriesButtonTapped(at: indexPath)
            
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
extension String {
    var youtubeID: String? {
        let pattern = "((?<=(v|V)/)|(?<=be/)|(?<=(\\?|\\&)v=)|(?<=embed/))([\\w-]++)"

        let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        let range = NSRange(location: 0, length: count)

        guard let result = regex?.firstMatch(in: self, range: range) else {
            return nil
        }

        return (self as NSString).substring(with: result.range)
    }
}
class PlayerView: UIView {
override static var layerClass: AnyClass {
return AVPlayerLayer.self
    }
var playerLayer: AVPlayerLayer {
return layer as! AVPlayerLayer
    }
var player: AVPlayer? {
get {
return playerLayer.player
        }
set {
            playerLayer.player = newValue
        }
    }
}
extension UIImageView
{
    func makeBlurImage(targetImageView:UIImageView?)
    {
        
        var blurEffect:UIBlurEffect = UIBlurEffect()
        if #available(iOS 10.0, *) { //iOS 10.0 and above
            blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)//prominent,regular,extraLight, light, dark
        } else { //iOS 8.0 and above
            blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark) //extraLight, light, dark
        }
        
    
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = targetImageView!.bounds
          blurEffectView.alpha = 0.5

        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        targetImageView?.addSubview(blurEffectView)
    }
}
