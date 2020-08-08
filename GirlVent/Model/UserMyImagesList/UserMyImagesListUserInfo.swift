//
//	UserMyImagesListUserInfo.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class UserMyImagesListUserInfo : NSObject, NSCoding{

	var bio : String!
	var firstname : String!
	var lastname : String!
	var profileUrl : String!
	var username : String!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		bio = json["bio"].stringValue
		firstname = json["firstname"].stringValue
		lastname = json["lastname"].stringValue
		profileUrl = json["profile_url"].stringValue
		username = json["username"].stringValue
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if bio != nil{
			dictionary["bio"] = bio
		}
		if firstname != nil{
			dictionary["firstname"] = firstname
		}
		if lastname != nil{
			dictionary["lastname"] = lastname
		}
		if profileUrl != nil{
			dictionary["profile_url"] = profileUrl
		}
		if username != nil{
			dictionary["username"] = username
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         bio = aDecoder.decodeObject(forKey: "bio") as? String
         firstname = aDecoder.decodeObject(forKey: "firstname") as? String
         lastname = aDecoder.decodeObject(forKey: "lastname") as? String
         profileUrl = aDecoder.decodeObject(forKey: "profile_url") as? String
         username = aDecoder.decodeObject(forKey: "username") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
	{
		if bio != nil{
			aCoder.encode(bio, forKey: "bio")
		}
		if firstname != nil{
			aCoder.encode(firstname, forKey: "firstname")
		}
		if lastname != nil{
			aCoder.encode(lastname, forKey: "lastname")
		}
		if profileUrl != nil{
			aCoder.encode(profileUrl, forKey: "profile_url")
		}
		if username != nil{
			aCoder.encode(username, forKey: "username")
		}

	}

}