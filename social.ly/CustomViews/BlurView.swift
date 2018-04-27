//
//  BlurView.swift
//  social.ly
//
//  Created by DB MAC MINI on 4/26/18.
//  Copyright © 2018 DB MAC MINI. All rights reserved.
//

import UIKit

class BlurView: UIView {

    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var navBarView: UIView!
   
    override func draw(_ rect: CGRect) {
                self.navBarView.backgroundColor = Color.darkBackground.value
    }
    

    
    @IBAction func leftNavigationBarButtonClicked(_ sender: Any) {
    }
}
