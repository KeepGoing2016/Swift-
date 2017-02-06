//
//  MenuCollectionViewCell.swift
//  DUZB_XMJ
//
//  Created by user on 16/12/30.
//  Copyright © 2016年 XMJ. All rights reserved.
//

import UIKit
fileprivate let kIconW = (kScreenW-2*kMargin)/4
fileprivate let kIconH = kIconW*6/5

fileprivate let kIconCellId = "kIconCellId"

class MenuCollectionViewCell: UICollectionViewCell {
    
    var dataModelArr:[CellGroupModel]?{
        didSet{
            innerCollectionV.reloadData()
            //            iconCollectionV.reloadData()
        }
    }
    
    fileprivate lazy var innerCollectionV:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: kIconW, height: 85)
        layout.sectionInset = UIEdgeInsets(top: 0, left: kMargin, bottom: 0, right: kMargin)
        let innerCollectionV = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        innerCollectionV.backgroundColor = UIColor.white
        innerCollectionV.register(UINib(nibName: "GameCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: kIconCellId)
        innerCollectionV.dataSource = self
        innerCollectionV.showsVerticalScrollIndicator = false
        innerCollectionV.showsHorizontalScrollIndicator = false
        innerCollectionV.bounces = false
        
        return innerCollectionV
    }()
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        let layout = innerCollectionV.collectionViewLayout as! UICollectionViewFlowLayout
//        layout.itemSize = CGSize(width: kIconW, height: self.bounds.width/2)
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



extension MenuCollectionViewCell{
    fileprivate func setupUI(){
        addSubview(innerCollectionV)
    }
}

extension MenuCollectionViewCell:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return dataModelArr?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kIconCellId, for: indexPath) as! GameCollectionViewCell
//        cell.backgroundColor = UIColor.randomColor()
        cell.gameModel = GameModel(dict: ["icon_url":dataModelArr![indexPath.item].icon_url,"tag_name":dataModelArr![indexPath.item].tag_name])
        cell.lineV.isHidden = true
        return cell
    }
}
