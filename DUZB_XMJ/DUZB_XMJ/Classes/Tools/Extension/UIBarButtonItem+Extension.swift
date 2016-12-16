//
//  UIBarButtonItem+Extension.swift
//  DUZB_XMJ
//
//  Created by user on 16/12/16.
//  Copyright © 2016年 XMJ. All rights reserved.
//

import UIKit

extension UIBarButtonItem{
    convenience init(imageName:String,selImageName:String="",itemSize:CGSize=CGSize.zero) {
        let btn = UIButton()
        
        btn.setImage(UIImage(named: imageName), for: .normal)
        if selImageName != "" {
            btn.setImage(UIImage(named: selImageName), for: .highlighted)
        }
        
        if itemSize == CGSize.zero{
            btn.sizeToFit()
        }else{
            btn.frame = CGRect(origin: CGPoint.zero, size: itemSize)
        }
        
        self.init(customView:btn)
        
    }
}
