//
//	LoginData.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class LoginData : NSObject, NSCoding{

	var email : String!
	var firstname : String!
	var lastname : String!
	var profilePicUrl : String!
	var token : String!
	var username : String!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		email = json["email"].stringValue
		firstname = json["firstname"].stringValue
		lastname = json["lastname"].stringValue
		profilePicUrl = json["profilePicUrl"].stringValue
		token = json["token"].stringValue
		username = json["username"].stringValue
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if email != nil{
			dictionary["email"] = email
		}
		if firstname != nil{
			dictionary["firstname"] = firstname
		}
		if lastname != nil{
			dictionary["lastname"] = lastname
		}
		if profilePicUrl != nil{
			dictionary["profilePicUrl"] = profilePicUrl
		}
		if token != nil{
			dictionary["token"] = token
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
         email = aDecoder.decodeObject(forKey: "email") as? String
         firstname = aDecoder.decodeObject(forKey: "firstname") as? String
         lastname = aDecoder.decodeObject(forKey: "lastname") as? String
         profilePicUrl = aDecoder.decodeObject(forKey: "profilePicUrl") as? String
         token = aDecoder.decodeObject(forKey: "token") as? String
         username = aDecoder.decodeObject(forKey: "username") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
	{
		if email != nil{
			aCoder.encode(email, forKey: "email")
		}
		if firstname != nil{
			aCoder.encode(firstname, forKey: "firstname")
		}
		if lastname != nil{
			aCoder.encode(lastname, forKey: "lastname")
		}
		if profilePicUrl != nil{
			aCoder.encode(profilePicUrl, forKey: "profilePicUrl")
		}
		if token != nil{
			aCoder.encode(token, forKey: "token")
		}
		if username != nil{
			aCoder.encode(username, forKey: "username")
		}

	}

}