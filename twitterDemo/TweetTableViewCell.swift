//
//  TweetTableViewCell.swift
//  twitterDemo
//
//  Created by victor aguirre on 3/27/16.
//  Copyright © 2016 victor aguirre. All rights reserved.
//

import UIKit
import AFNetworking

class TweetTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var screennameLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var replyImageView: UIImageView!
    @IBOutlet weak var retweetImageView: UIImageView!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var likeImageView: UIImageView!
    @IBOutlet weak var likeCountLabel: UILabel!
    
    var tweet: Tweet! {
        didSet{
           
            if let tweetText = tweet.text as? String {
                tweetTextLabel.text = tweetText
            }
            
            profileImageView.setImageWithURL(tweet.profileImageUrl!)
            profileImageView.layer.cornerRadius = 5
            profileImageView.clipsToBounds = true
            
            if let name = tweet.name as? String {
                nameLabel.text = name
            }
            if let screenName = tweet.screenName as? String {
                screennameLabel.text = "@\(screenName)"
            }
            
            timestampLabel.text = tweet.calculateTime()

            replyImageView.image = UIImage(named:"reply_off")
            
       
            retweetCountLabel.text = "\(tweet.retweetCount)"
            if tweet.retweetCount > 0 {
                retweetImageView.image = UIImage(named:"retweet_on")
            } else {
                retweetImageView.image = UIImage(named:"retweet_off")
            }
            

            likeCountLabel.text = "\(tweet.favoritesCount)"
            let favorited = tweet.favorited! as Bool
            if tweet.favoritesCount > 0 {
                if favorited == true {
                    likeImageView.image = UIImage(named:"liked")
                } else {
                    likeImageView.image = UIImage(named:"like_on")
                }
            } else {
                likeImageView.image = UIImage(named:"like_off")
            }
            
            
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    


}
