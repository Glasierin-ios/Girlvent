//
//  ShareViewController.swift
//  GirlventShareExtension
//
//  Created by geet on 09/07/20.
//  Copyright © 2020 Glasier Inc. All rights reserved.
//

import UIKit
import Social
import MobileCoreServices

class ShareViewController: SLComposeServiceViewController { //SLComposeServiceViewController

    private var urlString: String?
    private var textString: String?
    var imageType = ""
    var window: UIWindow?
    let sharedKey = "ImageSharePhotoKey"
    let VideoType = kUTTypeMovie as String
    let TextType = kUTTypePlainText as String
    override func isContentValid() -> Bool {
        // Do validation of contentText and/or NSExtensionContext attachments here
        return true
    }

    override func didSelectPost() {
        // This is called after the user selects Post. Do the upload of contentText and/or NSExtensionContext attachments.
    
        // Inform the host that we're done, so it un-blocks its UI. Note: Alternatively you could call super's -didSelectPost, which will similarly complete the extension context.
        print("In Did Post")
  
        
                    if let item = self.extensionContext?.inputItems[0] as? NSExtensionItem{
                        print("Item \(item)")
                        for ele in item.attachments!{
                            print("item.attachments!======&gt;&gt;&gt; \(ele )")
                            let itemProvider = ele 
                            print(itemProvider)
                            
                            if itemProvider.hasItemConformingToTypeIdentifier("public.jpeg"){
                                imageType = "public.jpeg"
                            }
                            if itemProvider.hasItemConformingToTypeIdentifier("public.png"){
                                 imageType = "public.png"
                            }
                            print("imageType\(imageType)")

                            if itemProvider.hasItemConformingToTypeIdentifier(imageType){
                                print("True")
                                itemProvider.loadItem(forTypeIdentifier: imageType, options: nil, completionHandler: { (item, error) in

                                    var imgData: Data!
                                    if let url = item as? URL{
                                        imgData = try! Data(contentsOf: url)
                                    }

                                    if let img = item as? UIImage{
                                        imgData = img.pngData()
                                    }
                                    print("Item ===\(String(describing: item))")
                                    print("Image Data=====. \(String(describing: imgData)))")

                                    self.urlString = (String(describing: item))

                                    //, "imgPath" : self.urlString as Any
                                    let dict: [String : Any] = ["imgData" :  imgData as Any,"name" : self.contentText as Any]




                                    let savedata =  UserDefaults.init(suiteName: "group.com.Glasierinc.Girlventdemo")
                                    if ((savedata?.object(forKey: "img")) != nil)
                                    {
                                        print(savedata?.object(forKey: "img") as Any)
                                        savedata?.removeObject(forKey: "img")
                                        savedata?.removeObject(forKey: "Video")
                                        savedata?.removeObject(forKey: "Text")
                                        savedata?.synchronize()
                                        print(savedata?.object(forKey: "img") as Any)
                                    }
                                    savedata?.set(dict, forKey: "img")

                                    savedata?.synchronize()
                                    print("UserDefaultsData \(String(describing: savedata?.value(forKey: "img")))")




                                    //let url = URL(string: "Girlvent://dataUrl=\(self.sharedKey)")
                                    let url = URL(string: "Girlvent://")
                                    var responder = self as UIResponder?
                                    let selectorOpenURL = sel_registerName("openURL:")

                                    while (responder != nil) {
                                        if (responder?.responds(to: selectorOpenURL))! {
                                            if let application = responder as? UIApplication
                                            {
                                                let _ = application.perform(selectorOpenURL, with: url)
                                            }
//                                            let _ = responder?.perform(selectorOpenURL, with: url)
                                        }
                                        responder = responder!.next
                                    }



//                                    self.extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
                                })
                            }
                            else if itemProvider.hasItemConformingToTypeIdentifier(VideoType)
                            {
                               itemProvider.loadItem(forTypeIdentifier: VideoType, options: nil, completionHandler: { (item, error) in

                                    
                                    let dict: [String : Any] = ["name" : self.contentText as Any]




                                    let savedata =  UserDefaults.init(suiteName: "group.com.Glasierinc.Girlventdemo")
                                    if ((savedata?.object(forKey: "Video")) != nil)
                                    {
                                        print(savedata?.object(forKey: "Video") as Any)
                                        savedata?.removeObject(forKey: "Video")
                                        savedata?.removeObject(forKey: "img")
                                        savedata?.removeObject(forKey: "Text")
                                        savedata?.synchronize()
                                        print(savedata?.object(forKey: "Video") as Any)
                                    }
                                    savedata?.set(dict, forKey: "Video")

                                    savedata?.synchronize()
                                    print("UserDefaultsData \(String(describing: savedata?.value(forKey: "Video")))")




                                    //let url = URL(string: "Girlvent://dataUrl=\(self.sharedKey)")
                                    let url = URL(string: "Girlvent://")
                                    var responder = self as UIResponder?
                                    let selectorOpenURL = sel_registerName("openURL:")

                                    while (responder != nil) {
                                        if (responder?.responds(to: selectorOpenURL))! {
                                            if let application = responder as? UIApplication
                                            {
                                                let _ = application.perform(selectorOpenURL, with: url)
                                            }
//                                            let _ = responder?.perform(selectorOpenURL, with: url)
                                        }
                                        responder = responder!.next
                                    }



//                                    self.extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
                                })
                            }
                            else if itemProvider.hasItemConformingToTypeIdentifier(TextType)
                            {
                               itemProvider.loadItem(forTypeIdentifier: TextType, options: nil, completionHandler: { (item, error) in

                                    
                                    let dict: [String : Any] = ["name" : self.contentText as Any]




                                    let savedata =  UserDefaults.init(suiteName: "group.com.Glasierinc.Girlventdemo")
                                    if ((savedata?.object(forKey: "Text")) != nil)
                                    {
                                        print(savedata?.object(forKey: "Text") as Any)
                                        savedata?.removeObject(forKey: "Text")
                                        savedata?.removeObject(forKey: "Video")
                                        savedata?.removeObject(forKey: "img")
                                        savedata?.synchronize()
                                        print(savedata?.object(forKey: "Text") as Any)
                                    }
                                    savedata?.set(dict, forKey: "Text")

                                    savedata?.synchronize()
                                    print("UserDefaultsData \(String(describing: savedata?.value(forKey: "Text")))")




                                    //let url = URL(string: "Girlvent://dataUrl=\(self.sharedKey)")
                                    let url = URL(string: "Girlvent://")
                                    var responder = self as UIResponder?
                                    let selectorOpenURL = sel_registerName("openURL:")

                                    while (responder != nil) {
                                        if (responder?.responds(to: selectorOpenURL))! {
                                            if let application = responder as? UIApplication
                                            {
                                                let _ = application.perform(selectorOpenURL, with: url)
                                            }
//                                            let _ = responder?.perform(selectorOpenURL, with: url)
                                        }
                                        responder = responder!.next
                                    }



//                                    self.extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
                                })
                            }
                        }

                    }
        
        

        
//        self.extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
    }

    override func configurationItems() -> [Any]! {
        // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
        return []
    }
    
}
