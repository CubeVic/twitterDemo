//
//  TwitterClient.swift
//  twitterDemo
//
//  Created by victor aguirre on 3/26/16.
//  Copyright © 2016 victor aguirre. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {
    
    
    static let sharedInstance = TwitterClient(baseURL: NSURL(string: "https://api.twitter.com")!, consumerKey: "q3279OPiKcIn9XlDrt7hf09h9", consumerSecret: "aFpHSKRAZ2CvqzNVKUwVCdEMcxVBDGennZKKswm4L0MLi17JQo")
    
    var loginSuccess: (() -> ())?
    var loginFailure: ((NSError!) -> ())?
    
    func login(success: () -> () ,failure: (NSError!) -> ()) {
        
        loginSuccess = success
        loginFailure = failure
        
        //Clear the session
        TwitterClient.sharedInstance.deauthorize()
        
        // request the access token
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("/oauth/request_token", method: "GET", callbackURL: NSURL(string: "twitterDemo://oauth")!, scope: nil, success: { (requestToken: BDBOAuth1Credential!) -> Void in
            let url = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")!
            UIApplication.sharedApplication().openURL(url)
            
            }) { (error: NSError!) -> Void in
                print("error: \(error.localizedDescription)")
                self.loginFailure?(error)
        }
    
    }
    
    func logout(){
        User.currentUser = nil
        deauthorize()
        NSNotificationCenter.defaultCenter().postNotificationName(User.userDidLogoutNotification, object: nil)
    }
    
    func handleOpenUrl(url: NSURL){
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken: BDBOAuth1Credential!) -> Void in
            
            
            self.currentAccount({ (user: User) -> () in
                
                User.currentUser = user
                self.loginSuccess?()
            
            }, failure: { (error: NSError) -> () in
                self.loginFailure?(error)
            })
            
            }) { (error: NSError!) -> Void in
                self.loginFailure?(error)
            }
    }
    
    
    func homeTimeline(success: ([Tweet]) -> (), failure: (NSError) -> ()){
        
        // get the time line, the tweets in the account
        GET("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            let dictionaries = response as! [NSDictionary]
            let tweets = Tweet.tweetsWithArray(dictionaries)
            success(tweets)
            
            }, failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                print("error: \(error.localizedDescription)")
        })

    }
    
    func currentAccount(success: (User)->(), failure: (NSError) -> ()) {
        // get the information from the current account
        GET("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            let userDictionary = response as! NSDictionary
            let user = User(dictionary: userDictionary)
            
            success(user)
            
            }, failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
             failure(error)
        })
    }
    
    func postNewTweet(status: String, success: Tweet -> (), failure: (NSError) -> ()) {
        let param = ["status": status]
        POST("1.1/statuses/update.json", parameters: param, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            let dictionary = response as! NSDictionary
            let newTweet = Tweet(dictionary: dictionary)
            success(newTweet)
            
            }) { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                print("error: \(error.localizedDescription)")
        }
    }
}
