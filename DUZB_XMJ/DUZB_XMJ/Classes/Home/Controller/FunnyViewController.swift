//
//  FunnyViewController.swift
//  DUZB_XMJ
//
//  Created by user on 17/1/3.
//  Copyright © 2017年 XMJ. All rights reserved.
//

import UIKit

fileprivate let kFunnyCellId = "kFunnyCellId"

class FunnyViewController: BaseViewController {

    fileprivate lazy var funnyVM = FunnyViewModel()
    
    fileprivate lazy var funnyCollectionV:UICollectionView = {[weak self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kNormalCellW, height: kNormalCellH)
        layout.minimumInteritemSpacing = kMargin
        layout.minimumLineSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: kMargin, bottom: 0, right: kMargin)
        
        let funnyCollectionV = UICollectionView(frame: (self?.view.bounds)!, collectionViewLayout: layout)
        funnyCollectionV.backgroundColor = UIColor.white
        funnyCollectionV.dataSource = self
        funnyCollectionV.autoresizingMask = [.flexibleWidth,.flexibleHeight]    
        funnyCollectionV.register(UINib(nibName: "NormallCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: kFunnyCellId)
        return funnyCollectionV
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupUI()
        
//        requestData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        requestData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

//MARK:-设置UI
extension FunnyViewController{
    fileprivate func setupUI(){
        
        view.addSubview(funnyCollectionV)
        baseContentView = funnyCollectionV
        isHiddenAnimation = false
    }
}

//网路请求
extension FunnyViewController{
    fileprivate func requestData(){
        funnyVM.loadFunnyData {
            
            self.funnyCollectionV.reloadData()
            self.isHiddenAnimation = true
        }
    }
}

//MARK:-数据源
extension FunnyViewController:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return funnyVM.funnyModelArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kFunnyCellId, for: indexPath) as! NormallCollectionViewCell
//        cell.backgroundColor = UIColor.randomColor()
        cell.normalModel = funnyVM.funnyModelArr[indexPath.item]
        return cell
        
    }
}
