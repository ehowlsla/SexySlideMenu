//
//  SexyController.swift
//  SexySlideMenu
//
//  Created by YoonTaesup on 2015. 6. 24..
//  Copyright (c) 2015년 com.SexyDynamite. All rights reserved.
//

import UIKit
import QuartzCore

protocol SexySlideProtocolDelegate {
    func movePanelLeft()
    func movePanelToOriginalPosition()
    func setNaviTitle(title: String)
    func setHamburgerColor(color: UIColor)
    
    func rootdidLoad()
    func pushViewController(controller: UIViewController, animated: Bool)
}

protocol SexySlideMoveProtocolDelegate {
    func rootViewController(controller: SexyMainController, animated: Bool)
}

enum SWSlideMenuState {
    case Closed
    case LeftOpened
}

enum SWPanGestureState {
    case Stopped
    case Right
}

class SexyController: UIViewController {
    
    let centerTag = 1
    let leftTag = 2
    let cornerRadius = CGFloat(4)
    let slideTiming = 0.25
    var panelWidth = CGFloat(270)
    
    var panStarted = false
    var posYNav = CGFloat(0)
    var preVelocity = CGPoint(x: 0, y: 0)
    var menuState = SWSlideMenuState.Closed
    var gestureState = SWPanGestureState.Stopped
    
    var panRecognizer:UIPanGestureRecognizer?
    
    var rootViewController:SexyMainController = SexyMainController()
    var menuViewController:SWMenuController = SWMenuController()
    var hamburgerButton: HamburgerButton = HamburgerButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        panelWidth = self.view.bounds.width - 50
        
        self.rootViewController.view.tag = centerTag
        self.rootViewController.view.bounds = self.view.bounds
        self.rootViewController.delegate = self
        self.addChildViewController(self.rootViewController)
        self.rootViewController.view.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        
        self.view.addSubview(self.rootViewController.view)
        
        
        setNaviTitle("쓸모있는 데모")
        
        
        hamburgerButton.color = UIColor.warning
        hamburgerButton.frame = CGRectMake(15, 15, 15, 15)
        hamburgerButton.addTarget(self, action: "toggle:", forControlEvents: UIControlEvents.TouchUpInside)
        hamburgerButton.transform = CGAffineTransformMakeScale(1.5, 1.5)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: hamburgerButton);
        
        self.setupGestures()
    }
    
    func toggle(sender: AnyObject!) {
        //        hamburgerButton.showsMenu = !self.hamburgerButton.showsMenu
        
        if(menuState == SWSlideMenuState.Closed) {
            movePanelLeft()
        } else {
            movePanelToOriginalPosition()
        }
    }
    
    
    func leftView() -> UIView {
        
        if self.menuViewController.view.tag != leftTag {
            self.menuViewController.view.tag = leftTag;
            self.menuViewController.delegate = self
            
            self.addChildViewController(self.menuViewController)
            self.menuViewController.view.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
            self.view.addSubview(self.menuViewController.view)
        }
        
        self.showRootViewWithShadow(true, withOffset: 2)
        
        return self.menuViewController.view
    }
    
    func showRootViewWithShadow(value :Bool, withOffset offset:CGFloat) {
        if value {
            self.rootViewController.view.layer.cornerRadius = cornerRadius
            self.rootViewController.view.layer.shadowColor = UIColor.blackColor().CGColor
            self.rootViewController.view.layer.shadowOpacity = 0.8
            self.rootViewController.view.layer.shadowOffset = CGSizeMake(offset, offset)
        } else {
            self.rootViewController.view.layer.cornerRadius = 0
            self.rootViewController.view.layer.shadowOffset = CGSizeMake(offset, offset)
            self.rootViewController.view.layer.shadowOpacity = 0
        }
    }
    
    
    
    func setNaviTitle(title: String) {
        self.title = title;
    }
    
    func setHamburgerColor(color: UIColor) {
        self.hamburgerButton.color = color
    }
    
    
    func movePanelToOriginalPosition() {
        var frame = self.rootViewController.view.frame
        frame.origin.x = 0
        if(hamburgerButton.showsMenu == false) {
            hamburgerButton.showsMenu = true
        }
         
        
        if var frameNav = self.navigationController?.navigationBar.frame {
            frameNav.origin.x = 0
            
            UIView.animateWithDuration(slideTiming, delay: Double(0), options: .BeginFromCurrentState, animations:{
                self.rootViewController.view.frame = frame
                self.navigationController?.navigationBar.frame = frameNav
                
                }, completion: {
                    finished in
                    if finished {
                        self.resetMainView()
                    }
            })
        }
    }
    
    func resetMainView() {
        
        self.menuState = SWSlideMenuState.Closed
        self.gestureState = SWPanGestureState.Stopped
        self.showRootViewWithShadow(false, withOffset: 0)
        
        self.menuViewController.view.tag = 0;
        self.menuViewController.delegate = nil
        
        self.menuViewController.view.removeFromSuperview()
    }
    
    func setupGestures() {
        //        self.panRecognizer.
        if self.panRecognizer == nil {
            self.panRecognizer = UIPanGestureRecognizer(target: self, action: "movePanel:")
            self.panRecognizer!.minimumNumberOfTouches = 1
            self.panRecognizer!.maximumNumberOfTouches = 1
            self.panRecognizer!.delegate = self
        }
        
        self.rootViewController.view.addGestureRecognizer(panRecognizer!)
    }
    
    func addLeftToView() {
        let childView = self.leftView()
        self.view.sendSubviewToBack(childView)
        self.gestureState = SWPanGestureState.Right
    }
    
}

