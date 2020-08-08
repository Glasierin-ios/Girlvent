//
//	ForumListData.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class ForumListData : NSObject, NSCoding{

	var firstname : String!
	var forumId : Int!
	var lastname : String!
	var postTime : String!
	var profileUrl : String!
	var replyCount : Int!
	var title : String!
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
		firstname = json["firstname"].stringValue
		forumId = json["forum_id"].intValue
		lastname = json["lastname"].stringValue
		postTime = json["post_time"].stringValue
		profileUrl = json["profile_url"].stringValue
		replyCount = json["reply_count"].intValue
		title = json["title"].stringValue
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
		if firstname != nil{
			dictionary["firstname"] = firstname
		}
		if forumId != nil{
			dictionary["forum_id"] = forumId
		}
		if lastname != nil{
			dictionary["lastname"] = lastname
		}
		if postTime != nil{
			dictionary["post_time"] = postTime
		}
		if profileUrl != nil{
			dictionary["profile_url"] = profileUrl
		}
		if replyCount != nil{
			dictionary["reply_count"] = replyCount
		}
		if title != nil{
			dictionary["title"] = title
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
         firstname = aDecoder.decodeObject(forKey: "firstname") as? String
         forumId = aDecoder.decodeObject(forKey: "forum_id") as? Int
         lastname = aDecoder.decodeObject(forKey: "lastname") as? String
         postTime = aDecoder.decodeObject(forKey: "post_time") as? String
         profileUrl = aDecoder.decodeObject(forKey: "profile_url") as? String
         replyCount = aDecoder.decodeObject(forKey: "reply_count") as? Int
         title = aDecoder.decodeObject(forKey: "title") as? String
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
		if firstname != nil{
			aCoder.encode(firstname, forKey: "firstname")
		}
		if forumId != nil{
			aCoder.encode(forumId, forKey: "forum_id")
		}
		if lastname != nil{
			aCoder.encode(lastname, forKey: "lastname")
		}
		if postTime != nil{
			aCoder.encode(postTime, forKey: "post_time")
		}
		if profileUrl != nil{
			aCoder.encode(profileUrl, forKey: "profile_url")
		}
		if replyCount != nil{
			aCoder.encode(replyCount, forKey: "reply_count")
		}
		if title != nil{
			aCoder.encode(title, forKey: "title")
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