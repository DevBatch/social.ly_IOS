		//
//  BaseViewController.swift
//  <#Project Name#>
//
//  Created by <#Project Developer#> on 29/02/2016.
//  Copyright © 2016 <#Project Name#>. All rights reserved.
//
import Foundation
import UIKit


        
enum UINavigationBarRightButtonType : Int {
    case none
    case done
    case list
    case text
    case grid
    case settings
}

enum UINavigationBarLeftButtonType : Int {
    case none
    case back
    case menu
    case camera
}

protocol BaseViewControllerDelegate {
    func rightNavigationBarButtonClicked()
    func penultimateRightNavigationBarButtonClicked()
    func leftNavigationBarButtonClicked()
}
open class BaseViewController: UIViewController {
    var baseDelegate: BaseViewControllerDelegate?
    var leftButton: UIButton?
    var rightButton: UIButton?
    var penultimateRightButton : UIButton?
    
    var penultimateRightBtnItem : UIBarButtonItem?
    var rightbtnItem: UIBarButtonItem?
    var leftbtnItem:  UIBarButtonItem?
    var leftbtnType:  UINavigationBarLeftButtonType?
    var rightbtnType: UINavigationBarRightButtonType?
  
    //    var mySearchBar  : UISearchBar?
   
    
    
    func setupNavigationBarTitleForHome(_ title: String, showRightButton: Bool, leftButtonType: UINavigationBarLeftButtonType, showPenultimateRightButton : Bool, penultimateButtonType : UINavigationBarRightButtonType,rightButtonType: UINavigationBarRightButtonType, rightButtonText : String) {
        self.hideNavigationBar(false)
        self.leftbtnType = leftButtonType
        self.rightbtnType = rightButtonType
    
        if showRightButton {
            self.rightButton = UIButton.init(type: UIButtonType.custom)

            
            self.rightButton = UIButton.init(type: UIButtonType.custom)
            let menuImage: UIImage? = ((rightButtonType == .settings) ? UIImage(named: "camera") : (rightButtonType == .grid) ? UIImage(named: "grid_selected") : nil)
            
            self.rightButton!.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
            self.rightButton!.addTarget(self, action: #selector(BaseViewController.rightNavigationButtonClicked(_:)), for: .touchUpInside)
            self.rightButton!.setImage(menuImage, for: .normal)
            self.rightButton!.setImage(#imageLiteral(resourceName: "grid"), for: .selected)
           self.rightButton!.isSelected = true

            self.rightbtnItem = UIBarButtonItem(customView: self.rightButton!)
           var negativeSpacer : UIBarButtonItem? = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
            
            self.navigationItem.setRightBarButtonItems([negativeSpacer!, rightbtnItem!], animated: false)
            
            self.leftButton = UIButton.init(type: UIButtonType.custom)
            
            self.leftButton!.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
            self.leftButton!.addTarget(self, action: #selector(BaseViewController.leftNavigationButtonClicked(_:)), for: .touchUpInside)
            self.leftButton!.setImage(#imageLiteral(resourceName: "list_selected"), for: .selected)
            self.leftButton!.setImage(#imageLiteral(resourceName: "list"), for: .normal)
            self.leftbtnItem = UIBarButtonItem(customView: self.leftButton!)
             negativeSpacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
            self.navigationItem.setLeftBarButtonItems([negativeSpacer!, self.leftbtnItem!], animated: false)
    
            self.penultimateRightButton = UIButton.init(type: UIButtonType.custom)
            self.penultimateRightButton!.addTarget(self, action: #selector(BaseViewController.penultimateButtonClicked(_:)), for: .touchUpInside)
            self.penultimateRightButton?.setTitle("", for: .normal)
            self.penultimateRightButton?.contentMode = .scaleAspectFit
         
            self.penultimateRightButton!.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
            self.penultimateRightButton!.setImage(#imageLiteral(resourceName: "list_selected"), for: .normal)
            self.penultimateRightButton!.setImage(#imageLiteral(resourceName: "list"), for: .selected)
            self.penultimateRightBtnItem = UIBarButtonItem(customView: penultimateRightButton!)
         
            negativeSpacer  = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
            
            self.navigationItem.setRightBarButtonItems([negativeSpacer!,rightbtnItem!,penultimateRightBtnItem!], animated: false)
        }
        
        if title.count > 0 {
            let lbNavTitle = UILabel (frame: CGRect(x: 0, y: 40, width: 320, height: 40))
            lbNavTitle.center = CGPoint(x: 160, y: 285)
            lbNavTitle.textAlignment = .left
            lbNavTitle.text = title
            lbNavTitle.textColor = UIColor.white
            self.navigationItem.titleView = lbNavTitle
            
           
        }
        self.navigationController?.navigationBar.barTintColor =  Color.darkBackground.value
        
    }
    
    
    func setNavigationBarTitle(title: String)
    {
        self.navigationItem.title = title
    }
    func setupNavigationBarWithTitleImage(_ imageName: String, showBackButtonIfNeeded show: Bool) {
        self.hideNavigationBar(false)
        let barImageView: UIImageView = UIImageView(image: UIImage(named: imageName))
        self.navigationItem.titleView = barImageView
        
    }
    func changeButtonColor(_ color: UIColor) {
        self.leftButton!.backgroundColor = color
    }
    @available(iOS, deprecated: 9.0)
    func hideStatusBar(_ hide: Bool) {
        
        UIApplication.shared.setStatusBarHidden(hide, with: .none)
        
    }
    
    func hideNavigationBar(_ hide: Bool) {
        if self.navigationController != nil {
            self.navigationController!.isNavigationBarHidden = hide
        }
        
    }
    
    func goBackToIndex(_ backIndex: Int) {
        self.goBackToIndex(backIndex, animated: true)
    }
    
    func goBackToIndex(_ backIndex: Int, animated animate: Bool) {
        if (self.navigationController!.viewControllers.count - backIndex) > 0 {
            let controller: BaseViewController = (self.navigationController!.viewControllers[(self.navigationController!.viewControllers.count - 1 - backIndex)] as! BaseViewController)
            self.navigationController!.popToViewController(controller, animated: animate)
        }
    }
    
   
    
    override  open func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.baseDelegate = nil
    }
    //
    
    @objc func rightNavigationButtonClicked(_ sender: AnyObject) {
        NSLog("Right Navigation Button Clicked")
        if (sender.isSelected){
             return
           // self.rightButton?.isSelected = false
        }
        else {
            self.rightButton?.isSelected = true
        }
        self.penultimateRightButton?.isSelected = false
        self.baseDelegate?.rightNavigationBarButtonClicked()
    }
    @objc func penultimateButtonClicked(_ sender: AnyObject){
        if (sender.isSelected){
            return
            //self.penultimateRightButton?.isSelected = false
        }
        else {
            self.penultimateRightButton?.isSelected = true
        }
        self.rightButton?.isSelected = false
        self.baseDelegate?.penultimateRightNavigationBarButtonClicked()
    }
    
    @objc func leftNavigationButtonClicked(_ sender: AnyObject) {
        NSLog("Left Navigation Button Clicked")
        print(self.baseDelegate ?? "no func")
        self.baseDelegate?.leftNavigationBarButtonClicked()
    }
    
    func btnMenuClicked() {
        
    }
    
    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
   
    
    func hideLeftButton()  {
       self.navigationItem.setHidesBackButton(true, animated:true);
    }
   
    func hideNavBarBottomLine(show : Bool)
    {
        self.navigationController?.navigationBar.setValue(show, forKey: "hidesShadow")

    }
    func changeTitleOfRightButton(text : String){
        self.rightButton?.setTitle(text, for: UIControlState())
    }
    func setNavigaionBarColorTransparent(){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
    }
    func setNavigationBarColor(color : UIColor){
        UINavigationBar.appearance().barTintColor = .black
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().isTranslucent = false
    }
    
    
}
