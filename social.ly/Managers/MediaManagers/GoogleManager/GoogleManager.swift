//
//  GoogleManager.swift
//  SocialApp
//
//  Created by DB MAC MINI on 3/30/18.
//  Copyright © 2018 DB MAC MINI. All rights reserved.
//

import UIKit
import GoogleSignIn
import GoogleAPIClientForREST

let kClientID = "186192802631-8okni7ctqcjjeb8oqudgjrfenmipe7ag.apps.googleusercontent.com";


struct Paging {
    var firstObjectID : String? = ""
    var lastObjectID : String? = ""
    var count : Int? = 0
    var nextPageToken : String? = ""
}

class GooogleImage : NSObject {
    var fileName : String? = ""
    var itemID : String? = ""
    var thumbnailURL : String? = ""
    var weblinkURL : String? = ""
}
protocol GoogleSiginInDelegate: class {
    func signedInSuccessfully(user: GIDGoogleUser!)
    func signinFailledWithError(error : Error?)
}
class GoogleManager: NSObject  {

    var pageObject : Paging?
    var googleImages : [GooogleImage?] = [GooogleImage?]()
    
    weak var googleDelegate : GoogleSiginInDelegate?
    let scopes = [kGTLRAuthScopeDriveReadonly]
    let service = GTLRDriveService()
    let signInButton = GIDSignInButton()
    
    
    static var sharedInstance : GoogleManager =  {
       
        return GoogleManager()
    }()
    override init() {
        super.init()
        self.pageObject = Paging()
       
        
    }
    func onLaunchOptions(){
         GIDSignIn.sharedInstance().clientID = kClientID
    }
    
    //MARK: Google Delegates
    func listFiles() {
        if (self.pageObject?.nextPageToken?.count)! > Int(0) {
            self.loadMorePictures()
        }
        else {
        let query = GTLRDriveQuery_FilesList.query()
        
       // query.pageSize = 200
        service.shouldFetchNextPages = false;
        
        query.q = "trashed = false and (mimeType contains 'image/')";
        query.fields = ("nextPageToken, files(id, name, size, thumbnailLink, webContentLink)")
        service.executeQuery(query,
                             delegate: self,
                             didFinish: #selector(displayResultWithTicket(ticket:finishedWithObject:error:))
          
        
        )
        }
    }
    
    @objc func displayResultWithTicket(ticket: GTLRServiceTicket,
                                 finishedWithObject result : GTLRDrive_FileList,
                                 error : NSError?) {
        
        if error != nil {
           
            return
        }
        if result.nextPageToken != nil {
       
            self.pageObject?.nextPageToken = result.nextPageToken
        }
        
        var text = "";
        if let files = result.files, !files.isEmpty {
            if fetchedDataAlreadyExists(files : result.files!) {
                return;
            }
            self.pageObject?.firstObjectID = result.files?.first?.identifier
            self.pageObject?.lastObjectID  = result.files?[ (result.files?.count)! - 1].identifier
            self.pageObject?.count = result.files?.count
            text += "Files:\n"
            for file in files {
                text += "\(file.name!) (\(file.identifier!))\n"
                let googleImage = GooogleImage()
                googleImage.fileName = file.name
                googleImage.itemID = file.identifier
                googleImage.thumbnailURL = file.thumbnailLink
                googleImage.weblinkURL = file.webContentLink
                googleImages.append(googleImage)
            }
        } else {
            text += "No files found."
        }
       
    }
    func fetchedDataAlreadyExists(files : [GTLRDrive_File]) -> Bool{
        var objectExist = false
        if files.count > 0 {
        if (self.pageObject?.firstObjectID) != nil {
            if ( (self.pageObject?.firstObjectID == files.first?.identifier) && ( self.pageObject?.lastObjectID  == files[ (files.count) - 1].identifier ) && (self.pageObject?.count == files.count ))
            {
                objectExist = true
            }
          
            
        }
        }
        return objectExist
    }
    func loadMorePictures(){
        let query = GTLRDriveQuery_FilesList.query()
        query.pageToken = self.pageObject?.nextPageToken
        service.shouldFetchNextPages = false;
        
        query.q = "trashed = false and (mimeType contains 'image/')";
        query.fields = ("nextPageToken, files(id, name, size, thumbnailLink, webContentLink)")
        service.executeQuery(query,
                             delegate: self,
                             didFinish: #selector(displayResultWithTicket(ticket:finishedWithObject:error:))
            
        )
    }
    
}
