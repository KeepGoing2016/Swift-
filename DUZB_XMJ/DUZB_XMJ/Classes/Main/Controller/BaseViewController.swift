//
//  BaseViewController.swift
//  DUZB_XMJ
//
//  Created by user on 17/1/9.
//  Copyright © 2017年 XMJ. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    var baseContentView:UIView?
    
    fileprivate lazy var animationView:UIImageView = {[weak self] in
        let animationView = UIImageView()
        animationView.frame = (self?.view.bounds)!
        animationView.animationImages = [UIImage(named:"img_loading_1")!,UIImage(named:"img_loading_2")!]
        animationView.animationRepeatCount = LONG_MAX
        animationView.animationDuration = 1
        animationView.contentMode = .center
        animationView.startAnimating()
        return animationView
    }()
    
    var isHiddenAnimation:Bool = false{
        didSet{
            if isHiddenAnimation == true {
                animationView.stopAnimating()
                animationView.isHidden = true
                baseContentView?.isHidden = false
            }else{
                animationView.startAnimating()
                animationView.isHidden = false
                baseContentView?.isHidden = true
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}

//MARK:-设置UI
extension BaseViewController{
    fileprivate func setupUI(){
        view.backgroundColor = UIColor.white
        view.addSubview(animationView)
        baseContentView?.isHidden = true
    }
}

//MARK:-执行加载动画
extension BaseViewController{
    
}
