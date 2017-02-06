//
//  GameModel.swift
//  DUZB_XMJ
//
//  Created by user on 16/12/29.
//  Copyright © 2016年 XMJ. All rights reserved.
//

import UIKit

class GameModel: NSObject {
    var icon_url:String = ""
    var tag_name:String = ""
    
    init(dict:[String:Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
