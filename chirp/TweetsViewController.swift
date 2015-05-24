//
//  TweetsViewController.swift
//  chirp
//
//  Created by DeVaris Brown on 5/24/15.
//  Copyright (c) 2015 Furious One. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tweetsTableView: UITableView!
    
    var refreshControl: UIRefreshControl!
    
    var tweets: [Tweet] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "refreshTweets", forControlEvents: UIControlEvents.ValueChanged)
        
        tweetsTableView.addSubview(refreshControl)
        
        fetchTweets(nil)
        
        tweetsTableView.delegate = self
        tweetsTableView.dataSource = self
        tweetsTableView.rowHeight = UITableViewAutomaticDimension
        tweetsTableView.estimatedRowHeight = 50.0
        
        NSNotificationCenter.defaultCenter().addObserverForName("status-posted", object: nil, queue: nil) { (notification: NSNotification!) -> Void in
            self.fetchTweets(nil)
        }
        
        navigationController!.navigationItem.leftBarButtonItem?.title = ""
        navigationController!.navigationItem.leftBarButtonItem?.style = UIBarButtonItemStyle.Plain

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("TweetCell") as! TweetCell
        var tweet = tweets[indexPath.row]
        var user = tweet.user!
        
        cell.tweetLabel.text = tweet.text
        cell.tweetLabel.preferredMaxLayoutWidth = 200.0
        
        cell.nameLabel.text = user.name!
        cell.screenNameLabel.text = user.screenName!
        cell.userImageView.setImageWithURL(NSURL(string: user.profileImageUrl!)!)
        cell.timeLabel.text = tweet.createdAt!.shortTimeAgoSinceNow()
                
        return cell
    }
    
    func fetchTweets(completion: (() -> Void)?) {
        TwitterClient.sharedInstance.homeTimeline() { (tweets: [Tweet]?, error: NSError?) in
            if(tweets != nil) {
                self.tweets = tweets!
                self.tweetsTableView.reloadData()
            } else {
                println("ERROR:\(error!)")
            }
            
            if(completion != nil) {
                completion!()
            }
        }
    }
    
    func refreshTweets() {
        fetchTweets() { () -> Void in
            self.refreshControl.endRefreshing()
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
