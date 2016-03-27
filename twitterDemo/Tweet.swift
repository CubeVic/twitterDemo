//
//  Tweet.swift
//  twitterDemo
//
//  Created by victor aguirre on 3/26/16.
//  Copyright © 2016 victor aguirre. All rights reserved.
//

import UIKit


class Tweet: NSObject {
    // 1. get the properties
    
    var profileImageUrl: NSURL?
    var user: NSDictionary?
    var name: NSString?
    var screenName: NSString?
    var text: NSString?
    var timestamp: NSDate?
    var retweetCount: Int = 0
    var favoritesCount: Int = 0
    var favorited: Bool?
    
    //2.  build the constructor.
    init(dictionary: NSDictionary) {
        
        let user = dictionary["user"] as! NSDictionary
        let profileImageString = user["profile_image_url"] as! String
        profileImageUrl = NSURL(string: profileImageString)
        name = user["name"] as? String
        text = dictionary["text"] as? String
        screenName = user["screen_name"] as? String
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoritesCount = (dictionary["favorite_count"] as? Int) ?? 0
        favorited = dictionary["favorited"] as! Bool
        
        let timestampString = dictionary["created_at"] as? String
        
        if let timestampString = timestampString{
            let formatter = NSDateFormatter()
            formatter.dateFormat = "EEE MM d HH:mm:ss Z y"
            timestamp = formatter.dateFromString(timestampString)
        }
        
    }
    
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet]{
        var tweets = [Tweet]()
        
        for dictionary in dictionaries {
            let tweet = Tweet(dictionary: dictionary)
            tweets.append(tweet)
        }
        
        return tweets
    }
}
