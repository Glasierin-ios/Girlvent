//
//  GlobalFunction.swift
//  E-Report
//
//  Created by macmin on 07/03/18.
//  Copyright © 2018 macmin. All rights reserved.
//

import UIKit
import SDWebImage
import SwiftSpinner

// MARK:- == function for setting headerView

func setupHeaderView(view : UIView , height : NSLayoutConstraint){
    view.applyGradient()
    if (DeviceType.IS_IPHONE_5){
        height.constant = 88
    }else {
        height.constant = 64
    }
    
}

extension Data {
    var format: String {
        let array = [UInt8](self)
        let ext: String
        switch (array[0]) {
        case 0xFF:
            ext = "jpg"
        case 0x89:
            ext = "png"
        case 0x47:
            ext = "gif"
        case 0x49, 0x4D :
            ext = "tiff"
        default:
            ext = "unknown"
        }
        return ext
    }
}

extension UIApplication {
    class func openAppSettings() {
        if let url = URL(string: "\(UIApplication.openSettingsURLString)"), !url.absoluteString.isEmpty {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
      //  UIApplication.shared.openURL(URL(string: UIApplication.openSettingsURLString)!)
    }
}
open class AppUtility: NSObject
{

class func showProgress()
{

    SwiftSpinner.show(GLocalizedString(key: "Loading"))
    
}

class func hideProgress()
{
    SwiftSpinner.hide()
}
}
class HELPER
{
    
    static let sharedInstance = HELPER()
  
    

    /*===VIEW ANIMATIONS====*/
    class func viewSlideInFromRightToLeft(views: UIView) {
        var transition: CATransition? = nil
        transition = CATransition()
        transition!.duration = 0.1
        transition!.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition!.type = CATransitionType.push
        transition!.subtype = CATransitionSubtype.fromRight
        views.layer.add(transition!, forKey: nil)
    }
    class func viewSlideInFromLeftToRight(views: UIView) {
        var transition: CATransition? = nil
        transition = CATransition()
        transition!.duration = 0.5
        transition!.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition!.type = CATransitionType.push
        transition!.subtype = CATransitionSubtype.fromLeft
        views.layer.add(transition!, forKey: nil)
    }
    class func viewSlideInFromTopToBottom(views: UIView) {
        var transition: CATransition? = nil
        transition = CATransition()
        transition!.duration = 0.5
        transition!.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition!.type = CATransitionType.push
        transition!.subtype = CATransitionSubtype.fromTop
        views.layer.add(transition!, forKey: nil)
    }
    class func viewSlideInFromBottomToTop(views: UIView) {
        var transition: CATransition? = nil
        transition = CATransition()
        transition!.duration = 0.5
        transition!.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition!.type = CATransitionType.push
        transition!.subtype = CATransitionSubtype.fromBottom
        views.layer.add(transition!, forKey: nil)
    }
   
    //MARK:- Get Image Name Dynamic With Current DateTime
    class func getDynamicImageName()->String{
        let strDate =  String(describing: Date())
        let strDateTime : [String] = strDate.components(separatedBy: "+")
        let originalDate = strDateTime[0]
        var imageName = originalDate.replacingOccurrences(of: " ", with: "")
        imageName = imageName.replacingOccurrences(of: "-", with: "")
        imageName = imageName.replacingOccurrences(of: ":", with: "")
        return imageName
    }
    
