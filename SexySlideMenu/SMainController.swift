//
//  SMainController.swift
//  SexySlideMenu
//
//  Created by YoonTaesup on 2015. 6. 24..
//  Copyright (c) 2015년 com.SexyDynamite. All rights reserved.
//

import UIKit

class SMainController: SexyMainController {
    
    override func viewDidLoadFinish() {
        super.viewDidLoadFinish()
    
        var randomNumber : Int = Int(rand()) % 6
        
        delegate?.setNaviTitle("title \(randomNumber)")
        delegate?.setHamburgerColor(getColor(randomNumber))
        self.view.backgroundColor = getColor(randomNumber)
    }
    
    func getColor(ran:Int) -> UIColor {
        switch (ran) {
        case 0:
            return UIColor.success
        case 1:
            return UIColor.error
        case 2:
            return UIColor.notice
        case 3:
            return UIColor.warning
        case 4:
            return UIColor.info
        default:
            return UIColor.navi

        }
    }
    
}