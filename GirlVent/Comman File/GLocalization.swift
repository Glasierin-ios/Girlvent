//
//  GLocalization.swift
//  Girlvent
//
//  Created by geet on 03/07/20.
//  Copyright © 2020 Glasier Inc. All rights reserved.
//

import Foundation

class GLocalization: NSObject {
    static let sharedInstance = GLocalization()
    var bundle: Bundle? = nil
    
    // get localizedString from bundle of selected language
    func localizedString(forKey key: String, value comment: String) -> String {
        let localized = bundle!.localizedString(forKey: key, value: comment, table: nil)
        return localized
    }
    
    
//    func localizedString(forKey key: String, value value1: Int, value2:Int) -> String {
//        let localized = String(format: bundle!.localizedString(forKey: key, value: nil, table: nil), value1,value2)
//        return localized
//    }
    
    // set language for localization
    func setLanguage(language: String) -> Void {
        var selectedLanguage = language
        if language.count == 0 {
            selectedLanguage = "en"
        }
        UserDefaults.standard.set(selectedLanguage, forKey: "GLanguage")
        UserDefaults.standard.synchronize()
        let path: String? = Bundle.main.path(forResource: selectedLanguage, ofType: "lproj")
        if path == nil {
            //in case the language does not exists
            resetLocalization()
        }
        else {
            bundle = Bundle(path: path!)
            print("CurrentInAppLanguage:\(selectedLanguage)")
        }
    }
    
    // reset bundle
    func resetLocalization() {
        bundle = Bundle.main
        print("reset localization")
    }
    
    // get selected language from UserDefaults
    func getLanguage() -> String? {
        if let language = UserDefaults.standard.string(forKey: "GLanguage"){
            return language
        }
        return nil
    }
}

// LocalizedString to get string in selected language
func GLocalizedString(key: Any) -> String {
    return GLocalization.sharedInstance.localizedString(forKey: (key as! String), value: "") //(comment as! String)
}
