//
//  LockScreenPreviewVC.swift
//  social.ly
//
//  Created by DB MAC MINI on 4/24/18.
//  Copyright © 2018 DB MAC MINI. All rights reserved.
//

import UIKit
import AFNetworking
class LockScreenPreviewVC: UIViewController {

    var selectedImagge : SLPhoto?
    
    @IBOutlet weak var homeScreenImageView: UIImageView!
    @IBOutlet weak var lockScreenImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.showLockScreen()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: Display images
    func showHomeScreen(){
        
    }
    func  showLockScreen(){
        homeScreenImageView?.setImageWith(URL(string: (selectedImagge?.completeURL)!)!, placeholderImage: #imageLiteral(resourceName: "placeholder"))
        lockScreenImageView?.setImageWith(URL(string: (selectedImagge?.completeURL)!)!, placeholderImage: #imageLiteral(resourceName: "placeholder"))
    }

}
