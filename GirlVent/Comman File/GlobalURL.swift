
import Foundation
import UIKit

   let ServerName      = "https://girlvent.glasier.in.glasier.in"

//let ServerName      = "http://192.168.1.90/girlvent"

    let BASEURL         = ServerName
    let LoginStatus     = "IsLogin"
let SCREEN_WIDTH:Float = Float(UIScreen.main.bounds.width)
let SCREEN_HEIGHT:Float = Float(UIScreen.main.bounds.height)

//*------------------------------------------------------------------------------*/

/**********************  SetColors  ************************/
let ACTIVE_COLOR = UIColor(red: 9.0/255.0, green: 93.0/255.0, blue: 146.0/255.0, alpha: 1.0)
let GRAY_COLOR = UIColor(red: 138.0/255.0, green: 138.0/255.0, blue: 138.0/255.0, alpha: 1.0)
let DARK_GRAY_COLOR = UIColor.darkGray
let ALERT_COLOR = UIColor(red: 224/255, green: 60/255, blue: 113/255, alpha: 1.0)
let ALERT_COLOR_BACKGROUND = UIColor(red: 224/255, green: 60/255, blue: 113/255, alpha: 0.5)
/**********************  UserDefaults  ************************/


let USER_LOGIN = "GIRLVENT"

struct GlobalURL {
   
    /* ====  MARK :: AFTER LOGIN   ==== */
    
        static let KInternetFailure       = "Something went wrong,Please try Again"
        static let KInternetSlow          = "Check your internet connection"
    
        //static let REGISTER                 =  BASEURL + "register.php"
        static let LOGIN                    =  BASEURL + "/api/auth/mobile/login"
        static let REGISTERUSER             =  BASEURL + "/api/auth/mobile/signup"
        static let FORGOTPASSWORD           =  BASEURL + "/api/mobile/user/forget_password"
        static let GETHOMEPOST              =  BASEURL + "/api/mobile/posts"
        static let SUBMITHOMEPOSTTEXT       =  BASEURL + "/api/mobile/post/create"
        static let GETCATEGORIESLIST        =  BASEURL + "/api/mobile/categories"
        static let GETCOMMENTLIST           =  BASEURL + "/api/mobile/comments/post"
        static let ADDCOMMENT               =  BASEURL + "/api/mobile/comment/create"
        static let EDITCOMMENT              =  BASEURL + "/api/mobile/comment/edit"
        static let GETUSERPOSTLIST          =  BASEURL + "/api/mobile/user_posts"
        static let GETMYIMAGESLIST          =  BASEURL + "/api/mobile/user_posts_images"
        static let GETMYVIDEOLIST           =  BASEURL + "/api/mobile/user_posts_videos"
        static let DELETEPOST               =  BASEURL + "/api/mobile/post/delete"
        static let DELETECOMMENT            =  BASEURL + "/api/mobile/comment/delete"
        static let GETCATEGORIESPOSTLIST    =  BASEURL + "/api/mobile/posts/categories"
        static let SENDMESSAGE              =  BASEURL + "/api/mobile/message/create"
        static let GETUSERLIST              =  BASEURL + "/api/mobile/user_list"
        static let GETUSERDETAIL            =  BASEURL + "/api/mobile/users_detail"
        static let SUBMITUSERDETAIL         =  BASEURL + "/api/mobile/user/update_details"
        static let SUBMITUSERPROFILEPIC     =  BASEURL + "/api/mobile/user/profilepic"
        static let CHANEGEPASSWORD          =  BASEURL + "/api/mobile/user/password"
        static let GETMYMESSAGELIST         =  BASEURL + "/api/mobile/messages"
        static let DELETEMYMESSAGE          =  BASEURL + "/api/mobile/message/delete"
        static let GETFORUMLIST             =  BASEURL + "/api/mobile/forum/forum_list"
        static let CREATEFORUM              =  BASEURL + "/api/mobile/forum/posts"
        static let FORUMDETILSLIST          =  BASEURL + "/api/mobile/forum/id_wise_show"
        static let FORUMREPLY               =  BASEURL + "/api/mobile/forum/reply"
        static let FORUMDELETE              =  BASEURL + "/api/mobile/forum/delete"
        static let FORUMRENAME              =  BASEURL + "/api/mobile/forum/title_rename"
        static let FORUMDELETEREPLYRESPONSE =  BASEURL + "/api/mobile/forum_response/delete"
        static let FORUMEDITREPLYRESPONSE   =  BASEURL + "/api/mobile/forum/edit"
        static let FORUMREPLYRESPONSE       =  BASEURL + "/api/mobile/forum/forum_response_post"
        static let REPORTSPAMPOST           =  BASEURL + "/api/mobile/post/complaint"
        static let CHECKUSERSTATUS          =  BASEURL + "/api/mobile/active_user"
        static let UPDATEPOST               =  BASEURL + "/api/mobile/post/update"
        static let GETREPORTSPAM            =  BASEURL + "/api/mobile/post/report-spam"
}

struct GlobalDefaultsKey {
    
        static let KDeviceToken             = "DeviceToken"
        static let KUserMainImage           = "UserProfilepic"
        static let KUserMainName            = "UserFullName"

}

struct GlobalAlertMessages {
    
        static let KSomethingWentToWrong        = "Something went to Wrong"
    
        static let KInternetNotAvilable         = "Internet Not Avilable"
    
        static let KEnterPromocode              = "Please Enter Promocode"
    
        static let KAddTravelerBookClose        = "If you close this screen than you lost added data. Are you sure you want to close this screen?"
}

/**********************  set height width error message  ************************/

let NETWORK_ERROR_MESSAGE = "There seems to be a problem with your internet connection."


class Constants: NSObject
{
    
    class func getScreenHeight()->Float
    {
        
        return SCREEN_HEIGHT
    }
    
    class func getScreenWidth()->Float
    {
        
        return SCREEN_WIDTH
    }

    
    class func getNetworkErrorMessage()->String
    {
        
        return NETWORK_ERROR_MESSAGE
    }
}
