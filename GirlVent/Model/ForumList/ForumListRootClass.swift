//
//	ForumListRootClass.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class ForumListRootClass : NSObject, NSCoding{

	var data : [ForumListData]!
	var error : Int!
	var message : String!
	var status : Bool!
	var userType : Int!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		data = [ForumListData]()
		let dataArray = json["data"].arrayValue
		for dataJson in dataArray{
			let value = ForumListData(fromJson: dataJson)
			data.append(value)
		}
		error = json["error"].intValue
		message = json["message"].stringValue
		status = json["status"].boolValue
		userType = json["user_type"].intValue
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if data != nil{
			var dictionaryElements = [[String:Any]]()
			for dataElement in data {
				dictionaryElements.append(dataElement.toDictionary())
			}
			dictionary["data"] = dictionaryElements
		}
		if error != nil{
			dictionary["error"] = error
		}
		if message != nil{
			dictionary["message"] = message
		}
		if status != nil{
			dictionary["status"] = status
		}
		if userType != nil{
			dictionary["user_type"] = userType
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         data = aDecoder.decodeObject(forKey: "data") as? [ForumListData]
         error = aDecoder.decodeObject(forKey: "error") as? Int
         message = aDecoder.decodeObject(forKey: "message") as? String
         status = aDecoder.decodeObject(forKey: "status") as? Bool
         userType = aDecoder.decodeObject(forKey: "user_type") as? Int

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
	{
		if data != nil{
			aCoder.encode(data, forKey: "data")
		}
		if error != nil{
			aCoder.encode(error, forKey: "error")
		}
		if message != nil{
			aCoder.encode(message, forKey: "message")
		}
		if status != nil{
			aCoder.encode(status, forKey: "status")
		}
		if userType != nil{
			aCoder.encode(userType, forKey: "user_type")
		}

	}

}