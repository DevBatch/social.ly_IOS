//
//  UnsplashManager.swift
//  SocialApp
//
//  Created by DB MAC MINI on 4/11/18.
//  Copyright © 2018 DB MAC MINI. All rights reserved.
//

import UIKit
import Alamofire
let ClientID : String = "df799d8cfbd18e0a8aba393acd10773f62dbcbd7c9c1743f60e304735ea90254"
let Query : String = "wallpaper"
let BaseURL : String = "http://api.unsplash.com/"

let requestUrl : String = "search/photos"


class UnsplashImage : SLPhoto {

}

class UnsplashManager: NSObject {

    public typealias resultBlock = ((Bool,[UnsplashImage]) -> Void)?
  
    var unsplashImagesArray : [UnsplashImage]? = [UnsplashImage]()
    static var sharedInstance : UnsplashManager =  {
        return UnsplashManager()
    }()
    
    
    var totalNumberOfPages : Int = -1
    var itemsPerPage : Int = 25
    var currentPage : Int = 1
    
    func fetchImages(block : resultBlock ){
        let parameters : [String : String] = ["page" : String(currentPage), "per_page" : String(itemsPerPage),"query": Query,"client_id" : ClientID]
        let requestString : String = BaseURL + requestUrl
        Alamofire.request(requestString, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: [:]) .validate()
            .responseJSON { (result) in
                switch result.result {
                case .success(let value ):
                    self.saveAndParseData(object: value as? [String : Any])
                    block!(true,self.unsplashImagesArray!)
                    break
                case .failure(_ ):
                    block!(false,self.unsplashImagesArray!)
                    break
                    
                }

        }
    }
    func areThereAnyImagesLeft()-> Bool{
        if totalNumberOfPages >= 0 {
            if currentPage < totalNumberOfPages {
                return true
            }
            else {
                return false
            }
        }
        else {
            return true
        }
    }
    func saveAndParseData(object : [String : Any]?){
    if let _ = object!["total_pages"]  {
        self.totalNumberOfPages = object!["total_pages"]! as! Int
        }
    
        let imagesArray = object!["results"]! as? [[String: Any]]
        if imagesArray != nil {
            for imageObject in imagesArray! {
                let unsplashImageObject = UnsplashImage()
                if let urls : [String : String] = imageObject["urls"] as? [String : String] {
                    unsplashImageObject.thumbnailURL  = urls["small"]
                    unsplashImageObject.completeURL = urls["full"]
            
                    unsplashImageObject.mediaType = .unSplash
                    unsplashImagesArray?.append(unsplashImageObject)
                }
            }
            currentPage += 1
        }
        
    }
   
}
