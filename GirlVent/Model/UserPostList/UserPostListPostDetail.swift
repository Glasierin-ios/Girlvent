//
//	UserPostListPostDetail.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class UserPostListPostDetail : NSObject, NSCoding{

	var categoryId : String!
	var categoryName : String!
	var commentCount : Int!
	var content : String!
	var createdAt : String!
	var firstname : String!
	var lastname : String!
	var media : String!
	var postId : Int!
	var postTime : String!
	var profileUrl : String!
	var token : String!
	var type : String!
	var userId : Int!
	var username : String!
	var youtube : String!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		categoryId = json["category_id"].stringValue
		categoryName = json["category_name"].stringValue
		commentCount = json["comment_count"].intValue
		content = json["content"].stringValue
		createdAt = json["created_at"].stringValue
		firstname = json["firstname"].stringValue
		lastname = json["lastname"].stringValue
		media = json["media"].stringValue
		postId = json["post_id"].intValue
		postTime = json["post_time"].stringValue
		profileUrl = json["profile_url"].stringValue
		token = json["token"].stringValue
		type = json["type"].stringValue
		userId = json["user_id"].intValue
		username = json["username"].stringValue
		youtube = json["youtube"].stringValue
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if categoryId != nil{
			dictionary["category_id"] = categoryId
		}
		if categoryName != nil{
			dictionary["category_name"] = categoryName
		}
		if commentCount != nil{
			dictionary["comment_count"] = commentCount
		}
		if content != nil{
			dictionary["content"] = content
		}
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
		if postId != nil{
			dictionary["post_id"] = postId
		}
		if postTime != nil{
			dictionary["post_time"] = postTime
		}
		if profileUrl != nil{
			dictionary["profile_url"] = profileUrl
		}
		if token != nil{
			dictionary["token"] = token
		}
		if type != nil{
			dictionary["type"] = type
		}
		if userId != nil{
			dictionary["user_id"] = userId
		}
		if username != nil{
			dictionary["username"] = username
		}
		if youtube != nil{
			dictionary["youtube"] = youtube
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         categoryId = aDecoder.decodeObject(forKey: "category_id") as? String
         categoryName = aDecoder.decodeObject(forKey: "category_name") as? String
         commentCount = aDecoder.decodeObject(forKey: "comment_count") as? Int
         content = aDecoder.decodeObject(forKey: "content") as? String
         createdAt = aDecoder.decodeObject(forKey: "created_at") as? String
         firstname = aDecoder.decodeObject(forKey: "firstname") as? String
         lastname = aDecoder.decodeObject(forKey: "lastname") as? String
         media = aDecoder.decodeObject(forKey: "media") as? String
         postId = aDecoder.decodeObject(forKey: "post_id") as? Int
         postTime = aDecoder.decodeObject(forKey: "post_time") as? String
         profileUrl = aDecoder.decodeObject(forKey: "profile_url") as? String
         token = aDecoder.decodeObject(forKey: "token") as? String
         type = aDecoder.decodeObject(forKey: "type") as? String
         userId = aDecoder.decodeObject(forKey: "user_id") as? Int
         username = aDecoder.decodeObject(forKey: "username") as? String
         youtube = aDecoder.decodeObject(forKey: "youtube") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
	{
		if categoryId != nil{
			aCoder.encode(categoryId, forKey: "category_id")
		}
		if categoryName != nil{
			aCoder.encode(categoryName, forKey: "category_name")
		}
		if commentCount != nil{
			aCoder.encode(commentCount, forKey: "comment_count")
		}
		if content != nil{
			aCoder.encode(content, forKey: "content")
		}
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
		if postId != nil{
			aCoder.encode(postId, forKey: "post_id")
		}
		if postTime != nil{
			aCoder.encode(postTime, forKey: "post_time")
		}
		if profileUrl != nil{
			aCoder.encode(profileUrl, forKey: "profile_url")
		}
		if token != nil{
			aCoder.encode(token, forKey: "token")
		}
		if type != nil{
			aCoder.encode(type, forKey: "type")
		}
		if userId != nil{
			aCoder.encode(userId, forKey: "user_id")
		}
		if username != nil{
			aCoder.encode(username, forKey: "username")
		}
		if youtube != nil{
			aCoder.encode(youtube, forKey: "youtube")
		}

	}

}