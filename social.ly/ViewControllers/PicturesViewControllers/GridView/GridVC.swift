//
//  GridVC.swift
//  social.ly
//
//  Created by DB MAC MINI on 4/19/18.
//  Copyright © 2018 DB MAC MINI. All rights reserved.
//

import UIKit
import AFNetworking
import TRMosaicLayout
import MJRefresh

private let reuseIdentifier = "TRMosaicCell"

protocol GridDelegate : AnyObject {
    func fetchMoreImagesFromSDK()
    func fetchLatestDataFromSDK()
}
class GridVC: UICollectionViewController {

    var books = [String]()

    var picturesArray : [SLPhoto?] = [SLPhoto]()
    
    weak var delegate : GridDelegate?
    @IBOutlet weak var listCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.showGrid()
        self.collectionView!.mj_header = MJRefreshNormalHeader.init(refreshingTarget: self, refreshingAction:  #selector(GridVC.headerRefresh))
        self.collectionView!.mj_header.isAutomaticallyChangeAlpha = true;
        self.collectionView!.mj_footer = MJRefreshBackNormalFooter.init(refreshingTarget: self, refreshingAction:  #selector(GridVC.footerRefresh))
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: CollectionViewDelegates
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return picturesArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        let slImage : SLPhoto? = self.picturesArray[indexPath.row]
        
        let cellImageView : UIImageView? = cell.viewWithTag(1000) as? UIImageView
        let imageView = UIImageView()
        cellImageView?.setImageWith(URL(string: (slImage?.thumbnailURL)!)!, placeholderImage: #imageLiteral(resourceName: "placeholder"))
        imageView.frame = cell.frame
        
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let slPhotoObject = self.picturesArray[indexPath.row]?.copy(with: nil) as? SLPhoto
        self.performSegue(withIdentifier: "goToLockScreenPreview", sender: slPhotoObject)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToLockScreenPreview" {
            let lockScreen = segue.destination as? LockScreenPreviewVC
            lockScreen?.selectedImagge = sender as? SLPhoto
        }
    }
    func showGrid(){
        UIView.animate(withDuration: 0.2) { () -> Void in
            self.collectionView?.collectionViewLayout.invalidateLayout()
            self.collectionView?.setCollectionViewLayout(ProductsGridFlowLayout(), animated: true)
        }
    }
    func showList(){
        UIView.animate(withDuration: 0.2) { () -> Void in
            self.collectionView?.collectionViewLayout.invalidateLayout()
            self.collectionView?.setCollectionViewLayout(ProductsListFlowLayout(), animated: true)
        }
    }
    // MARK: Refresh Functions
    @objc func headerRefresh(){
    self.delegate?.fetchLatestDataFromSDK()
    }
    
    @objc func footerRefresh(){
        self.delegate?.fetchMoreImagesFromSDK()
    }
    
    // MARK: ParentViewController
    
    
    func loadMoreDataFromSDK() {
        self.collectionView?.mj_footer.endRefreshing()
        self.collectionView?.reloadData()
    }
    
    func loadGridRecentFetchedData(){
        self.collectionView?.mj_header.endRefreshing()
        self.collectionView?.reloadData()
    }
}




