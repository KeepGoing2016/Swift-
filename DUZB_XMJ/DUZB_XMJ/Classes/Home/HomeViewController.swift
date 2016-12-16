//
//  HomeViewController.swift
//  DUZB_XMJ
//
//  Created by user on 16/12/16.
//  Copyright © 2016年 XMJ. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }

}

//MARK:-设置UI
extension HomeViewController{
    
    fileprivate func setUI(){
        setUpNav()
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
}
