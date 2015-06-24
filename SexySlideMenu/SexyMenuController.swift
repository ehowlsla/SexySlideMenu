//
//  SexyMenuController.swift
//  SexySlideMenu
//
//  Created by YoonTaesup on 2015. 6. 24..
//  Copyright (c) 2015년 com.SexyDynamite. All rights reserved.
//

import UIKit

class SWMenuController: UIViewController {
    
    var delegate: SexySlideMoveProtocolDelegate?
    
    
    func mainViewController(controller:SexyMainController, animated: Bool) {
        delegate?.rootViewController(controller, animated: animated)
    }
    
    func goAuthSend(sender: UIButton) {
        //        mainViewController(UIPhoneAuthController(), animated: true)
    }
    
}

