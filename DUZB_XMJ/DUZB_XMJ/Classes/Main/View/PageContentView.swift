//
//  PageContentView.swift
//  DUZB_XMJ
//
//  Created by user on 16/12/20.
//  Copyright © 2016年 XMJ. All rights reserved.
//

import UIKit

class PageContentView: UIView {

    fileprivate lazy var flowLayout = UICollectionViewFlowLayout()
    
    fileprivate lazy var collectionView : UICollectionView = {[weak self] in
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: (self?.flowLayout)!)
        collectionView.showsHorizontalScrollIndicator = false
    
        return collectionView
    }()
}
