//
//  FunnyViewModel.swift
//  DUZB_XMJ
//
//  Created by user on 17/1/3.
//  Copyright © 2017年 XMJ. All rights reserved.
//

import UIKit
//http://capi.douyucdn.cn/api/v1/getColumnRoom/3?limit=30&offset=0
class FunnyViewModel {
    var funnyModelArr:[NormalCellModel] = [NormalCellModel]()
}

//网络请求
extension FunnyViewModel{
    func loadFunnyData(finishCallBack:@escaping ()->()){
        NetworkTools.requestData(urlString: "http://capi.douyucdn.cn/api/v1/getColumnRoom/3?limit=30&offset=0", methodType: .GET, params: nil) { (response) in
            DispatchQueue.global().async {
                
                guard let response = response as? [String:Any] else{return}
                guard let resultData = response["data"] as? [[String:Any]] else{return}
                
                for rData in resultData{
                    self.funnyModelArr.append(NormalCellModel(dict: rData))
                }
                DispatchQueue.main.async {
                    finishCallBack()
                }
            }
            
        }
    }
}
