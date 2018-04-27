//
//  GoogleVC.swift
//  social.ly
//
//  Created by DB MAC MINI on 4/18/18.
//  Copyright © 2018 DB MAC MINI. All rights reserved.
//

import UIKit

class GoogleVC: UIViewController , PictureDelegate{

    var pictureVC : PictureVC?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addChild()
        
        self.pictureVC?.delegate = self
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func addChild(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        pictureVC = storyboard.instantiateViewController(withIdentifier: "PictureVC") as? PictureVC;
        let bounds = self.view.bounds
        pictureVC?.view.frame = bounds
        addChildViewController(pictureVC!);
        self.view.addSubview((pictureVC?.view)!)
        pictureVC?.didMove(toParentViewController: self)
    }
    override func viewDidLayoutSubviews() {
      let bounds = self.view.bounds
      
        pictureVC?.view.frame =  bounds
    }
    
    // MARK: PictureClass Delegate
    
    func fetchLatestDataFromSDK() {
        
    }
    
    func fetchMoreDataFromSDK() {
        
    }
    
    // BlurView
    func addViewOnWindow(){
        let connectView: BlurView? = Bundle.main.loadNibNamed("BlurView",
                                                              owner: nil,
                                                              options: nil)?.first as! BlurView?
        
        let window : UIWindow? = UIApplication.shared.keyWindow
        connectView?.frame = (window?.frame)!
        window?.addSubview(connectView!)
    }
}
