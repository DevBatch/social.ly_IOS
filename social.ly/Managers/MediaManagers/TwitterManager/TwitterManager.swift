//
//  TwitterManager.swift
//  SocialApp
//
//  Created by DB MAC MINI on 3/28/18.
//  Copyright © 2018 DB MAC MINI. All rights reserved.
//

import UIKit
import TwitterKit
import TwitterCore


let MediaEntities = "extended_entities"
let Medias = "media"
let MediaTypePhoto = "photo"

class PhotoObject : NSObject {
    var httpsURL : String?
    var httpURL : String?
    var thumbHttpsURL  : String?
    var thumbHttpURL : String?
    
    override init() {
        httpURL = ""
        httpsURL = ""
        thumbHttpURL = ""
        thumbHttpsURL = ""
    }
}

class TwitterManager: NSObject {

    
    public typealias completionHandler = ((TWTRSession?,Error?)->Void)?
   
    var photoObjects : [PhotoObject]?
    var screenName : String?
    var userID : String?
    var authToken : String?
    var maxID : String?
    var count : String?
    static var sharedInstance : TwitterManager =  {
        return TwitterManager()
    }()
    override init() {
        photoObjects  =  [PhotoObject]()
        authToken = TWTRTwitter.sharedInstance().sessionStore.session()?.authToken
        screenName = ""
        maxID = ""
        count = "5"
        userID = TWTRTwitter.sharedInstance().sessionStore.session()?.userID
    }
    func reloadPagesFromStart(){
        maxID = ""
        count = "5"
        photoObjects?.removeAll()
    }
    func twitterUserLoggedIn() -> Bool {
        if authToken?.count as! Int > 0 {
            return true
        }
        else{
            return false
        }
    }
    func login(vc : UIViewController , block : completionHandler)
    {
        TWTRTwitter.sharedInstance().logIn {
            (session, error) -> Void in
            
            if (session != nil) {
                self.screenName = session!.userName
                self.userID = session!.userID
                print("signed in as \(session!.userName)");
                block!(session,error )
            } else {
                block!(session,error )
                print("error: \(error?.localizedDescription)");
            }
        }
    }
    func fetchTweets(){
       
        var parameters : [String : String]!
        if (maxID?.count)! < 1 {
            parameters  = [  "user_id": userID!, "count" : count!]
        }
        else {
            parameters  = [  "user_id": userID!, "count" : count! ,"max_id" : maxID!]
        }
       
        var error : NSError?
        let req = TWTRAPIClient().urlRequest(withMethod: "GET", urlString: "https://api.twitter.com/1.1/statuses/user_timeline.json", parameters: parameters, error: &error)
        TWTRAPIClient().sendTwitterRequest(req, completion: { (response, data, error) in
            do {
                let response = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [[String : Any]]
                if response != nil {
                    print((response! as NSArray).debugDescription)
                    let timelineRespons : [[String : Any]] = response!
                    let lastObject =  timelineRespons[timelineRespons.count-1]
                  
                   
                    for twitterObject in timelineRespons {
                        if let mediaObject = twitterObject[MediaEntities]  //Checked in extended Entity now check in Entity as well
                        {
                            let medias = (mediaObject as! NSDictionary).object(forKey: Medias) as! NSArray
                            for media in medias {
                                if ((media as! NSDictionary).object(forKey: "type") as! String) == MediaTypePhoto {
                                    let photoObject : [String: Any] = media as! [String : Any]
                                    print("photo Object")
                                    let photo = PhotoObject()
                                    photo.httpsURL = photoObject["media_url_https"] as? String
                                    photo.httpURL = photoObject["media_url"] as? String
                                    photo.thumbHttpURL = (photoObject["media_url"] as? String)! + ":thumb"
                                    photo.thumbHttpsURL =  (photoObject["media_url_https"] as? String)! + ":thumb"
                                    self.photoObjects?.append(photo)
                                }
                                else {
                                    continue
                                }
                            }
                        }
                    }
                    
                    self.maxID = String((lastObject["id"] as! Int - 1))
                }
            }
            catch {
                print(error.localizedDescription)
            }
        })
    }
}
