//
//  SexyMainController.swift
//  SexySlideMenu
//
//  Created by YoonTaesup on 2015. 6. 24..
//  Copyright (c) 2015년 com.SexyDynamite. All rights reserved.
//


import UIKit


class SexyMainController: UIViewController {
    
    var delegate: SexySlideProtocolDelegate?
    
    var scrollView: UIScrollView = UIScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 40)
        var scrollBtn: UIButton = UIButton(frame: CGRectMake(0, 0, scrollView.frame.size.width, scrollView.frame.size.height))
        scrollBtn.addTarget(self, action: "touchBackground:", forControlEvents:.TouchUpInside)
        scrollBtn.targetForAction("touchBackground:", withSender: self);
        scrollView.addSubview(scrollBtn)
        self.view.addSubview(scrollView);
    }
    
    func viewDidLoadFinish() {
        
    }
    
    
    func pushViewController(controller:UIViewController, animated: Bool) {
        delegate?.pushViewController(controller, animated: animated)
    }
    
   
    
    func touchBackground(sender: UIButton) {
        delegate?.movePanelToOriginalPosition()
        self.view.endEditing(true)
    }
    
    
    func tapLeft() {
        if let d = self.delegate {
            d.movePanelLeft()
        }
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        if let touch = touches.first as? UITouch {
            if let d = self.delegate {
                
                d.movePanelToOriginalPosition()
            }
        }
        super.touchesBegan(touches , withEvent:event)
    }
    
}

