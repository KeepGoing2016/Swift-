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
        let leftBtn = UIButton()
        leftBtn.setImage(UIImage(named:"logo"), for: .normal)
        leftBtn.sizeToFit()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBtn)
        
        
        navigationItem.rightBarButtonItems = []
    }
}
