//
//  IconView.swift
//  DUZB_XMJ
//
//  Created by user on 16/12/28.
//  Copyright © 2016年 XMJ. All rights reserved.
//

import UIKit
fileprivate let kIconCollectionCellId = "kIconCollectionCellId"

class IconView: UIView {

    var dataModelArr:[CellGroupModel]?{
        didSet{
//            let model = CellGroupModel(dict: ["tag_name":"更多"])
//            dataModelArr?.append(model)
            iconCollectionV.reloadData()
        }
    }
    
    fileprivate lazy var iconCollectionV:UICollectionView = {[weak self] in
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 10
        layout.scrollDirection = .horizontal
        
        let iconCollectionV = UICollectionView(frame: (self?.bounds)!, collectionViewLayout: layout)
        iconCollectionV.backgroundColor = UIColor.white
        iconCollectionV.showsVerticalScrollIndicator = false
        iconCollectionV.showsHorizontalScrollIndicator = false
        iconCollectionV.backgroundColor = UIColor.white
        iconCollectionV.dataSource = self
        iconCollectionV.register(UINib(nibName: "IconCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: kIconCollectionCellId)
        return iconCollectionV
    }()
    
    override init(frame:CGRect){
        super.init(frame: frame)
        

        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let layout = iconCollectionV.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: iconCollectionV.bounds.size.width/5+5, height: iconCollectionV.bounds.size.height)
    }

}

extension IconView{
    fileprivate func setupUI(){
        addSubview(iconCollectionV)
    }
}

//MARK:-数据源
extension IconView:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataModelArr?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kIconCollectionCellId, for: indexPath) as! IconCollectionViewCell
        cell.dataM = dataModelArr?[indexPath.item]
        return cell
    }
}