    //MARK:- : InternetConnectionCheck on Button Click
    class func isReachablityBtnClick()->Bool{
        if(Reachbility.isConnectedToNetwork()){
            return true
        }else{
            sharedInstance.globalAlert(message: "Please check your internet connection!")
            return false
        }
    }
    //MARK:- : InternetConnectionCheck
    class func isReachablity(parentView :UIView)->Bool {
        if(Reachbility.isConnectedToNetwork()){
            return true
        }else{
            
            let alert  = UIAlertController(title: "", message: "Please check your internet connection!  ", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .destructive) { (action) in
               sharedInstance.showNoInternetFoundView(view :parentView)
            }
            alert.addAction(action)
            UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
            return false
        }
    }
    //Mark :- No internet View
    func showNoInternetFoundView(view :UIView){
        var pointY:CGFloat {
            get {
                return DeviceType.IS_IPHONE_5 ? 84 : 64
            }
        }
        let viewNoInternet = UIView(frame: CGRect(x: view.frame.origin.x, y: view.frame.origin.y + pointY, width: view.frame.width, height: view.frame.height - 30))
        let imageView = UIImageView(image: #imageLiteral(resourceName: "ic_no_connection"))
        imageView.frame = CGRect(x: 0 , y: 0, width: 200, height: 200)
        imageView.center = view.center
        viewNoInternet.addSubview(imageView)
        viewNoInternet.backgroundColor = UIColor.white
        view.addSubview(viewNoInternet)
    }

    class func showNoDataView(parentView: UIView){
        
        var pointY:CGFloat {
            get {
                return DeviceType.IS_IPHONE_5 ? 84 : 64
            }
        }
        let viewNoData = UIView(frame: CGRect(x: parentView.frame.origin.x, y: parentView.frame.origin.y + pointY, width: parentView.frame.width, height: parentView.frame.height - 30))
        let lblNoData = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
        lblNoData.center = parentView.center
        lblNoData.textAlignment = .center
        lblNoData.text = "Data Not Available"
        viewNoData.addSubview(lblNoData)
        viewNoData.backgroundColor = UIColor.white
        parentView.addSubview(viewNoData);
        
    }
    
    class func getPastTime(for date : Date) -> String {
        
        var secondsAgo = Int(Date().timeIntervalSince(date))
        if secondsAgo < 0 {
            secondsAgo = secondsAgo * (-1)
        }
        
        let minute = 60
        let hour = 60 * minute
        let day = 24 * hour
        let week = 7 * day
        
        if secondsAgo < minute  {
            if secondsAgo < 2{
                return "just now"
            }else{
                return "\(secondsAgo) secs ago"
            }
        } else if secondsAgo < hour {
            let min = secondsAgo/minute
            if min == 1{
                return "\(min) min ago"
            }else{
                return "\(min) mins ago"
            }
        } else if secondsAgo < day {
            let hr = secondsAgo/hour
            if hr == 1{
                return "\(hr) hr ago"
            } else {
                return "\(hr) hrs ago"
            }
        } else if secondsAgo < week {
            let day = secondsAgo/day
            if day == 1{
                return "\(day) day ago"
            }else{
                return "\(day) days ago"
            }
        } else {
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM dd, hh:mm a"
            formatter.locale = Locale(identifier: "en_US")
            let strDate: String = formatter.string(from: date)
            return strDate
        }
    }
    
    class func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
   class func shadowOnviewWithcornerRadius(YourView:UIView)
    {
        YourView.layer.shadowColor = UIColor.gray.cgColor;
        YourView.layer.shadowOpacity = 0.5;
        YourView.layer.shadowRadius  = 1;
        YourView.layer.shadowOffset  = CGSize(width :0, height :0)
        YourView.layer.masksToBounds = false;
        YourView.layer.cornerRadius  =  3.0;
        //YourView.layer.borderWidth   = 0.5;
        YourView.backgroundColor     = UIColor.white;
    }
    
    class func imgLoading ( imageView  : UIImageView , imageUrl : String) {
        
        let url = URL(string: "http://173.249.46.82/WajibnaAPIs/\(imageUrl)")
        imageView.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "round_person_black_36pt_3x") ,completed: nil)
        
       // imageView.sd_setImage(with: url, completed: nil)
    }
    
    class func imageFromURL(imageUrl : String,placeholder: UIImage)->UIImage{
        let imageView :UIImageView!
        imageView = UIImageView()
        let url = URL(string: "http://173.249.46.82/WajibnaAPIs/\(imageUrl)")
        imageView.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "round_person_black_36pt_3x") ,completed: nil)
        return imageView.image!
    }
    class func imgLoadingCommon (imageView  : UIImageView , imageUrl : String) {
        
        let url = URL(string: "http://wajibna.com/Images/\(imageUrl)")
        imageView.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "round_person_black_36pt_3x") ,completed: nil)
        
        // imageView.sd_setImage(with: url, completed: nil)
    }
   
    /* ====   MARK:  SET USER IS LOGIN AND USER ID  ==== */
    class func saveUserSession(u :LoginData)
    {
        let data = NSKeyedArchiver.archivedData(withRootObject:u as Any)
        UserDefaults.standard.set(data, forKey: USER_LOGIN)
        UserDefaults.standard.synchronize()
        
//        //For shareExtension
//        let userdata = UserDefaults(suiteName: "group.com.Glasierinc.Girlventdemo")
//        userdata?.set(data, forKey: USER_LOGIN)
//        userdata?.synchronize()
    }
    
    class func getSession() ->LoginData
    {
        let data = UserDefaults.standard.data(forKey:USER_LOGIN)
        let decodedObj = NSKeyedUnarchiver.unarchiveObject(with: data!) as? LoginData
        
        let userdata = UserDefaults(suiteName: "group.com.Glasierinc.Girlventdemo")
        if ((userdata?.object(forKey: USER_LOGIN)) == nil)
        {
            
            userdata?.set(decodedObj?.token, forKey: USER_LOGIN)
            userdata?.synchronize()
        }
        
        return decodedObj!
    }
    
    
    
 
    
    class func getAppLanguageWithCapital() -> String{
        if UserDefaults.standard.value(forKey: "App_Language") == nil {
            return "0"
        }
        else if UserDefaults.standard.value(forKey: "App_Language") as! String == "English"{
            return "En"
        } else{
            return "Ar"
        }
    }
    
    class func getAppLanguage() -> String{
        if UserDefaults.standard.value(forKey: "App_Language") == nil {
            return "0"
        }
        else if UserDefaults.standard.value(forKey: "App_Language") as! String == "English"{
            return "en"
        } else{
            return "ar"
        }
    }
    
   
  
    
    //MARK:- Date Formater for comments
    func stringToDate(strDate :String)->String{
        let strDateTime : [String] = strDate.components(separatedBy: ".")
        let originalDate = strDateTime[0]
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if let date = dateFormatterGet.date(from: originalDate){
            let time = HELPER.getPastTime(for: date)
            return time
        }
        else {
            return originalDate
        }
    }
    
