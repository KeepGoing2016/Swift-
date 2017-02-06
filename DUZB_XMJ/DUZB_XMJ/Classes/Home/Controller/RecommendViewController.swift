//
//  RecommendViewController.swift
//  DUZB_XMJ
//
//  Created by user on 16/12/26.
//  Copyright © 2016年 XMJ. All rights reserved.
//

import UIKit

fileprivate let kPrettyCellH = kNormalCellW*4/3
fileprivate let kAdContentViewH = kScreenW*3/8

fileprivate let kRecommendCellId = "kRecommendCellId"
fileprivate let kRecommendHeaderId = "kRecommendHeaderId"
fileprivate let kRecommendPrettyCellId = "kRecommendPrettyCellId"
class RecommendViewController: BaseViewController {

    fileprivate lazy var recommendVM = RecommendViewModel()
    
    fileprivate lazy var adView:AdView = {
        let adV = AdView(frame: CGRect(x: 0, y: -kAdContentViewH-kIconViewH, width: kScreenW, height: kAdContentViewH))

        return adV
    }()
    
    fileprivate lazy var iconView:IconView = {
        let iconV = IconView(frame: CGRect(x: 0, y: -kIconViewH, width: kScreenW, height: kIconViewH))
        return iconV
    }()
    
    fileprivate lazy var contentView:UICollectionView = {[weak self] in
        let layout = UICollectionViewFlowLayout()
        let cellW = (kScreenW-3*kMargin)/2
        layout.itemSize = CGSize(width: cellW, height: cellW*3/4)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 10
        layout.headerReferenceSize = CGSize(width: (self?.view.bounds.width)!, height: kSectionHeaderH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: kMargin, bottom: 0, right: kMargin)
        
        let contentV = UICollectionView(frame: (self?.view.bounds)!, collectionViewLayout: layout)
        contentV.showsHorizontalScrollIndicator = false
        contentV.backgroundColor = UIColor.white
        contentV.dataSource = self
        contentV.delegate = self
        contentV.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        contentV.register(UINib(nibName: "NormallCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: kRecommendCellId)
        contentV.register(UINib(nibName: "CollectionPrettyViewCell", bundle: nil), forCellWithReuseIdentifier: kRecommendPrettyCellId)
        contentV.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kRecommendHeaderId)
        
        return contentV
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        requestData()
        // Do any additional setup after loading the view.
    }
}

//MARK:-设置UI
extension RecommendViewController{
    fileprivate func setupUI(){
        
        contentView.addSubview(adView)
        
        contentView.addSubview(iconView)
        
        view.addSubview(contentView)
        
        baseContentView = contentView
        //设置内边距
        contentView.contentInset = UIEdgeInsets(top: kAdContentViewH+kIconViewH, left: 0, bottom: 0, right: 0)
        isHiddenAnimation = false
    }
}

//MARK:-请求数据
extension RecommendViewController{
    fileprivate func requestData(){
        //加载内容数据
        recommendVM.loadHotestData {
            self.contentView.reloadData()
            var tempArr = self.recommendVM.groupDataArr
            tempArr.removeFirst()
            tempArr.removeFirst()
            let model = CellGroupModel(dict: ["tag_name":"更多"])
            tempArr.append(model)
            self.iconView.dataModelArr = tempArr
            self.isHiddenAnimation = true
        }
        
        //加载广告数据
        recommendVM.loadAdsData(){
            self.adView.adModelsArr = self.recommendVM.adsModelArr
        }
    }
}

//MARK:-代理
extension RecommendViewController:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1{
            return CGSize(width: kNormalCellW, height: kPrettyCellH)
        }else{
            return CGSize(width: kNormalCellW, height: kNormalCellH)
        }
    }
}

//MARK:-数据源
extension RecommendViewController:UICollectionViewDataSource{
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recommendVM.groupDataArr.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recommendVM.groupDataArr[section].cellModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 1{
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kRecommendPrettyCellId, for: indexPath) as? CollectionPrettyViewCell
           cell?.cellModel = recommendVM.groupDataArr[indexPath.section].cellModels[indexPath.item]
            return cell!
        }else{
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kRecommendCellId, for: indexPath) as? NormallCollectionViewCell
            cell?.normalModel = recommendVM.groupDataArr[indexPath.section].cellModels[indexPath.item]
            return cell!
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let groupHeader = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kRecommendHeaderId, for: indexPath) as! CollectionHeaderView
        groupHeader.groupM = recommendVM.groupDataArr[indexPath.section]
       return groupHeader
    }
}

//MARK:-代理
extension RecommendViewController:UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let roomVC = RoomViewController()
        navigationController?.pushViewController(roomVC, animated: true)
    }
}
