//
//  InitialVC.swift
//  social.ly
//
//  Created by DB MAC MINI on 4/16/18.
//  Copyright © 2018 DB MAC MINI. All rights reserved.
//

import UIKit
import LGSideMenuController

class InitialVC: LGSideMenuController {

    override func viewDidLoad() {
        super.viewDidLoad()
 
        self.view.backgroundColor = .blue
        // Do any additional setup after loading the view.
        self.leftViewWidth = UIScreen.main.bounds.size.width * 0.75
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

}
