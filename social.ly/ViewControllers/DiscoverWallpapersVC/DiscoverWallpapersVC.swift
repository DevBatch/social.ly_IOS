//
//  DiscoverWallpapersVC.swift
//  social.ly
//
//  Created by DB MAC MINI on 4/16/18.
//  Copyright © 2018 DB MAC MINI. All rights reserved.
//

import UIKit

class DiscoverWallpapersVC: BaseViewController , BaseViewControllerDelegate  , PictureDelegate{
    
    

    var pictureVC : PictureVC?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.addChild()
        self.pictureVC?.delegate = self
        self.setupNavigationBarTitleForHome("Search", showRightButton: true, leftButtonType: .menu, showPenultimateRightButton : true ,penultimateButtonType : .list, rightButtonType: .grid, rightButtonText: "")
        self.fetchDataFromUnSplash()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.baseDelegate = self
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func leftNavigationBarButtonClicked() {
        self.sideMenuController?.showLeftViewAnimated()
    }
    func rightNavigationBarButtonClicked() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue : NSNotificationString.GridButtonTapped), object: self, userInfo: nil)
    }
    func penultimateRightNavigationBarButtonClicked() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue : NSNotificationString.ListButtonTapped), object: self, userInfo: nil)
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
    func fetchDataFromUnSplash(){
        UnsplashManager.sharedInstance.currentPage = 1
        UnsplashManager.sharedInstance.unsplashImagesArray?.removeAll()
        UnsplashManager.sharedInstance.fetchImages { [unowned self]  (result, imagesArray) in
            if result {
                self.pictureVC?.dataSourceArray = imagesArray
                self.pictureVC?.loadRecentFetchedData()
             
            }
            else {
                // some error occured
            }
        }
    }
    //MARK: Activities without HUD
    
    func fetchDataFromUnSplashWithoutProgress(){
        UnsplashManager.sharedInstance.currentPage = 1
        UnsplashManager.sharedInstance.unsplashImagesArray?.removeAll()
        UnsplashManager.sharedInstance.fetchImages { [unowned self]  (result, imagesArray) in
            if result {
                self.pictureVC?.dataSourceArray = imagesArray
                self.pictureVC?.loadRecentFetchedData()
                
            }
            else {
                
            }
        }
    }
    
    func loadMoreUnSplashData (){
        UnsplashManager.sharedInstance.fetchImages { [unowned self]  (result, imagesArray) in
            if result {
                    self.pictureVC?.dataSourceArray = imagesArray
                    self.pictureVC?.loadMoreDataAtBottom()
            }
            else {
                // some error occured
            }
        }
    }
    // MARK: PictureClass Delegate
    
    func fetchLatestDataFromSDK() {
        self.fetchDataFromUnSplashWithoutProgress()
    }
    
    func fetchMoreDataFromSDK() {
        self.loadMoreUnSplashData()
    }
}
