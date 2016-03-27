//
//  TweetsViewController.swift
//  twitterDemo
//
//  Created by victor aguirre on 3/26/16.
//  Copyright © 2016 victor aguirre. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NewTweetViewControllerDelegate {
    
    var tweets: [Tweet]!

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "refreshControlAction:", forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)
        
        TwitterClient.sharedInstance.homeTimeline({ (tweets: [Tweet]) -> () in
            
            self.tweets = tweets
            
            self.tableView.reloadData()
//            for tweet in tweets {
//             print(tweet.text)
//            }
            }) { (error: NSError) -> () in
            print("error: \(error.localizedDescription)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onLogOut(sender: AnyObject) {
        TwitterClient.sharedInstance.logout()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetTableViewCell
        //cell.tweet = tweets[indexPath.row]
        let tweet = tweets[indexPath.row]
        cell.tweet = tweet
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "newTweetSegue" {
            
            if let destinationViewController = segue.destinationViewController as? NewTweetViewController {
               destinationViewController.delegate = self
            }
            
        } else if segue.identifier == "TweetDetails" {
            
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPathForCell(cell)
            let vc = segue.destinationViewController as! TweetDetailsViewController
            vc.tweet = tweets[indexPath!.row]
        
        }
    }
    
    func newTweet(newTweetViewController: NewTweetViewController, didUpdateTweet newTweet: Tweet) {
        tweets.insert(newTweet, atIndex: 0)
        tableView.reloadData()
    }
    

    func refreshControlAction(refreshControl: UIRefreshControl) {
        TwitterClient.sharedInstance.homeTimeline({ (tweets:[Tweet]) -> () in
            print("im refreshing ")
            self.tweets = tweets
            self.tableView.reloadData()
            refreshControl.endRefreshing()
        
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
