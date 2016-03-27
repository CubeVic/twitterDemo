//
//  TweetDetailsViewController.swift
//  twitterDemo
//
//  Created by victor aguirre on 3/27/16.
//  Copyright © 2016 victor aguirre. All rights reserved.
//

import UIKit

class TweetDetailsViewController: UIViewController {

    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screennameLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    
    var tweet: Tweet!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let text = tweet.text as? String {
            tweetTextLabel.text = text
        }
        
        if let name = tweet.name as? String {
            nameLabel.text = "\(name)"
        }
        profileImageView.setImageWithURL(tweet.profileImageUrl!)
        profileImageView.layer.cornerRadius = 5
        profileImageView.clipsToBounds = true
        
        if let screenname = tweet.screenName as? String {
            screennameLabel.text = "@\(screenname)"
        }
        
        timestampLabel.text = calculateTime(NSDate().timeIntervalSinceDate(tweet.timestamp!))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func calculateTime(timestamp: NSTimeInterval) -> String {
        
        let ti = NSInteger(timestamp)
        let minutes = (ti / 60) % 60
        let hours = (ti / 3600)
        
        if minutes > 0 && hours <= 0 {
            return String(format: "%0.1dm",minutes)
        } else if (hours < 24 || hours > 0) {
            return String(format: "%0.2dh", hours)
        } else if (minutes == 0 && hours == 0){
            return "seconds"
        } else {
            return "\(hours/86400)d"
        }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
