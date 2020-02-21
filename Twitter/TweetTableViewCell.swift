//
//  TweetTableViewCell.swift
//  Twitter
//
//  Created by Samuel Elbaz on 2/14/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {

    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var tweetTimeLabel: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    var retweeted:Bool = false
    var favorited:Bool = false
    var tweetId:Int = -1
    
    func setFavorite(_ isFavorited:Bool) {
        favorited = isFavorited
        if(favorited) {
            favButton.setImage(UIImage(named: "favor-icon-red"), for: UIControl.State.normal)
        } else{
            favButton.setImage(UIImage(named: "favor-icon-1"), for: UIControl.State.normal)

        }
    }
    @IBAction func favoriteTweet(_ sender: Any) {
        let toBeFavorited = !favorited
        if(toBeFavorited) {
            TwitterAPICaller.client?.postFavoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(true)
            }, failure: { (error) in
                print("Favorite did not succeed: \(error)")
            })
        } else {
            TwitterAPICaller.client?.postUnFavoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(false)
            }, failure: { (error) in
                print ("unFavorite did not succeed: \(error)")
            })
        }
        
        
    }
    
    func setRetweet(_ isRetweeted:Bool) {
        retweeted = isRetweeted
        if(retweeted) {
            retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: UIControl.State.normal)
        } else{
            retweetButton.setImage(UIImage(named: "retweet-icon"), for: UIControl.State.normal)

        }
    }
    
    
    @IBAction func retweet(_ sender: Any) {
        let toBeRetweeted = !retweeted
        if(toBeRetweeted) {
            TwitterAPICaller.client?.retweet(tweetId: tweetId, success: {
                self.setRetweet(true)
            }, failure: { (error) in
                print ("retweet did not succeed: \(error)")
            })
        } else{
            TwitterAPICaller.client?.unRetweet(tweetId: tweetId, success: {
                self.setRetweet(false)
            }, failure: { (error) in
                print ("unretweet did not succeed: \(error)")
            })
        }
        
        
    }
}
