//
//	UserMyVideoListPostDetail.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class UserMyVideoListPostDetail : NSObject, NSCoding{

	var media : String!
	var postId : Int!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		media = json["media"].stringValue
		postId = json["post_id"].intValue
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if media != nil{
			dictionary["media"] = media
		}
		if postId != nil{
			dictionary["post_id"] = postId
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         media = aDecoder.decodeObject(forKey: "media") as? String
         postId = aDecoder.decodeObject(forKey: "post_id") as? Int

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
	{
		if media != nil{
			aCoder.encode(media, forKey: "media")
		}
		if postId != nil{
			aCoder.encode(postId, forKey: "post_id")
		}

	}

}