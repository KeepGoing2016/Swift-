//
//  LiveViewController.swift
//  DUZB_XMJ
//
//  Created by user on 16/12/16.
//  Copyright © 2016年 XMJ. All rights reserved.
//

import UIKit

class LiveViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.orange
//        //    导航栏变为透明
//        [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:0];
//        //    让黑线消失的方法
//        self.navigationController.navigationBar.shadowImage=[UIImage new];
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage.init(), for: .default)
//        self.navigationController?.navigationBar.shadowImage = UIImage.init()
        self.navigationController?.navigationBar.alpha = 0.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
