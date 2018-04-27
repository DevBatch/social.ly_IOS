//
//  SideMenuVC.swift
//  social.ly
//
//  Created by DB MAC MINI on 4/16/18.
//  Copyright © 2018 DB MAC MINI. All rights reserved.
//

import UIKit

class SideMenuVC: UIViewController , UITableViewDelegate, UITableViewDataSource {
    
    static let HOME = "Home"
    static let DISCOVERWALLPAPERS = "Discover Wallpapers"
    static let SOCIALCONNECTS = "Social Connects"
    static let MYGALLERY = "My Gallery"
    static let FAVORITE = "Favorite"
    static let SETTINGS = "Settings"
    static let HELP = "Help"
    static let INFO = "Info"
    let titleArray : [String?] = [HOME,DISCOVERWALLPAPERS,SOCIALCONNECTS,MYGALLERY,FAVORITE,SETTINGS,HELP,INFO]
    
    @IBOutlet weak var menuTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

     self.menuTableView.backgroundColor = Color.intermidiateBackground.value 
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - TableView Functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SideMenuCell") as! SideMenuCell
        cell.titleLabel.text = titleArray[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mainViewController = sideMenuController!
        let navigationController = mainViewController.rootViewController as! UINavigationController
        let storyBoard : UIStoryboard =  UIStoryboard(name: "Main", bundle: nil)
        
        if ((titleArray as NSArray).object(at: indexPath.row) as? String == SideMenuVC.HOME)
        {
            goToHome(storyBoard : storyBoard , navigationController: navigationController )
        }
        else if ((titleArray as NSArray).object(at: indexPath.row) as? String == SideMenuVC.DISCOVERWALLPAPERS)
        {
            discoverWallpers(storyBoard : storyBoard , navigationController: navigationController )
        }
        else if ((titleArray as NSArray).object(at: indexPath.row) as? String == SideMenuVC.SOCIALCONNECTS)
        {
            socialConnects(storyBoard : storyBoard , navigationController: navigationController )
        }
        else if ((titleArray as NSArray).object(at: indexPath.row) as? String == SideMenuVC.MYGALLERY)
        {
            myGallery(storyBoard : storyBoard , navigationController: navigationController )
            
        }
            
        else if  ((titleArray as NSArray).object(at: indexPath.row) as? String == SideMenuVC.FAVORITE)
        {
            favorites(storyBoard : storyBoard , navigationController: navigationController )
            
        }
            
        else if ((titleArray as NSArray).object(at: indexPath.row) as? String == SideMenuVC.SETTINGS)
        {
            settings(storyBoard : storyBoard , navigationController: navigationController )
            
        }
        else if ((titleArray as NSArray).object(at: indexPath.row) as? String == SideMenuVC.HELP)
        {
             help(storyBoard : storyBoard , navigationController: navigationController )
            
        }
        else if ((titleArray as NSArray).object(at: indexPath.row) as? String == SideMenuVC.INFO)
        {
            info(storyBoard : storyBoard , navigationController: navigationController )
            
        }
        
        //
        
        mainViewController.hideLeftView(animated: true, completionHandler: nil)
    }

    
    func goToHome(storyBoard : UIStoryboard , navigationController : UINavigationController)
    {
        
        let vc :HomeVC = storyBoard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        navigationController.viewControllers = [vc];
    }
    func discoverWallpers(storyBoard : UIStoryboard , navigationController : UINavigationController)
    {
        let vc : DiscoverWallpapersVC = storyBoard.instantiateViewController(withIdentifier: "DiscoverWallpapersVC") as! DiscoverWallpapersVC
        navigationController.viewControllers = [vc];
//        let vc : PictureVC = storyBoard.instantiateViewController(withIdentifier: "PictureVC") as! PictureVC
//        navigationController.viewControllers = [vc];
    }
    
    func socialConnects(storyBoard : UIStoryboard , navigationController : UINavigationController)
    {
        let vc : SocialConnectsVC = storyBoard.instantiateViewController(withIdentifier: "SocialConnectsVC") as! SocialConnectsVC
        navigationController.viewControllers = [vc];
    }
    func myGallery(storyBoard : UIStoryboard , navigationController : UINavigationController)
    {
    }
    func favorites(storyBoard : UIStoryboard , navigationController : UINavigationController)
    {
        let vc : FavoriteVC = storyBoard.instantiateViewController(withIdentifier: "FavoriteVC") as! FavoriteVC
        navigationController.viewControllers = [vc];
    }
    func settings(storyBoard : UIStoryboard , navigationController : UINavigationController)
    {
        let vc : SettingsVC = storyBoard.instantiateViewController(withIdentifier: "SettingsVC") as! SettingsVC
        navigationController.viewControllers = [vc];
    }
    func help(storyBoard : UIStoryboard , navigationController : UINavigationController)
    {
        let vc : HelpVC = storyBoard.instantiateViewController(withIdentifier: "HelpVC") as! HelpVC
        navigationController.viewControllers = [vc];
    }
    func info(storyBoard : UIStoryboard , navigationController : UINavigationController)
    {
        let vc : InfoVC = storyBoard.instantiateViewController(withIdentifier: "InfoVC") as! InfoVC
        navigationController.viewControllers = [vc];
    }
}
