//
//  FunViewModel.swift
//  DUZB_XMJ
//
//  Created by user on 16/12/30.
//  Copyright © 2016年 XMJ. All rights reserved.
//

import UIKit

class FunViewModel {
    lazy var funModelArr:[CellGroupModel] = [CellGroupModel]()
}

//MARK:-网络请求
extension FunViewModel{
    func loadFunData(finishCallBack:@escaping ()->()){
        NetworkTools.requestData(urlString: "http://capi.douyucdn.cn/api/homeCate/getHotRoom?identification=9acf9c6f117a4c2d02de30294ec29da9&client_sys=ios", methodType: .GET, params: nil) { (response) in
            DispatchQueue.global().async {
                guard let response = response as? [String:Any] else{return}
                guard let resultData = response["data"] as? [[String:Any]] else {return}
                for funData in resultData {
                    self.funModelArr.append(CellGroupModel(dict: funData))
                }
                DispatchQueue.main.async {
                    finishCallBack()
                }
            }
            
        }
    }
}
