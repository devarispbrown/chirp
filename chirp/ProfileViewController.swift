//
//  ProfileViewController.swift
//  chirp
//
//  Created by DeVaris Brown on 5/24/15.
//  Copyright (c) 2015 Furious One. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var taglineLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var friendsCountLabel: UILabel!
    @IBOutlet weak var followersCountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var currentUser = User.currentUser!
        nameLabel.text = currentUser.name
        screenNameLabel.text = "@" + currentUser.screenName!
        taglineLabel.text = currentUser.tagline
        locationLabel.text = currentUser.location
        friendsCountLabel.text = "\(currentUser.friendsCount!)"
        followersCountLabel.text = "\(currentUser.followersCount!)"
        bannerImageView.setImageWithURL(NSURL(string: currentUser.profileBannerUrl!)!)
        profileImageView.setImageWithURL(NSURL(string: currentUser.profileImageUrl!)!)
        profileImageView.layer.cornerRadius = 5
        profileImageView.layer.borderColor = UIColor.whiteColor().CGColor
        profileImageView.layer.borderWidth = 3
        profileImageView.clipsToBounds = true

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogout(sender: AnyObject) {
        User.currentUser?.logout()
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
