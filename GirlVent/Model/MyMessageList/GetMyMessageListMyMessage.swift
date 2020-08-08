//
//	GetMyMessageListMyMessage.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class GetMyMessageListMyMessage : NSObject, NSCoding{

	var createdAt : String!
	var firstname : String!
	var lastname : String!
	var media : String!
	var message : String!
	var messageId : Int!
	var profileUrl : String!
	var thumbnail : String!
	var token : String!
	var userId : Int!
	var username : String!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		createdAt = json["created_at"].stringValue
		firstname = json["firstname"].stringValue
		lastname = json["lastname"].stringValue
		media = json["media"].stringValue
		message = json["message"].stringValue
		messageId = json["message_id"].intValue
		profileUrl = json["profile_url"].stringValue
		thumbnail = json["thumbnail"].stringValue
		token = json["token"].stringValue
		userId = json["user_id"].intValue
		username = json["username"].stringValue
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if createdAt != nil{
			dictionary["created_at"] = createdAt
		}
		if firstname != nil{
			dictionary["firstname"] = firstname
		}
		if lastname != nil{
			dictionary["lastname"] = lastname
		}
		if media != nil{
			dictionary["media"] = media
		}
		if message != nil{
			dictionary["message"] = message
		}
		if messageId != nil{
			dictionary["message_id"] = messageId
		}
		if profileUrl != nil{
			dictionary["profile_url"] = profileUrl
		}
		if thumbnail != nil{
			dictionary["thumbnail"] = thumbnail
		}
		if token != nil{
			dictionary["token"] = token
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
         createdAt = aDecoder.decodeObject(forKey: "created_at") as? String
         firstname = aDecoder.decodeObject(forKey: "firstname") as? String
         lastname = aDecoder.decodeObject(forKey: "lastname") as? String
         media = aDecoder.decodeObject(forKey: "media") as? String
         message = aDecoder.decodeObject(forKey: "message") as? String
         messageId = aDecoder.decodeObject(forKey: "message_id") as? Int
         profileUrl = aDecoder.decodeObject(forKey: "profile_url") as? String
         thumbnail = aDecoder.decodeObject(forKey: "thumbnail") as? String
         token = aDecoder.decodeObject(forKey: "token") as? String
         userId = aDecoder.decodeObject(forKey: "user_id") as? Int
         username = aDecoder.decodeObject(forKey: "username") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
	{
		if createdAt != nil{
			aCoder.encode(createdAt, forKey: "created_at")
		}
		if firstname != nil{
			aCoder.encode(firstname, forKey: "firstname")
		}
		if lastname != nil{
			aCoder.encode(lastname, forKey: "lastname")
		}
		if media != nil{
			aCoder.encode(media, forKey: "media")
		}
		if message != nil{
			aCoder.encode(message, forKey: "message")
		}
		if messageId != nil{
			aCoder.encode(messageId, forKey: "message_id")
		}
		if profileUrl != nil{
			aCoder.encode(profileUrl, forKey: "profile_url")
		}
		if thumbnail != nil{
			aCoder.encode(thumbnail, forKey: "thumbnail")
		}
		if token != nil{
			aCoder.encode(token, forKey: "token")
		}
		if userId != nil{
			aCoder.encode(userId, forKey: "user_id")
		}
		if username != nil{
			aCoder.encode(username, forKey: "username")
		}

	}

}