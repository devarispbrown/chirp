//
//  Tweet.swift
//  chirp
//
//  Created by DeVaris Brown on 5/24/15.
//  Copyright (c) 2015 Furious One. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var user: User?
    var text: String?
    var tweetId: String?
    var createdAtString: String?
    var createdAt: NSDate?
    var displayDate: String?
    var retweeted: Bool?
    var favorited: Bool?
    
    init(dictionary: NSDictionary) {
        user = User(dictionary: dictionary["user"] as! NSDictionary)
        text = dictionary["text"] as? String
        createdAtString = dictionary["created_at"] as? String
        tweetId = dictionary["id_str"] as? String
        
        println(dictionary["favorited"]! as! Int)
        
        retweeted = ((dictionary["retweeted"]! as! Int) == 1)
        favorited = ((dictionary["favorited"]! as! Int) == 1)
        
        
        var formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        createdAt = formatter.dateFromString(createdAtString!)
        
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.FullStyle
        dateFormatter.timeStyle = .MediumStyle
//        dateFormatter.dateFormat = "EEEE MMMM d y"
        displayDate = dateFormatter.stringFromDate(createdAt!)
    }
    
    class func fromArray(array: [NSDictionary]) -> [Tweet] {
        return array.map { (dictionary: NSDictionary) -> Tweet in
            return Tweet(dictionary: dictionary)
        }
    }
}
