//
//  AdsModel.swift
//  DUZB_XMJ
//
//  Created by user on 16/12/28.
//  Copyright © 2016年 XMJ. All rights reserved.
//

import UIKit

class AdsModel: NSObject {
    var pic_url:String = ""
    var title:String = ""

    init(dict:[String:Any]){
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
