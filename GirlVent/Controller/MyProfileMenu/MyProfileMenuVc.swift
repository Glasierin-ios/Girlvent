//
//  MyProfileMenuVc.swift
//  Girlvent
//
//  Created by Glasier Inc. on 04/01/20.
//  Copyright © 2020 Glasier Inc. All rights reserved.
//

import UIKit


protocol MyProfileMenuOptionCellDelegate{
    func MyPostsButtonTapped()
    func MyMessagesButtonTapped()
    func EditProfileButtonTapped()
    func MyImagesButtonTapped()
    func MyVideosButtonTapped()
}


class MyProfileMenuVc: UIViewController {
    
    
  var delegate:MyProfileMenuOptionCellDelegate!
    @IBOutlet weak var MyPostsButton: UIButton!
    @IBOutlet weak var MyMessagesButton: UIButton!
    @IBOutlet weak var EditProfileButton: UIButton!
    @IBOutlet weak var MyImagesButton: UIButton!
    @IBOutlet weak var MyVideosButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        MyPostsButton.setTitle(GLocalizedString(key: "pm_MyPosts"), for: .normal)
        MyMessagesButton.setTitle(GLocalizedString(key: "pm_MyImages"), for: .normal)
        MyVideosButton.setTitle(GLocalizedString(key: "pm_MyVideos"), for: .normal)
        MyImagesButton.setTitle(GLocalizedString(key: "menu_MyMessages"), for: .normal)
        EditProfileButton.setTitle(GLocalizedString(key: "pm_EditProfile"), for: .normal)
    }
    

    @IBAction func MyPostsButtonclick(_ sender: Any) {
        
      
      self.delegate?.MyPostsButtonTapped()

        
    }
    @IBAction func MyMessagesButtonclick(_ sender: Any) {
        self.delegate?.MyMessagesButtonTapped()
    
        
        
    }
    @IBAction func EditProfileButtonClick(_ sender: Any) {
        self.delegate?.EditProfileButtonTapped()
    }
    @IBAction func MyImagesButtonClick(_ sender: Any) {
        
          self.delegate?.MyImagesButtonTapped()
     
    }
    @IBAction func MyVideosButtonClick(_ sender: Any) {
       self.delegate?.MyVideosButtonTapped()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
