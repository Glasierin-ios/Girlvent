//
//	AllUserListData.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class AllUserListData : NSObject, NSCoding{

	var firstname : String!
	var lastname : String!
	var useId : Int!
	var username : String!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		firstname = json["firstname"].stringValue
		lastname = json["lastname"].stringValue
		useId = json["use_id"].intValue
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
		if lastname != nil{
			dictionary["lastname"] = lastname
		}
		if useId != nil{
			dictionary["use_id"] = useId
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
         lastname = aDecoder.decodeObject(forKey: "lastname") as? String
         useId = aDecoder.decodeObject(forKey: "use_id") as? Int
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
		if lastname != nil{
			aCoder.encode(lastname, forKey: "lastname")
		}
		if useId != nil{
			aCoder.encode(useId, forKey: "use_id")
		}
		if username != nil{
			aCoder.encode(username, forKey: "username")
		}

	}

}