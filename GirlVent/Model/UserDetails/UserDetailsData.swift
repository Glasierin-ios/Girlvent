//
//	UserDetailsData.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class UserDetailsData : NSObject, NSCoding{

	var bio : String!
	var birthDay : String!
	var birthMonth : String!
	var email : String!
	var firstname : String!
	var gender : String!
	var lastname : String!
	var profileImage : String!
	var userId : Int!
	var username : String!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		bio = json["bio"].stringValue
		birthDay = json["birth_day"].stringValue
		birthMonth = json["birth_month"].stringValue
		email = json["email"].stringValue
		firstname = json["firstname"].stringValue
		gender = json["gender"].stringValue
		lastname = json["lastname"].stringValue
		profileImage = json["profile_image"].stringValue
		userId = json["user_id"].intValue
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
		if birthDay != nil{
			dictionary["birth_day"] = birthDay
		}
		if birthMonth != nil{
			dictionary["birth_month"] = birthMonth
		}
		if email != nil{
			dictionary["email"] = email
		}
		if firstname != nil{
			dictionary["firstname"] = firstname
		}
		if gender != nil{
			dictionary["gender"] = gender
		}
		if lastname != nil{
			dictionary["lastname"] = lastname
		}
		if profileImage != nil{
			dictionary["profile_image"] = profileImage
		}
		if userId != nil{
			dictionary["user_id"] = userId
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
         birthDay = aDecoder.decodeObject(forKey: "birth_day") as? String
         birthMonth = aDecoder.decodeObject(forKey: "birth_month") as? String
         email = aDecoder.decodeObject(forKey: "email") as? String
         firstname = aDecoder.decodeObject(forKey: "firstname") as? String
         gender = aDecoder.decodeObject(forKey: "gender") as? String
         lastname = aDecoder.decodeObject(forKey: "lastname") as? String
         profileImage = aDecoder.decodeObject(forKey: "profile_image") as? String
         userId = aDecoder.decodeObject(forKey: "user_id") as? Int
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
		if birthDay != nil{
			aCoder.encode(birthDay, forKey: "birth_day")
		}
		if birthMonth != nil{
			aCoder.encode(birthMonth, forKey: "birth_month")
		}
		if email != nil{
			aCoder.encode(email, forKey: "email")
		}
		if firstname != nil{
			aCoder.encode(firstname, forKey: "firstname")
		}
		if gender != nil{
			aCoder.encode(gender, forKey: "gender")
		}
		if lastname != nil{
			aCoder.encode(lastname, forKey: "lastname")
		}
		if profileImage != nil{
			aCoder.encode(profileImage, forKey: "profile_image")
		}
		if userId != nil{
			aCoder.encode(userId, forKey: "user_id")
		}
		if username != nil{
			aCoder.encode(username, forKey: "username")
		}

	}

}