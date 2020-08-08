//
//	GetMyMessageListData.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class GetMyMessageListData : NSObject, NSCoding{

	var myMessages : [GetMyMessageListMyMessage]!
	var userInfo : GetMyMessageListUserInfo!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		myMessages = [GetMyMessageListMyMessage]()
		let myMessagesArray = json["my_messages"].arrayValue
		for myMessagesJson in myMessagesArray{
			let value = GetMyMessageListMyMessage(fromJson: myMessagesJson)
			myMessages.append(value)
		}
		let userInfoJson = json["user_info"]
		if !userInfoJson.isEmpty{
			userInfo = GetMyMessageListUserInfo(fromJson: userInfoJson)
		}
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if myMessages != nil{
			var dictionaryElements = [[String:Any]]()
			for myMessagesElement in myMessages {
				dictionaryElements.append(myMessagesElement.toDictionary())
			}
			dictionary["my_messages"] = dictionaryElements
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
         myMessages = aDecoder.decodeObject(forKey: "my_messages") as? [GetMyMessageListMyMessage]
         userInfo = aDecoder.decodeObject(forKey: "user_info") as? GetMyMessageListUserInfo

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
	{
		if myMessages != nil{
			aCoder.encode(myMessages, forKey: "my_messages")
		}
		if userInfo != nil{
			aCoder.encode(userInfo, forKey: "user_info")
		}

	}

}