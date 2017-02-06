//
//  RecommendViewModel.swift
//  DUZB_XMJ
//
//  Created by user on 16/12/26.
//  Copyright © 2016年 XMJ. All rights reserved.
//

import UIKit
import Alamofire

class RecommendViewModel{
//    lazy var hotestArr : [NormalCellModel] = [NormalCellModel]()
    lazy var groupDataArr:[CellGroupModel] = [CellGroupModel]()
    lazy var hotestGroup:CellGroupModel = CellGroupModel()
    lazy var prettyGroup:CellGroupModel = CellGroupModel()
    lazy var adsModelArr:[AdsModel] = [AdsModel]()
}

//网络请求
extension RecommendViewModel{
    func loadHotestData(_ finishCallBack:@escaping ()->()) {
//        print("date:\(Date.getCurrentDate())")
        let params:[String:Any] = ["limit":4,"offset":0,"time":Date.getCurrentDate()]
        
        let disp_group = DispatchGroup()
        
        disp_group.enter()
        //1、获取最热门数据
        NetworkTools.requestData(urlString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", methodType: .GET, params: ["time":Date.getCurrentDate()]) { (response) in
            guard let result = response as? [String:Any] else {return}
            guard let hotestData = result["data"] as? [[String:Any]] else {return}
            self.hotestGroup.tag_name = "热门"
            self.hotestGroup.icon_name = "home_header_hot"
            self.hotestGroup.room_list = hotestData
            disp_group.leave()
        }
        
        disp_group.enter()
        //2、获取颜值数据
        NetworkTools.requestData(urlString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", methodType: .GET, params: params) { (response) in
            guard let response = response as? [String:Any] else {return}
            guard let responseData = response["data"] as? [[String:Any]] else {return}
            self.prettyGroup.tag_name = "颜值"
            self.prettyGroup.icon_name = "home_header_phone"
            self.prettyGroup.room_list = responseData
            disp_group.leave()
        }
        
        disp_group.enter()
        //3、获取分组数据
        
        NetworkTools.requestData(urlString: "http://capi.douyucdn.cn/api/v1/getHotCate", methodType: .GET, params: params) { (response) in
            guard let response = response as? [String:Any] else {return}
            guard let responseData = response["data"] as? [[String:Any]] else {return}
            
            for groupM in responseData {
                self.groupDataArr.append(CellGroupModel(dict: groupM))
            }
            disp_group.leave()
        }
        
        disp_group.notify(queue: DispatchQueue.main) { 
            self.groupDataArr.removeFirst()
            self.groupDataArr.removeFirst()
            self.groupDataArr.insert(self.prettyGroup, at: 0)
            self.groupDataArr.insert(self.hotestGroup, at: 0)
            
            finishCallBack()
        }
    }
    
    func loadAdsData(finishCallBack:@escaping ()->()){
        NetworkTools.requestData(urlString: "http://capi.douyucdn.cn/api/v1/slide/6", methodType: .GET, params: ["version":2.421,"client_sys":"ios"]) { (response) in
            guard let response = response as? [String:Any] else {return}
            guard let adsData = response["data"] as? [[String:Any]] else {return}
            for ads in adsData {
                self.adsModelArr.append(AdsModel(dict: ads))
            }
            
            finishCallBack()
        }
    }
}
