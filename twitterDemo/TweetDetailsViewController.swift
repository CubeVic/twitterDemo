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
        tweetTextLabel.text = tweet.text as! String
        nameLabel.text = tweet.name as! String
        profileImageView.setImageWithURL(tweet.profileImageUrl!)
        profileImageView.layer.cornerRadius = 5
        profileImageView.clipsToBounds = true
        screennameLabel.text = tweet.screenName as! String
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
