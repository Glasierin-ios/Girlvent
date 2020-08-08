//
//	UserMyVideoListData.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class UserMyVideoListData : NSObject, NSCoding{

	var postDetail : [UserMyVideoListPostDetail]!
	var userInfo : UserMyVideoListUserInfo!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		postDetail = [UserMyVideoListPostDetail]()
		let postDetailArray = json["post_detail"].arrayValue
		for postDetailJson in postDetailArray{
			let value = UserMyVideoListPostDetail(fromJson: postDetailJson)
			postDetail.append(value)
		}
		let userInfoJson = json["user_info"]
		if !userInfoJson.isEmpty{
			userInfo = UserMyVideoListUserInfo(fromJson: userInfoJson)
		}
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if postDetail != nil{
			var dictionaryElements = [[String:Any]]()
			for postDetailElement in postDetail {
				dictionaryElements.append(postDetailElement.toDictionary())
			}
			dictionary["post_detail"] = dictionaryElements
		}
		if userInfo != nil{
			dictionary["user_info"] = userInfo.toDictionary()
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         postDetail = aDecoder.decodeObject(forKey: "post_detail") as? [UserMyVideoListPostDetail]
         userInfo = aDecoder.decodeObject(forKey: "user_info") as? UserMyVideoListUserInfo

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
	{
		if postDetail != nil{
			aCoder.encode(postDetail, forKey: "post_detail")
		}
		if userInfo != nil{
			aCoder.encode(userInfo, forKey: "user_info")
		}

	}

}