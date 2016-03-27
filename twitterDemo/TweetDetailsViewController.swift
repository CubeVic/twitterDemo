//
//  TweetDetailsViewController.swift
//  twitterDemo
//
//  Created by victor aguirre on 3/27/16.
//  Copyright © 2016 victor aguirre. All rights reserved.
//

import UIKit

@objc protocol TweetDetailsViewControllerDelegate {
    optional func newRetweet(tweetDetailsViewController: TweetDetailsViewController, didRetweet newRetweet: Tweet)
}

class TweetDetailsViewController: UIViewController {

    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screennameLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    
    var tweet: Tweet!
    
    weak var delegate: TweetDetailsViewControllerDelegate?
    
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
        
        timestampLabel.text = tweet.calculateTime()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onReTweet(sender: AnyObject) {
        let statusId = Int(tweet.statusId as! String)
        TwitterClient.sharedInstance.retweetWithCompletion(statusId!, success: { (newRetweet: Tweet) -> () in
           self.delegate?.newRetweet!(self, didRetweet: newRetweet)
           self.navigationController?.popToRootViewControllerAnimated(true)
        }) { (error: NSError) -> () in
            print("error: \(error.localizedDescription)")
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
