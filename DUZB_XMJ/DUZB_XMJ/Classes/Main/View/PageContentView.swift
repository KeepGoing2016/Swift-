//
//  PageContentView.swift
//  DUZB_XMJ
//
//  Created by user on 16/12/20.
//  Copyright © 2016年 XMJ. All rights reserved.
//

import UIKit

private let kPageContentCellID:String = "kPageContentCellID"

protocol PageContentViewDelegate:class {
    func pageContentView(_ pageContentView:PageContentView,fromIndex:Int,toIndex:Int,progress:CGFloat)
}

class PageContentView: UIView {

    var childVCs = [UIViewController]()
    var parentVC = UIViewController()
    var lastOffsetX:CGFloat = 0
    var currentOffsetX:CGFloat = 0
    weak var delegate:PageContentViewDelegate?
    var isForbidScrollDelegate:Bool = false
    
    
    fileprivate lazy var collectionView : UICollectionView = {[weak self] in
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = (self?.bounds.size)!
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.scrollsToTop = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kPageContentCellID)
        
        return collectionView
    }()
    
    init(frame: CGRect,childVCs:[UIViewController],parentVC:UIViewController) {
        self.childVCs = childVCs
        self.parentVC = parentVC
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//设置UI
extension PageContentView{
    
    fileprivate func setupUI(){
        collectionView.frame = self.bounds
        for childvc in childVCs {
            parentVC.addChildViewController(childvc)
        }
        addSubview(collectionView)
    }
}

//collectionView数据源
extension PageContentView:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.childVCs.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPageContentCellID, for: indexPath)
        
        for view in cell.subviews {
            view.removeFromSuperview()
        }
        let vc = self.childVCs[indexPath.item]
        vc.view.frame = cell.bounds
        cell.addSubview(vc.view)
//        parentVC.addChildViewController(vc)
        
        return cell
    }
}

//collectionView代理方法
extension PageContentView:UICollectionViewDelegate{
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isForbidScrollDelegate = false
        lastOffsetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if isForbidScrollDelegate { return}
        currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        
        if  currentOffsetX > lastOffsetX {
            var progress = currentOffsetX/scrollViewW - floor(currentOffsetX/scrollViewW)
            let fromIndex = Int(currentOffsetX/scrollViewW)
            var toIndex = fromIndex+1
            if toIndex>childVCs.count-1 {
                toIndex = childVCs.count-1
            }
//            if currentOffsetX % kScreenW==0 {}
            if currentOffsetX-lastOffsetX == scrollViewW {
                progress = 1
                toIndex = fromIndex
            }
            delegate?.pageContentView(self,fromIndex:fromIndex ,toIndex:toIndex,progress:progress)
//            print(progress)
        }else{
            let progress = 1-(currentOffsetX/scrollViewW - floor(currentOffsetX/scrollViewW))
            let toIndex = Int(currentOffsetX/scrollViewW)
            var fromIndex = toIndex+1
            if fromIndex>=childVCs.count{
                fromIndex = childVCs.count-1
            }
            delegate?.pageContentView(self,fromIndex:fromIndex,toIndex:toIndex,progress:progress)
        }

//        lastOffsetX = currentOffsetX
        
//        if scrollView.contentOffset.x- {
//            <#code#>
//        }
    }
}

//对外暴露的方法
extension PageContentView{
    func pageContentViewScrollTo(index:Int) {
        isForbidScrollDelegate = true
//        collectionView.contentOffset.x = CGFloat(index)*kScreenW
        collectionView.setContentOffset(CGPoint(x:CGFloat(index)*kScreenW,y:0), animated: false)
    }
}

