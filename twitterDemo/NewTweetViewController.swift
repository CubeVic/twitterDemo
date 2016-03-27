//
//  NewTweetViewController.swift
//  twitterDemo
//
//  Created by victor aguirre on 3/27/16.
//  Copyright © 2016 victor aguirre. All rights reserved.
//

import UIKit

@objc protocol NewTweetViewControllerDelegate {
    optional func newTweet(newTweetViewController: NewTweetViewController, didUpdateTweet newTweet: Tweet)
}

class NewTweetViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var newTweetTextField: UITextView!
    @IBOutlet weak var wordCounterLabel: UILabel!
    var numberCharacters: Int!
    
    weak var delegate: NewTweetViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newTweetTextField.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textViewDidChange(textView: UITextView) {
        let text = newTweetTextField.text
        numberCharacters = text.characters.count
        wordCounterLabel.text = String (format: "%03d / 140", numberCharacters)
        
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        newTweetTextField.text = nil
        wordCounterLabel.text = "000 / 140"
    }
    

    @IBAction func onSendNewTweet(sender: AnyObject) {
        TwitterClient.sharedInstance.postNewTweet(newTweetTextField.text, success: { (NewTweet: Tweet) -> () in
            self.delegate?.newTweet!(self, didUpdateTweet: NewTweet)
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
