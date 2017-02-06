//
//  MainViewController.swift
//  DUZB_XMJ
//
//  Created by user on 16/12/16.
//  Copyright © 2016年 XMJ. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        addChilViewController(childVC: HomeViewController(),title:"首页",itemName: "btn_home_normal", selItemName: "btn_home_selected")
        addChilViewController(childVC: LiveViewController(),title: "直播",itemName: "btn_column_normal", selItemName: "btn_column_selected")
        addChilViewController(childVC: FollowViewController(), title:"关注",itemName: "btn_live_normal", selItemName: "btn_live_selected")
        addChilViewController(childVC: MeViewController(), title:"我的",itemName: "btn_user_normal", selItemName: "btn_user_selected")
    }
    
    func addChilViewController(childVC:UIViewController,title:String,itemName:String,selItemName:String){
        childVC.tabBarItem.image = UIImage.init(named: itemName)
        childVC.tabBarItem.selectedImage = UIImage.init(named: selItemName)?.withRenderingMode(.alwaysOriginal)
        childVC.tabBarItem.title = title
        let nav = NavViewController(rootViewController: childVC)
        addChildViewController(nav)
    }
}
