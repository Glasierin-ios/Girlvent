//
//  Languages.swift
//  Girlvent
//
//  Created by geet on 03/07/20.
//  Copyright © 2020 Glasier Inc. All rights reserved.
//

import Foundation

class Languages: NSObject {
    
    /// Language code to show in application to choese
    fileprivate(set) static var languages: [Language] = {
        
        var languages: [Language] = []
        languages.append(Language(languageCode: "en", language: "English"))
        languages.append(Language(languageCode: "es", language: "Spanish"))
        languages.append(Language(languageCode: "fr", language: "French"))
        
        
        
        return languages
    }()

    // Find a Language Available for Application or not
    //
    // - Parameter code: Language code, exe. en
    // - Returns: true/false
    class func isLanguageAvailable(_ code: String) -> Bool {
        for language in languages {
            if  code == language.languageCode {
                return true
            }
        }
        return false
    }

    // Find a Language based on it's Language code
    //
    // - Parameter code: Language code, exe. en
    // - Returns: Language
    class func languageFromLanguageCode(_ code: String) -> Language {
        for language in languages {
            if  code == language.languageCode {
                return language
            }
        }
        return Language.emptyLanguage
    }
    // Find a Language based on it's Language Name
    //
    // - Parameter languageName: languageName, exe. english
    // - Returns: Language
    class func languageFromLanguageName(_ languageName: String) -> Language {
        for language in languages {
            if languageName == language.language {
                return language
            }
        }
        return Language.emptyLanguage
    }
    
}


class Language: NSObject {
    
    open var languageCode    : String
    open var language : String
    
    public static var emptyLanguage    : Language { return Language(languageCode: "", language: "") }
    
    
    
//     Constructor to initialize a country
//
//     - Parameters:
//     - countryCode: the country code
    public init(languageCode: String, language: String) {
        
        self.languageCode = languageCode
        self.language = language
        
    }
    
    open override var description: String{
        return self.languageCode + " " + self.language
    }
}
