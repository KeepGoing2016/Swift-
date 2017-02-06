//
//  NetworkTools.swift
//  DUZB_XMJ
//
//  Created by user on 16/12/26.
//  Copyright © 2016年 XMJ. All rights reserved.
//

import UIKit
import Alamofire

enum NetworkType{
    case GET
    case POST
}
class NetworkTools{
    class func requestData(urlString:String,methodType:NetworkType,params:[String:Any]?,finishedCallback:@escaping (_ result:Any)->()) {
        
        let requestMethod = methodType == .GET ? HTTPMethod.get : HTTPMethod.post
        
        Alamofire.request(urlString, method: requestMethod, parameters: params).responseJSON { (response) in
//            print(response.result.value!)
            DispatchQueue.global().async {
                guard let jsondata = response.result.value else {
                    //                print(response.result.error!)
                    return
                }
                DispatchQueue.main.async {
                    finishedCallback(jsondata)
                }
            }
            
//            print(jsondata)
        }
    }
}
