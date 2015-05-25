//
//  TweetDetailViewController.swift
//  chirp
//
//  Created by DeVaris Brown on 5/24/15.
//  Copyright (c) 2015 Furious One. All rights reserved.
//

import UIKit

class TweetDetailViewController: UIViewController {
    var tweet: Tweet!

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var screenName: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tweetLabel.text = tweet.text
        userImage.setImageWithURL(NSURL(string: tweet.user!.profileImageUrl!))
        
        userName.text = tweet.user?.name
        screenName.text = "@\(tweet.user!.screenName!)"
        timeLabel.text = tweet.displayDate

        // Do any additional setup after loading the view.
        navigationItem.backBarButtonItem?.title = "Back"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func replyAction(sender: AnyObject) {
        performSegueWithIdentifier("tweetComposeFromDetail", sender: self)
    }
    
    @IBAction func retweetAction(sender: AnyObject) {
        var button = sender as! UIButton
        
        if(tweet.retweeted!) {
            return
        }
        
        TwitterClient.sharedInstance.retweet(tweet.tweetId!, completion: { (error) -> Void in
            if(error == nil) {
                button.imageView!.image = UIImage(named: "retweet_on.png")
            } else {
                println(error)
            }
        })
        
    }
    @IBAction func favoriteAction(sender: AnyObject) {
        var button = sender as! UIButton
        
        if(tweet.favorited!) {
            return
        }
        
        TwitterClient.sharedInstance.favorite(tweet.tweetId!, completion: { (error) -> Void in
            if(error == nil) {
                button.imageView!.image = UIImage(named: "favorite_on.png")
            } else {
                println(error)
            }
        })
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var vc = segue.destinationViewController as! NewTweetViewController
        vc.tweetText = "@\(tweet.user!.screenName!): "
    }
}
