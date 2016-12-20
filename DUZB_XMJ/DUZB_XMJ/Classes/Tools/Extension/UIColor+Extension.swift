//
//  UIColor+Extension.swift
//  DUZB_XMJ
//
//  Created by user on 16/12/20.
//  Copyright © 2016年 XMJ. All rights reserved.
//

import UIKit

extension UIColor{
    convenience init(r:CGFloat,g:CGFloat,b:CGFloat) {
        self.init(red:r/255.0,green:g/255.0,blue:b/255.0, alpha:1.0)
    }
    
    class func randomColor() -> UIColor {
        return UIColor(r:CGFloat(arc4random_uniform(255)),g:CGFloat(arc4random_uniform(255)),b:CGFloat(arc4random_uniform(255)))
    }
}
