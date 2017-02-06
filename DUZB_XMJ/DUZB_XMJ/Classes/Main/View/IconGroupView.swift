//
//  IconGroupView.swift
//  DUZB_XMJ
//
//  Created by user on 16/12/30.
//  Copyright © 2016年 XMJ. All rights reserved.
//

import UIKit
fileprivate let kBGCellId = "kBGCellId"
fileprivate let kIconCellId = "kIconCellId"

fileprivate let kIconW = (kScreenW-2*kMargin)/4
fileprivate let kIconH = kIconW*6/5

class IconGroupView: UIView {
    
    var bgScrollBlock:(_ currentPage:Int)->() = {(currentPage:Int)->() in
    
    }
    
    var dataModelArr:[CellGroupModel]?{
        didSet{
            bgCollectionV.reloadData()
//            iconCollectionV.reloadData()
        }
    }
    
    fileprivate lazy var bgCollectionV:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = self.bounds.size
        layout.scrollDirection = .horizontal
        let bgCollectionV = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        bgCollectionV.backgroundColor = UIColor.red
        bgCollectionV.showsVerticalScrollIndicator = false
        bgCollectionV.showsHorizontalScrollIndicator = false
        bgCollectionV.isPagingEnabled = true
        bgCollectionV.dataSource = self
        bgCollectionV.delegate = self
        bgCollectionV.bounces = false
        bgCollectionV.register(MenuCollectionViewCell.self, forCellWithReuseIdentifier: kBGCellId)
        return bgCollectionV
    }()
    
//    fileprivate lazy var iconCollectionV:UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        layout.minimumLineSpacing = 0
//        layout.minimumInteritemSpacing = 0
//        layout.itemSize = CGSize(width: kIconW, height: 100)
//        layout.scrollDirection = .vertical
//        layout.sectionInset = UIEdgeInsets(top: 0, left: kMargin, bottom: 0, right: kMargin)
//        let iconCollectionV = UICollectionView(frame: self.bgCollectionV.bounds, collectionViewLayout: layout)
//        iconCollectionV.backgroundColor = UIColor.cyan
//        iconCollectionV.register(UINib(nibName: "GameCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: kIconCellId)
//        iconCollectionV.dataSource = self
//        iconCollectionV.showsVerticalScrollIndicator = false
//        iconCollectionV.showsHorizontalScrollIndicator = false
//        iconCollectionV.bounces = false
//        return iconCollectionV
//        
//    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

//设置控件
extension IconGroupView{
    func setupUI() {
        addSubview(bgCollectionV)
//        bgCollectionV.addSubview(iconCollectionV)
    }
}

//代理
extension IconGroupView:UICollectionViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        bgScrollBlock(Int((scrollView.contentOffset.x+kScreenW/2)/kScreenW))
    }
}

//数据源
extension IconGroupView:UICollectionViewDataSource{
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        if collectionView.isEqual(bgCollectionV){
//            return 1
//        }else{
//            return Int(((dataModelArr?.count ?? 0)+4)/8)
//        }
//    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if collectionView.isEqual(bgCollectionV) {
//            return Int(((dataModelArr?.count ?? 0)+4)/8)
//        }else{
//            return dataModelArr?.count ?? 0
//        }
        return Int(((dataModelArr?.count ?? 0)+4)/8)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        if collectionView.isEqual(bgCollectionV) {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kBGCellId, for: indexPath)
//            cell.backgroundColor = UIColor.randomColor()
//            return cell
//        }else{
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kIconCellId, for: indexPath) as! GameCollectionViewCell
//            cell.backgroundColor = UIColor.randomColor()
//            cell.titleL.text = "\(indexPath.item)"
//            return cell
//        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kBGCellId, for: indexPath) as! MenuCollectionViewCell
        cell.backgroundColor = UIColor.randomColor()
        //0---7,8---15,16---23
        let startIndex = indexPath.item*8
        var endIndex = startIndex+7
        if endIndex >= (dataModelArr?.count)! { endIndex = (dataModelArr?.count)!-1}
        cell.dataModelArr = Array(dataModelArr![startIndex...endIndex])
        return cell
    }
}
