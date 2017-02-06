//
//  AdView.swift
//  DUZB_XMJ
//
//  Created by user on 16/12/28.
//  Copyright © 2016年 XMJ. All rights reserved.
//

import UIKit

fileprivate let kAdCollectionViewCellId = "kAdCollectionViewCellId"
fileprivate let pageW:CGFloat = 100
fileprivate let pageH:CGFloat = 30
class AdView: UIView {

    fileprivate lazy var adCollectionView:UICollectionView = {[weak self] in
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: kScreenW, height: (self?.bounds.height)!)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        let collectionV = UICollectionView(frame: (self?.bounds)!, collectionViewLayout: layout)
        collectionV.isPagingEnabled = true
        collectionV.showsHorizontalScrollIndicator = false
        collectionV.showsVerticalScrollIndicator = false
        collectionV.backgroundColor = UIColor.white
        collectionV.dataSource = self
        collectionV.delegate = self
        collectionV.bounces = false
        collectionV.register(UINib(nibName: "AdCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: kAdCollectionViewCellId)
        return collectionV
    }()
    
    fileprivate lazy var pageControll:UIPageControl = {[weak self] in
        let pageControll = UIPageControl()
        pageControll.currentPage = 0
        pageControll.currentPageIndicatorTintColor = UIColor.orange
        pageControll.pageIndicatorTintColor = UIColor.gray
        
        pageControll.frame = CGRect(x: kScreenW-pageW, y:(self?.bounds.height)!-pageH, width: pageW, height: pageH)
        pageControll.backgroundColor = UIColor.clear
        return pageControll
    }()
    
     var adModelsArr:[AdsModel]?{
        didSet{
            adCollectionView.reloadData()
            pageControll.numberOfPages = (adModelsArr?.count)!
            let indexP = IndexPath(item: (adModelsArr?.count)!*300, section: 0)
            adCollectionView.scrollToItem(at: indexP, at: .left, animated: false)
            
            stopCircle()
            startCircle()
        }
    }
    
    fileprivate var adTimer:Timer?
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

//MARK:-设置UI
extension AdView{
    fileprivate func setupUI(){
        
        addSubview(adCollectionView)
        addSubview(pageControll)
    }
}

//定时器
extension AdView{
    
    fileprivate func startCircle(){

        adTimer = Timer(timeInterval: 2, target: self, selector: #selector(scrollToNext), userInfo: nil, repeats: true)
        RunLoop.current.add(adTimer!, forMode: .commonModes)
    }
    
    fileprivate func stopCircle(){
        adTimer?.invalidate()
        adTimer = nil
    }
    
    @objc fileprivate func scrollToNext(){
        //        UIView.animate(withDuration: 1) {
        //            self.adCollectionView.contentOffset.x = self.adCollectionView.contentOffset.x + self.adCollectionView.bounds.width
        //        }
        let offsetX = self.adCollectionView.contentOffset.x + self.adCollectionView.bounds.width
        self.adCollectionView.setContentOffset(CGPoint(x:offsetX,y:0), animated: true)
 
    }
}

extension AdView:UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.adModelsArr?.count ?? 0)*1000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kAdCollectionViewCellId, for: indexPath) as! AdCollectionViewCell
        cell.adModel = adModelsArr?[indexPath.item%(self.adModelsArr?.count)!]
        return cell
        
    }
}

extension AdView:UICollectionViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
       pageControll.currentPage = Int(scrollView.contentOffset.x/scrollView.bounds.width+0.5)%(adModelsArr?.count)!
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        stopCircle()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        startCircle()
    }
}
