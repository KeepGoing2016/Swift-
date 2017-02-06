//
//  GameViewModel.swift
//  DUZB_XMJ
//
//  Created by user on 16/12/29.
//  Copyright © 2016年 XMJ. All rights reserved.
//

import UIKit

class GameViewModel {
    lazy var gameModelArr:[GameModel] = [GameModel]()
}

//MARK:-网络请求
extension GameViewModel{
    func loadGameData(finishCallBack:@escaping ()->()){
        NetworkTools.requestData(urlString: "http://capi.douyucdn.cn/api/v1/getColumnDetail?shortName=game", methodType: .GET, params: nil) { (response) in
            DispatchQueue.global().async {
                guard let response = response as? [String:Any] else {return}
                guard let resultData = response["data"] as? [[String:Any]] else{return}
                for data in resultData {
                    self.gameModelArr.append(GameModel(dict: data))
                }
                DispatchQueue.main.async {
                    finishCallBack()
                }
            }
        }
    }
}
