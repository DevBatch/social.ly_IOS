//
//  PictureVC.swift
//  social.ly
//
//  Created by DB MAC MINI on 4/19/18.
//  Copyright © 2018 DB MAC MINI. All rights reserved.
//

import UIKit

protocol PictureDelegate : AnyObject {
    func fetchMoreDataFromSDK()
    func fetchLatestDataFromSDK()
}

class PictureVC: UIViewController , GridDelegate {

    var dataSourceArray : [SLPhoto?] = [SLPhoto]()
    var gridVC : GridVC?
  
    
    weak var delegate : PictureDelegate?
    
  
    @IBOutlet weak var gridView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.clear
        self.addChild()
        self.registerForNotification()
    }

    func registerForNotification(){
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.showList), name: NSNotification.Name(rawValue: NSNotificationString.ListButtonTapped), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.showGrid), name: NSNotification.Name(rawValue: NSNotificationString.GridButtonTapped), object: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func addChild(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        gridVC = storyboard.instantiateViewController(withIdentifier: "GridVC") as? GridVC;
        gridVC?.delegate = self
        gridVC?.view.frame = self.gridView.bounds
        addChildViewController(gridVC!);
        self.gridView.addSubview((gridVC?.view)!)
        gridVC?.didMove(toParentViewController: self)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
         gridVC?.view.frame = self.gridView.bounds
    }

    // MARK: Handle Appearence of Grid or List
    
    @objc func showGrid(){
      self.gridVC?.showGrid()
        
    }
    @objc func showList(){
        self.gridVC?.showList()

    }
    
    //MARK: Child Class askign for data
    
    func fetchLatestDataFromSDK() {
        self.delegate?.fetchLatestDataFromSDK()
    }
    func fetchMoreImagesFromSDK() {
        self.delegate?.fetchMoreDataFromSDK()
    }
    
    //MARK: ParentClass (SOcial SDK) replyingBack
    func loadRecentFetchedData(){
        self.gridVC?.picturesArray = self.dataSourceArray
        self.gridVC?.loadGridRecentFetchedData()
        
    }
    func loadMoreDataAtBottom(){
         self.gridVC?.picturesArray = self.dataSourceArray
        self.gridVC?.loadMoreDataFromSDK()
    }
}
