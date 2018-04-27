//
//  SLPhoto.swift
//  social.ly
//
//  Created by DB MAC MINI on 4/20/18.
//  Copyright © 2018 DB MAC MINI. All rights reserved.
//

import UIKit
enum MediaTypes {
    case google
    case facebook
    case unSplash
    case twitter
    case instagram
    case none
}
class SLPhoto: NSObject , NSCopying {

    var completeURL : String?
    var thumbnailURL : String?
    var mediaType : MediaTypes?
    
    override init() {
        super.init()
        self.completeURL = ""
        self.thumbnailURL = ""
        self.mediaType = .none
    }
    init(completeObjectURL : String? = "", thumbURL : String? = "", media : MediaTypes? = .none) {
        self.completeURL = completeObjectURL
        self.thumbnailURL = thumbURL
        self.mediaType = media
    }
    func copy(with zone: NSZone? = nil) -> Any {
        let copy = SLPhoto(completeObjectURL: completeURL, thumbURL: thumbnailURL, media: mediaType)
        return copy
    }

    
    
}