// == Email Validation ==
   
    func isValidEmail(testStr:String) -> Bool {
        print("validate emilId: \(testStr)")
        let emailRegEx = "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: testStr)
        return result
    }
    
//    func isValidEmail(testStr:String) -> Bool {
//        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
//        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
//    }
//
//=== Password Validation ===
 class func isPwdLenth(password: String )-> Bool {
        var upperCaseLetter :Bool = false
        var digit :Bool = false
        var specialCharacter : Bool = false
        for char in password.unicodeScalars{
            if !upperCaseLetter{
                upperCaseLetter = CharacterSet.uppercaseLetters.contains(char)
            }
            if !digit{
                digit = CharacterSet.decimalDigits.contains(char)
            }
            if !specialCharacter{
                specialCharacter = CharacterSet.punctuationCharacters.contains(char)
            }
        }
        if specialCharacter && digit && upperCaseLetter{
            
            return true
        }else{
            return false
        }
    }
    
//    func isValidPassword() -> Bool {
//        let regularExpression =  ".*[^A-Za-z0-9].*"
//        let passwordValidation = NSPredicate.init(format: "SELF MATCHES %@", regularExpression)
//        return passwordValidation.evaluate(with: self)
//    }
//
//
    
// === PhoneNumber Validation ===
func isValidPhone(phone: String) -> Bool {
    let PHONE_REGEX = "^09[0-9'@s]{9,9}$"
    let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
    let result =  phoneTest.evaluate(with: phone)
    return result
    
}
 // === Alert Message === 
func globalAlert(message: String) {
    
    let alert = UIAlertController(title: "" , message: message, preferredStyle: .alert)
    
    let okaction = UIAlertAction(title:GLocalizedString(key: "OK"), style: .cancel, handler: nil)
    alert.addAction(okaction)
    UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
}

    
    
  
    
}
extension NSMutableAttributedString
{
    @discardableResult func Regular(_ text: String, Fontsize : CGFloat) -> NSMutableAttributedString
    {
        let attrs: [NSAttributedString.Key: Any] = [.font: UIFont(name: "DINNextLTArabic-Regular", size: Fontsize)!, NSAttributedString.Key.foregroundColor: UIColor(red: 87.0/255.0, green: 94.0/255.0, blue: 98.0/255.0, alpha: 1.0) ]
        let regString = NSMutableAttributedString(string:text, attributes: attrs)
        append(regString)
        return self
    }
    @discardableResult func middle(_ text: String, Fontsize : CGFloat) -> NSMutableAttributedString {
        let attrs: [NSAttributedString.Key: Any] = [.font: UIFont(name: "DINNextLTArabic-Bold", size: Fontsize)!, NSAttributedString.Key.foregroundColor: UIColor(red: 87.0/255.0, green: 94.0/255.0, blue: 98.0/255.0, alpha: 1.0) ]
        let boldString = NSMutableAttributedString(string:text, attributes: attrs)
        append(boldString)
        return self
    }
    @discardableResult func last(_ text: String, Fontsize : CGFloat) -> NSMutableAttributedString {
        let attrs: [NSAttributedString.Key: Any] = [.font: UIFont(name: "DINNextLTArabic-Regular", size: Fontsize)!, NSAttributedString.Key.foregroundColor: UIColor(red: 87.0/255.0, green: 94.0/255.0, blue: 98.0/255.0, alpha: 1.0) ]
        let boldString = NSMutableAttributedString(string:text, attributes: attrs)
        append(boldString)
        return self
    }
}
func FormattedString(first : String, middle : String,last:String ,fontsize : CGFloat) -> NSMutableAttributedString
{
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.alignment = .left
    paragraphStyle.lineSpacing = 1
    paragraphStyle.paragraphSpacing = 1
    let formattedString = NSMutableAttributedString()
    formattedString.Regular(first, Fontsize: fontsize).middle(middle, Fontsize: fontsize).last(last, Fontsize: fontsize)
    formattedString.addAttributes([NSAttributedString.Key.paragraphStyle: paragraphStyle], range: NSRange(location: 0, length: formattedString.length))
    return formattedString
}
    
