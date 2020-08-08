//
//	GetCommentListData.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class GetCommentListData : NSObject, NSCoding{

	var comment : String!
	var commentId : Int!
	var firstname : String!
	var lastname : String!
	var postId : Int!
	var postTime : String!
	var profileUrl : String!
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
		comment = json["comment"].stringValue
		commentId = json["comment_id"].intValue
		firstname = json["firstname"].stringValue
		lastname = json["lastname"].stringValue
		postId = json["post_id"].intValue
		postTime = json["post_time"].stringValue
		profileUrl = json["profile_url"].stringValue
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
		if comment != nil{
			dictionary["comment"] = comment
		}
		if commentId != nil{
			dictionary["comment_id"] = commentId
		}
		if firstname != nil{
			dictionary["firstname"] = firstname
		}
		if lastname != nil{
			dictionary["lastname"] = lastname
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
         comment = aDecoder.decodeObject(forKey: "comment") as? String
         commentId = aDecoder.decodeObject(forKey: "comment_id") as? Int
         firstname = aDecoder.decodeObject(forKey: "firstname") as? String
         lastname = aDecoder.decodeObject(forKey: "lastname") as? String
         postId = aDecoder.decodeObject(forKey: "post_id") as? Int
         postTime = aDecoder.decodeObject(forKey: "post_time") as? String
         profileUrl = aDecoder.decodeObject(forKey: "profile_url") as? String
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
		if comment != nil{
			aCoder.encode(comment, forKey: "comment")
		}
		if commentId != nil{
			aCoder.encode(commentId, forKey: "comment_id")
		}
		if firstname != nil{
			aCoder.encode(firstname, forKey: "firstname")
		}
		if lastname != nil{
			aCoder.encode(lastname, forKey: "lastname")
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
		if userId != nil{
			aCoder.encode(userId, forKey: "user_id")
		}
		if username != nil{
			aCoder.encode(username, forKey: "username")
		}

	}

}