//
//  HomeViewController.swift
//  DUZB_XMJ
//
//  Created by user on 16/12/16.
//  Copyright © 2016年 XMJ. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController { 

    fileprivate lazy var pageTitleView = { ()-> PageTitleView in
        let pageTitleV = PageTitleView(frame: CGRect(x: 0, y: kStatusBarH+kNavigationBarH, width: kScreenW, height: 40), titles: ["推荐","手游","娱乐","游戏","趣玩"])
//        pageTitleV.backgroundColor = UIColor.orange
        return pageTitleV
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setUI()
    }

}

//MARK:-设置UI
extension HomeViewController{
    
    fileprivate func setUI(){
        // 0.不需要调整UIScrollView的内边距
        automaticallyAdjustsScrollViewInsets = false
        //设置导航
        setUpNav()
        
        //设置头部选择标题
        view.addSubview(pageTitleView)
    }
    
    fileprivate func setUpNav() {
//        let leftBtn = UIButton()
//        leftBtn.setImage(UIImage(named:"logo"), for: .normal)
//        leftBtn.sizeToFit()
//        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBtn)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
        
        let itemSize = CGSize(width: 40, height: 40)
        
        
        let search = UIBarButtonItem(imageName: "btn_search", selImageName: "btn_search_clicked", itemSize: itemSize)
        
        let history = UIBarButtonItem(imageName: "image_my_history", selImageName: "Image_my_history_click", itemSize: itemSize)
        
        let scan = UIBarButtonItem(imageName: "Image_scan", selImageName: "Image_scan_click", itemSize: itemSize)
        
        
        navigationItem.rightBarButtonItems = [search,history,scan]
    }
    
//    fileprivate func setupHeaderTitle(){
//        
//        let pageTitleView = PageTitleView(frame: CGRect(x: 0, y: kStatusBarH+kNavigationBarH, width: kScreenW, height: 40), titles: ["推荐","手游","娱乐","游戏","趣玩"])
////        pageTitleView.backgroundColor = UIColor.brown
//        view.addSubview(pageTitleView)
//    }
}
