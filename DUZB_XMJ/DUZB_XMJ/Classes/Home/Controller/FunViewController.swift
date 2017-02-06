//
//  FunViewController.swift
//  DUZB_XMJ
//
//  Created by user on 16/12/30.
//  Copyright © 2016年 XMJ. All rights reserved.
//

import UIKit
fileprivate let kFunCellId = "kFunCellId"
fileprivate let kFunHeaderId = "kFunHeaderId"

fileprivate let kTopViewH:CGFloat = 200
class FunViewController: BaseViewController {

    fileprivate lazy var topView:IconGroupView = {
        let topView = IconGroupView(frame: CGRect(x: 0, y: -kTopViewH, width: kScreenW, height: kTopViewH))
        topView.bgScrollBlock = {[weak self] (currentPage:Int)->() in
            self?.pageControl.currentPage = currentPage
        }
        return topView
        
    }()
    
    fileprivate lazy var funVM = FunViewModel()
    
    fileprivate lazy var funCollectionV:UICollectionView = {[weak self] in
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: kNormalCellW, height: kNormalCellH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: kMargin, bottom: 0, right: kMargin)
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kSectionHeaderH)
        let funCollectionV = UICollectionView(frame: (self?.view.bounds)!, collectionViewLayout: layout)
        funCollectionV.dataSource = self
        funCollectionV.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        funCollectionV.contentInset = UIEdgeInsets(top: kTopViewH, left: 0, bottom: 0, right: 0)
        funCollectionV.backgroundColor = UIColor.white
        funCollectionV.register(UINib(nibName: "NormallCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: kFunCellId)
        funCollectionV.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kFunHeaderId)
        return funCollectionV
        }()
    
    fileprivate lazy var pageControl:UIPageControl = {[weak self] in
        let pageControl = UIPageControl()
        pageControl.currentPage = 0
        pageControl.currentPageIndicatorTintColor = UIColor.orange
        pageControl.pageIndicatorTintColor = UIColor.gray
        pageControl.frame = CGRect(x: 0, y: -30, width: kScreenW, height: 30)
        pageControl.backgroundColor = UIColor.white
        pageControl.numberOfPages = 2
        return pageControl
    
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

}

//MARK:-设置UI
extension FunViewController{
    fileprivate func setupUI(){
        view.backgroundColor = UIColor.white
        view.addSubview(funCollectionV)
        funCollectionV.addSubview(topView)
        funCollectionV.addSubview(pageControl)
        
        baseContentView = funCollectionV
        isHiddenAnimation = false
    }
}

//MARK:-网络请求
extension FunViewController{
    fileprivate func requestData(){
        funVM.loadFunData {
            self.funCollectionV.reloadData()
            self.topView.dataModelArr = self.funVM.funModelArr
            self.pageControl.numberOfPages = (self.funVM.funModelArr.count+4)/8
            
            self.isHiddenAnimation = true
        }
    }
}



//MARK:-数据源
extension FunViewController:UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return funVM.funModelArr.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return funVM.funModelArr[section].cellModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kFunCellId, for: indexPath) as! NormallCollectionViewCell
        cell.normalModel = funVM.funModelArr[indexPath.section].cellModels[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kFunHeaderId, for: indexPath) as! CollectionHeaderView
        header.groupM = funVM.funModelArr[indexPath.section]
        return header
        
    }
}
