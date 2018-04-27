//
//  ViewController.swift
//  social.ly
//
//  Created by DB MAC MINI on 4/16/18.
//  Copyright © 2018 DB MAC MINI. All rights reserved.
//

import UIKit

class HomeVC: BaseViewController , BaseViewControllerDelegate , SlidingContainerViewControllerDelegate{
    
    var fbVC : FacebookVC?
    var googleVC : GoogleVC?
    var instaVC : InstaVC?
    var twitterVC1 : TwitterVC?
    var twitterVC : TwitterVC?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupNavigationBarTitleForHome("Search", showRightButton: true, leftButtonType: .menu, showPenultimateRightButton : true ,penultimateButtonType : .list, rightButtonType: .grid, rightButtonText: "")
        self.initPager()
        self.view.backgroundColor = UIColor.clear
    
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.baseDelegate = self
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
     
    }

    func leftNavigationBarButtonClicked() {
         self.sideMenuController?.showLeftViewAnimated()
    }
    func rightNavigationBarButtonClicked() {
         NotificationCenter.default.post(name: NSNotification.Name(rawValue : NSNotificationString.GridButtonTapped), object: self, userInfo: nil)
    }
    func penultimateRightNavigationBarButtonClicked() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue : NSNotificationString.ListButtonTapped), object: self, userInfo: nil)
    }

    //MARK: ViewCycle
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    func initPager(){
        fbVC = viewControllerWithIdentifier( identifier : "FacebookVC") as? FacebookVC
        googleVC = viewControllerWithIdentifier( identifier : "GoogleVC") as? GoogleVC
        instaVC = viewControllerWithIdentifier(identifier : "InstaVC") as? InstaVC
        twitterVC1 = viewControllerWithIdentifier(identifier : "TwitterVC") as? TwitterVC
        twitterVC = viewControllerWithIdentifier(identifier : "TwitterVC") as? TwitterVC
        
        
        let slidingContainerViewController = SlidingContainerViewController (
            parent: self,
            contentViewControllers: [fbVC!, googleVC!, instaVC!, twitterVC1!,twitterVC!],
            imageNames: ["facebook", "google", "insta", "twitter","twitter"])
        
        view.addSubview(slidingContainerViewController.view)
        
        slidingContainerViewController.sliderView.appearance.outerPadding = 0
        slidingContainerViewController.sliderView.appearance.innerPadding = 50
        slidingContainerViewController.sliderView.appearance.fixedWidth = true
        slidingContainerViewController.sliderView.sliderHeight = CGFloat(SwipeView.swipeViewHeight)
        slidingContainerViewController.sliderView.appearance.selectorColor = Color.lightBackground.value
        slidingContainerViewController.sliderView.appearance.selectorHeight = CGFloat(5.0)
        slidingContainerViewController.setCurrentViewControllerAtIndex(0)
        slidingContainerViewController.delegate = self

    }
    func viewControllerWithIdentifier ( identifier: String) -> UIViewController {
         let storyBoard : UIStoryboard =  UIStoryboard(name: "Main", bundle: nil)
        let vc : UIViewController = storyBoard.instantiateViewController(withIdentifier: identifier)
        
        vc.view.backgroundColor = UIColor.clear
        let label = UILabel (frame: CGRect(x:0,y: 30, width : 330 , height : 400))
        label.backgroundColor = UIColor.white
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.font = UIFont (name: "HelveticaNeue-Light", size: 25)
        label.text = identifier
        
        label.sizeToFit()
        label.center = view.center
        
        vc.view.addSubview(label)
        
        return vc
    }
    
    // MARK: SlidingContainerViewControllerDelegate
    
    func slidingContainerViewControllerDidMoveToViewController(_ slidingContainerViewController: SlidingContainerViewController, viewController: UIViewController, atIndex: Int) {
        viewController.viewWillAppear(true)
        
    }
    
    func slidingContainerViewControllerDidShowSliderView(_ slidingContainerViewController: SlidingContainerViewController) {
        
    }
    
    func slidingContainerViewControllerDidHideSliderView(_ slidingContainerViewController: SlidingContainerViewController) {
        
    }

}

