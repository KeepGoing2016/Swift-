//
//  NavViewController.swift
//  DUZB_XMJ
//
//  Created by user on 17/1/9.
//  Copyright © 2017年 XMJ. All rights reserved.
//

import UIKit

class NavViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        var count : UInt32 = 0
//        let ivars = class_copyIvarList(UIGestureRecognizer.self, &count)!
//        for i in 0..<count {
//            let ivar = ivars[Int(i)]
//            let name = ivar_getName(ivar)
//            print(String(cString: name!))
//        }
        
//        var count:UInt32 = 0
//        let ivars = class_copyIvarList(UIPanGestureRecognizer.self, &count)
//        for i in 0..<count {
//            let ivar = ivars?[Int(i)]
//            let name = ivar_getName(ivar)
//            print(String(cString: name!))
//        }
        
        guard let sysGesture = interactivePopGestureRecognizer else {
            return
        }
        guard let sysView = sysGesture.view else {
            return
        }
        guard let gesTarget = sysGesture.value(forKey: "_targets") as? [AnyObject] else {
            return
        }
        
        guard let target = gesTarget.first?.value(forKey: "target") else {
            return
        }
        
        let action = Selector(("handleNavigationTransition:"))
        
        let popGesture = UIPanGestureRecognizer()
        popGesture.addTarget(target, action: action)
        sysView.addGestureRecognizer(popGesture)
        print("gesTarget:\(gesTarget)--------\((gesTarget as AnyObject).class)")
//        let arr = ["121","110","321"]
//        print("arr:\(arr)")
//        let dict = ["name":"lmf","age":"12"]
//        print("dict:\(dict)")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
//        setNavigationBarHidden(true, animated: true)
        if childViewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
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
