//
//  Date+Extension.swift
//  DUZB_XMJ
//
//  Created by user on 16/12/26.
//  Copyright © 2016年 XMJ. All rights reserved.
//

import Foundation

extension Date{
    static func getCurrentDate()->String{
    let date = Date()
    let intervar = Int(date.timeIntervalSince1970)
    return "\(intervar)"
    }
}
