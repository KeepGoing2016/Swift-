//
//  GameViewController.swift
//  DUZB_XMJ
//
//  Created by user on 16/12/29.
//  Copyright © 2016年 XMJ. All rights reserved.
//

import UIKit
fileprivate let kGameCellId = "kGameCellId"
fileprivate let kGameHeaderId = "kGameHeaderId"

fileprivate let kEdgeMargin:CGFloat = 10
fileprivate let kGameCellW = (kScreenW-2*kEdgeMargin)/3
fileprivate let kGameCellH = kGameCellW*6/5

class GameViewController: BaseViewController {

    fileprivate lazy var gameVM:GameViewModel = GameViewModel()
    
    fileprivate var supplementaryV:CollectionHeaderView?
    
    fileprivate lazy var topHeaderView:CollectionHeaderView = {
        let topHeaderView = CollectionHeaderView.headerView()
        topHeaderView.frame = CGRect(x: 0, y: -kSectionHeaderH-kIconViewH, width: kScreenW, height: kSectionHeaderH)
        topHeaderView.groupIconImg.image = UIImage(named: "Img_orange")
        topHeaderView.groupName.text = "常见"
        topHeaderView.moreBtn.isHidden = true
//        let tempF = topHeaderView.groupIconImg.frame
//        topHeaderView.groupIconImg.frame = CGRect(origin: tempF.origin, size: CGSize(width: 5, height: tempF.size.height))
        return topHeaderView
    }()
    
    fileprivate lazy var topIconView:IconView = {
        let topIconView = IconView(frame: CGRect(x: 0, y: -kIconViewH, width: kScreenW, height: kIconViewH))
        return topIconView
    }()
    
    fileprivate lazy var allContentView:UICollectionView = {[weak self] in
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: kGameCellW, height: kGameCellH)
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kSectionHeaderH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: kEdgeMargin, bottom: 0, right: kEdgeMargin)
        let allContentView = UICollectionView(frame: (self?.view.bounds)!, collectionViewLayout: layout)
        allContentView.dataSource = self
        allContentView.backgroundColor = UIColor.white
        allContentView.register(UINib(nibName: "GameCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: kGameCellId)
        allContentView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kGameHeaderId)
        allContentView.contentInset = UIEdgeInsets(top: kIconViewH+kSectionHeaderH, left: 0, bottom: 0, right: 0)
        allContentView.autoresizingMask = [.flexibleWidth,.flexibleHeight]

        return allContentView
    }()
    
    /*系统方法*/
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        requestData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//MARK:-设置UI
extension GameViewController{
    fileprivate func setupUI(){
        view.backgroundColor = UIColor.white
        
        view.addSubview(allContentView)
        
        allContentView.addSubview(topHeaderView)
        
        allContentView.addSubview(topIconView)
        
        baseContentView = allContentView
        isHiddenAnimation = false
        //请求数据
//        requestData()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let tempF = topHeaderView.groupIconImg.frame
        topHeaderView.groupIconImg.frame = CGRect(origin: tempF.origin, size: CGSize(width: 5, height: tempF.size.height))
//        if #available(iOS 9.0, *) {
//            let headV = allContentView.supplementaryView(forElementKind: UICollectionElementKindSectionHeader, at: IndexPath(item: 0, section: 0)) as? CollectionHeaderView
//            let tempF2 = headV?.groupIconImg.frame
//            headV?.groupIconImg.frame = CGRect(origin: (tempF2?.origin)!, size: CGSize(width: 5, height: (tempF2?.size.height)!))
//        } else {
//            // Fallback on earlier versions
//        }
        
        let tempF2 = supplementaryV?.groupIconImg.frame
        supplementaryV?.groupIconImg.frame = CGRect(origin: (tempF2?.origin)!, size: CGSize(width: 5, height: (tempF2?.size.height)!))
        
       
        
    }
}

//MARK:-网络请求
extension GameViewController{
    fileprivate func requestData(){
        gameVM.loadGameData {
            DispatchQueue.global().async {
                var tempArr:[CellGroupModel] = [CellGroupModel]()
                for tempM in self.gameVM.gameModelArr[0..<10]{
                    //                let tempM = tempM as? GameModel
                    let groupM = CellGroupModel(dict: ["icon_url":tempM.icon_url,"tag_name":tempM.tag_name])
                    tempArr.append(groupM)
                }
                DispatchQueue.main.async {
                    
                    self.topIconView.dataModelArr = tempArr
                    
                    self.allContentView.reloadData()
//                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1, execute: { 
//                        self.isHiddenAnimation = true
//                    })
                    self.isHiddenAnimation = true
                }
            }
        }
    }
}

//MARK:-数据源
extension GameViewController:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameVM.gameModelArr.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellId, for: indexPath) as! GameCollectionViewCell
        cell.gameModel = gameVM.gameModelArr[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kGameHeaderId, for: indexPath) as! CollectionHeaderView
        header.groupName.text = "全部"
        header.groupIconImg.image = UIImage(named: "Img_orange")
        header.moreBtn.isHidden = true
        supplementaryV = header
        return header
    }
}
