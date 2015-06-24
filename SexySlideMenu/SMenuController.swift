//
//  SMenuController.swift
//  SexySlideMenu
//
//  Created by YoonTaesup on 2015. 6. 24..
//  Copyright (c) 2015년 com.SexyDynamite. All rights reserved.
//

import UIKit

class SMenuController: SWMenuController {
    var buttonArray = [UIButton]()
    var iconArray = [UIImageView]()
    
    var mScroll: UIScrollView = UIScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initLayout()
    }
    
    func initLayout() {
        
        mScroll.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)
        var scrollBtn: UIButton = UIButton(frame: CGRectMake(0, 0, mScroll.frame.size.width, mScroll.frame.size.height))
        mScroll.addSubview(scrollBtn)
        mScroll.backgroundColor = UIColor.bg
        self.view.addSubview(mScroll);
        
        var topView = UIView(frame: CGRectMake(0, 0, mScroll.frame.size.width, 105))
        topView.backgroundColor = UIColor.navi
        mScroll.addSubview(topView)
        
        let width:CGFloat = 60
        
        var profile = UIImageView(frame: CGRectMake(20, 10 + 20, width, width))
        profile.layer.borderWidth = 1
        profile.layer.masksToBounds = false
        profile.layer.borderColor = UIColor.clearColor().CGColor
        profile.layer.cornerRadius = width/2
        profile.clipsToBounds = true
        profile.image = UIImage(named: "profile")
        self.view.addSubview(profile)
        
        var name = UILabel(frame: CGRectMake(profile.frame.origin.x + profile.frame.size.width + 15, profile.frame.origin.y + 8, mScroll.frame.size.width - (profile.frame.origin.x + profile.frame.size.width + 15), 22))
        
        name.text = "김연아"
        name.textColor = UIColor.whiteColor()
        name.font = name.font.fontWithSize(18)
        mScroll.addSubview(name)
        
        var point = UILabel(frame: CGRectMake(profile.frame.origin.x + profile.frame.size.width + 15, name.frame.origin.y + name.frame.size.height, mScroll.frame.size.width - (profile.frame.origin.x + profile.frame.size.width + 15), 22))
        
        let myPoint = 45000
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .DecimalStyle
        formatter.locale = NSLocale.currentLocale()
        let decimalMyPoint = formatter.stringFromNumber(myPoint)
        point.text = "ⓟ \(decimalMyPoint!)"
        
        
        point.textColor = UIColor.bg_light
        point.font = point.font.fontWithSize(15)
        mScroll.addSubview(point)
        
        
        for index in 1...7 {
            
            let nY:CGFloat = topView.frame.origin.y + topView.frame.size.height + 30 + (CGFloat)(index - 1) * 45
            
            var menu: UIButton = UIButton(frame: CGRectMake(0, nY, self.view.frame.width, 40))
            menu.backgroundColor = UIColor.bg
            menu.layer.masksToBounds = true
            menu.setTitleColor(UIColor.text, forState: .Normal)
            menu.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
            menu.tag = index
            menu.setTitle("            menu\(index)", forState: .Normal)
            menu.addTarget(self, action: "goMenu:", forControlEvents: .TouchUpInside)
            menu.frame = CGRectMake(menu.frame.origin.x, menu.frame.origin.y, menu.frame.size.width, 30)
            mScroll.addSubview(menu)
            buttonArray.append(menu)
        }
        
        for index in 1...7 {
            let nY:CGFloat = topView.frame.origin.y + topView.frame.size.height + 30 + (CGFloat)(index - 1) * 45
            
            var icon:UIImageView = UIImageView(frame: CGRectMake(20, nY + 2, 30, 30))
            icon.image = UIImage(named: "menu\(index)")
            mScroll.addSubview(icon)
            iconArray.append(icon)
        }
    }
    
    var preTag:Int = -1
    func goMenu(sender: UIButton) {
        changeViewColor(sender.tag)
        
        var controller:SMainController = SMainController()
        
        delegate?.rootViewController(controller, animated: true)
    }
    
    func changeViewColor(tag: Int) {
        if(preTag != -1) {
            buttonArray[preTag - 1].backgroundColor = UIColor.bg
        }
        
        preTag = tag
        
        var button:UIButton = buttonArray[tag - 1]
        button.backgroundColor = UIColor.warning
    }
}