extension SexyController:SexySlideMoveProtocolDelegate {
    //    func openRootController(controller: SexyMainController) {
    //
    //    }
    
    func rootViewController(controller: SexyMainController, animated: Bool) {
        
        var frame = self.rootViewController.view.frame
        controller.view.frame = frame 
        frame.origin.x = 0
        if(hamburgerButton.showsMenu == false) {
            hamburgerButton.showsMenu = true
        }
        menuState = SWSlideMenuState.Closed
        
        if(animated == true) {
            self.rootViewController.view.alpha = 1
            controller.view.alpha = 0
        }
        
        self.view.addSubview(controller.view)
        
        if var frameNav = self.navigationController?.navigationBar.frame {
            frameNav.origin.x = 0
            
            UIView.animateWithDuration(slideTiming, delay: Double(0), options: .BeginFromCurrentState, animations:{
                
                self.rootViewController.view.frame = frame
                controller.view.frame = frame
                self.navigationController?.navigationBar.frame = frameNav
                
                if(animated == true) {
                    controller.view.alpha = 1
                }
                
                
                }, completion: {
                    finished in
                    if finished {
                        
                        self.rootViewController.view.removeGestureRecognizer(self.panRecognizer!)
                        self.rootViewController.view.removeFromSuperview()
                        
                        self.rootViewController = controller
                        self.rootViewController.delegate = self
                        self.rootViewController.view.tag = self.centerTag
                        self.rootViewController.view.bounds = self.view.bounds
                        self.addChildViewController(self.rootViewController)
                        self.rootViewController.view.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
                        self.rootViewController.viewDidLoadFinish()
                        
                        self.setupGestures()
                    }
            })
        }
    }
}

extension SexyController: SexySlideProtocolDelegate {
    func movePanelLeft() {
        if self.menuState != SWSlideMenuState.LeftOpened {
            self.addLeftToView()
        }
        
        self.movePanelLeft(shouldExpand: true)
    }
    
    func movePanelLeft(#shouldExpand: Bool) {
        
        if shouldExpand {
            var frame = self.rootViewController.view.frame
            frame.origin.x = panelWidth
            if(hamburgerButton.showsMenu == true) {
                hamburgerButton.showsMenu = false
            }
            if var frameNav = self.navigationController?.navigationBar.frame {
                self.posYNav = frameNav.origin.y
                frameNav.origin.x = panelWidth
                
                UIView.animateWithDuration(slideTiming, delay: Double(0), options: .BeginFromCurrentState, animations:{
                    self.rootViewController.view.frame = frame
                    self.navigationController?.navigationBar.frame = frameNav
                    
                    }, completion: {
                        finished in
                        if finished {
                            self.menuState = SWSlideMenuState.LeftOpened
                        }
                })
            }
        }else{
            
            self.movePanelToOriginalPosition()
        }
    }
    
    func rootdidLoad() {
        
    }
    
    
    func pushViewController(controller: UIViewController, animated: Bool) {
        self.navigationController?.pushViewController(controller, animated: animated)
    }
}

extension SexyController: UIGestureRecognizerDelegate {
    func movePanel(tap: UIPanGestureRecognizer) {
        
        let gestureIsDraggingFromLeftToRight = (tap.velocityInView(view).x > 0)
        
        switch tap.state {
        case .Began:
            panStarted = true
            
            //--
            if self.menuState == SWSlideMenuState.Closed {
                if gestureIsDraggingFromLeftToRight {
                    self.addLeftToView()
                }
            }
            
            
        case .Ended, .Cancelled:
            if self.panStarted {
                self.panStarted = false
                
                switch self.gestureState {
                case .Right:
                    let hasMovedGreaterThanHalfway = tap.view!.center.x > view.bounds.size.width
                    self.movePanelLeft(shouldExpand: hasMovedGreaterThanHalfway)
                    
                default:
                    println("can't move position")
                }
            }
            
        case .Changed:
            if(tap.view!.center.x + tap.translationInView(view).x > self.view.bounds.size.width / 2) {
                tap.view!.center.x = tap.view!.center.x + tap.translationInView(view).x
                tap.setTranslation(CGPointZero, inView: view)
                
                self.navigationController!.navigationBar.center.x = tap.view!.center.x + tap.translationInView(view).x
            }
            
        default:
            println("\(tap.state)")
            
        }
    }
}
