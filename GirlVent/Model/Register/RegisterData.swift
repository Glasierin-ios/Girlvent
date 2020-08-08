//
//	RegisterData.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class RegisterData : NSObject, NSCoding{

	var active : Int!
	var bio : String!
	var birthDate : String!
	var createdAt : String!
	var email : String!
	var firstname : String!
	var fullName : String!
	var genderId : String!
	var id : Int!
	var lastname : String!
	var profilePicUrl : String!
	var updatedAt : String!
	var userTypeId : Int!
	var username : String!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		active = json["active"].intValue
		bio = json["bio"].stringValue
		birthDate = json["birth_date"].stringValue
		createdAt = json["created_at"].stringValue
		email = json["email"].stringValue
		firstname = json["firstname"].stringValue
		fullName = json["fullName"].stringValue
		genderId = json["gender_id"].stringValue
		id = json["id"].intValue
		lastname = json["lastname"].stringValue
		profilePicUrl = json["profilePicUrl"].stringValue
		updatedAt = json["updated_at"].stringValue
		userTypeId = json["user_type_id"].intValue
		username = json["username"].stringValue
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if active != nil{
			dictionary["active"] = active
		}
		if bio != nil{
			dictionary["bio"] = bio
		}
		if birthDate != nil{
			dictionary["birth_date"] = birthDate
		}
		if createdAt != nil{
			dictionary["created_at"] = createdAt
		}
		if email != nil{
			dictionary["email"] = email
		}
		if firstname != nil{
			dictionary["firstname"] = firstname
		}
		if fullName != nil{
			dictionary["fullName"] = fullName
		}
		if genderId != nil{
			dictionary["gender_id"] = genderId
		}
		if id != nil{
			dictionary["id"] = id
		}
		if lastname != nil{
			dictionary["lastname"] = lastname
		}
		if profilePicUrl != nil{
			dictionary["profilePicUrl"] = profilePicUrl
		}
		if updatedAt != nil{
			dictionary["updated_at"] = updatedAt
		}
		if userTypeId != nil{
			dictionary["user_type_id"] = userTypeId
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
         active = aDecoder.decodeObject(forKey: "active") as? Int
         bio = aDecoder.decodeObject(forKey: "bio") as? String
         birthDate = aDecoder.decodeObject(forKey: "birth_date") as? String
         createdAt = aDecoder.decodeObject(forKey: "created_at") as? String
         email = aDecoder.decodeObject(forKey: "email") as? String
         firstname = aDecoder.decodeObject(forKey: "firstname") as? String
         fullName = aDecoder.decodeObject(forKey: "fullName") as? String
         genderId = aDecoder.decodeObject(forKey: "gender_id") as? String
         id = aDecoder.decodeObject(forKey: "id") as? Int
         lastname = aDecoder.decodeObject(forKey: "lastname") as? String
         profilePicUrl = aDecoder.decodeObject(forKey: "profilePicUrl") as? String
         updatedAt = aDecoder.decodeObject(forKey: "updated_at") as? String
         userTypeId = aDecoder.decodeObject(forKey: "user_type_id") as? Int
         username = aDecoder.decodeObject(forKey: "username") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
	{
		if active != nil{
			aCoder.encode(active, forKey: "active")
		}
		if bio != nil{
			aCoder.encode(bio, forKey: "bio")
		}
		if birthDate != nil{
			aCoder.encode(birthDate, forKey: "birth_date")
		}
		if createdAt != nil{
			aCoder.encode(createdAt, forKey: "created_at")
		}
		if email != nil{
			aCoder.encode(email, forKey: "email")
		}
		if firstname != nil{
			aCoder.encode(firstname, forKey: "firstname")
		}
		if fullName != nil{
			aCoder.encode(fullName, forKey: "fullName")
		}
		if genderId != nil{
			aCoder.encode(genderId, forKey: "gender_id")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if lastname != nil{
			aCoder.encode(lastname, forKey: "lastname")
		}
		if profilePicUrl != nil{
			aCoder.encode(profilePicUrl, forKey: "profilePicUrl")
		}
		if updatedAt != nil{
			aCoder.encode(updatedAt, forKey: "updated_at")
		}
		if userTypeId != nil{
			aCoder.encode(userTypeId, forKey: "user_type_id")
		}
		if username != nil{
			aCoder.encode(username, forKey: "username")
		}

	}

}