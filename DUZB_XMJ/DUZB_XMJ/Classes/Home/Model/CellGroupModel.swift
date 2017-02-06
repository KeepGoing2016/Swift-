//
//  CellGroupModel.swift
//  DUZB_XMJ
//
//  Created by user on 16/12/27.
//  Copyright © 2016年 XMJ. All rights reserved.
//

import UIKit

class CellGroupModel:NSObject {
    ///水平滚动图标
    var icon_url:String = ""
    ///组名
    var tag_name:String = ""
    
    var icon_name = "home_header_normal"
    
    
    var room_list:[[String:Any]]? {
        didSet{
            guard let room_list = room_list else {
                return
            }
            for dict in room_list{
                cellModels.append(NormalCellModel(dict: dict))
            }
        }
    }
    
    lazy var cellModels:[NormalCellModel] = [NormalCellModel]()
    
    override init(){
        
    }
    
    init(dict:[String:Any]){
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