extension UIView {
        func applyGradient() -> Void {
            let colorleft = UIColor(red: 0.00, green: 0.17, blue: 0.70, alpha: 1.0)
            let colorright = UIColor(red: 0.17, green: 0.33, blue: 0.86, alpha: 1.0)
            let colour = [colorleft, colorright ]
            let loctn1 = CGPoint(x: 0.0, y: 0.3)
            let loctn2 = CGPoint(x: 1.0, y: 0.5)
            
            
            self.applyGradient(colours: colour, StartPoint: loctn1 , EndPoint: loctn2 )
        }
        
        func applyGradient(colours: [UIColor], StartPoint: CGPoint , EndPoint: CGPoint) -> Void {
            let gradient: CAGradientLayer = CAGradientLayer()
            gradient.frame = self.bounds
            gradient.colors = colours.map { $0.cgColor }
            gradient.startPoint = StartPoint
            gradient.endPoint = EndPoint
            self.layer.insertSublayer(gradient, at: 0)
        }
    
    
    
    func animShow(){
        UIView.animate(withDuration: 1, delay: 0, options: UIView.AnimationOptions.curveLinear,
                       animations: {
                        self.center.y -= self.bounds.height
                        self.layoutIfNeeded()
        }, completion: nil)
        self.isHidden = false
    }
    func animHide(){
        UIView.animate(withDuration: 1, delay: 0, options: UIView.AnimationOptions.curveLinear,
                       animations: {
                        self.center.y += self.bounds.height
                        self.layoutIfNeeded()
                        
        },  completion: {(_ completed: Bool) -> Void in
            self.isHidden = true
        })
    }
    
    
}

extension String {
    func matchPattern(patStr:String)->Bool {
        var isMatch:Bool = false
        do {
            let regex = try NSRegularExpression(pattern: patStr, options: [.caseInsensitive])
            let result = regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, count))
            
            if (result != nil)
            {
                isMatch = true
            }
        }
        catch {
            isMatch = false
        }
        return isMatch
    }
    
    func localizedStr(language:String) -> String
    {
          let path = Bundle.main.path(forResource: language, ofType: "lproj")
          let bundleName = Bundle(path: path!)
          return NSLocalizedString(self, tableName: nil, bundle: bundleName!, value: "", comment: "")

    }
    
}
extension UIToolbar{
    func textviewDone(selectDone:Selector)-> UIToolbar{
        let toolBar = UIToolbar()
        
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent =  true
        toolBar.tintColor = UIColor.black
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: selectDone)
        let spacebutton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        
        
        toolBar.isUserInteractionEnabled = true
        toolBar.setItems([spacebutton,doneButton], animated: true)
        return toolBar
        
    }
}





extension UITextField {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func PaddingViewadd(_ textField: UITextField) {
        
        let paddingView = UIView(frame: CGRect(x: 0, y:0, width: 10, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = UITextField.ViewMode.always
        
    }
    
}

class CustomLanguageTextView: UITextView
{
    func tryLoggingPrimaryLanguageInfoOnKeyboard() {
        print("Total number of keyboards. : \(UITextInputMode.activeInputModes.count)")
        for keyboardInputModes in UITextInputMode.activeInputModes{
            if let language = keyboardInputModes.primaryLanguage{
               dump(language)
            }
        }
    }
    var languageCode: String?{
        didSet {
            if self.isFirstResponder{
                self.resignFirstResponder();
                self.becomeFirstResponder();
            }
        }
    }
    override var textInputMode: UITextInputMode?{
        print("Total number of keyboards. : \(UITextInputMode.activeInputModes.count)")
        if let languageCode = self.languageCode {
            for keyboardInputModes in UITextInputMode.activeInputModes {
                if let language = keyboardInputModes.primaryLanguage {
                    if language == languageCode {
                        print("success")
                        return keyboardInputModes;
                    }
                }
            }
        }
        print("failed")
        return super.textInputMode;
    }
}

extension UIViewController
{
    var App_Delegate:AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
}
