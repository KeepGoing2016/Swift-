//
//  PageTitleView.swift
//  DUZB_XMJ
//
//  Created by user on 16/12/20.
//  Copyright © 2016年 XMJ. All rights reserved.
//

import UIKit

private let kLineHeight:CGFloat = 2
private let kNormalColor:(CGFloat,CGFloat,CGFloat) = (85,85,85)
private let kSelectColor:(CGFloat,CGFloat,CGFloat) = (255,128,0)

protocol PageTitleViewDelegate:class {
    func pageTitleView(_ titleView:PageTitleView,selectedIndex index:Int)
}

class PageTitleView: UIView {

    fileprivate var oldIndex = 0
    fileprivate var titles:[String] = []
    weak var delegate:PageTitleViewDelegate?
    
    fileprivate lazy var scrollBg = { () -> UIScrollView in
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
        scrollView.scrollsToTop = false
        return scrollView
    }()
    
    fileprivate lazy var titleLables = [UILabel]()
    
    fileprivate lazy var scrollLine = { ()-> UIView in
        let lineV = UIView()
        lineV.backgroundColor = UIColor.orange
        return lineV
    }()
    
    init(frame:CGRect,titles:[String]){
        self.titles = titles
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK:-设置UI
extension PageTitleView{

    fileprivate func setupUI(){
        //设置scrollView
        self.addSubview(scrollBg)
        scrollBg.frame = self.bounds
        
        //设置title
        setupTitleLable()
        
        //设置底部线条及scrollLine
        setupBottomLineAndScrollLine()
    }
    
    fileprivate func setupTitleLable(){
        let labelY:CGFloat = 0
        let labelW:CGFloat = kScreenW/CGFloat(titles.count)
        let labelH = self.bounds.size.height - kLineHeight
        
        for (index,title) in titles.enumerated() {
            let label = UILabel()
            label.text = title
            label.tag = index
            label.textAlignment = .center
            label.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
            label.font = UIFont.systemFont(ofSize: 16)
            scrollBg.addSubview(label)
            let labelX = labelW*CGFloat(index)
            
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            titleLables.append(label)
            
            //添加手势
            label.isUserInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(clickTitleLable(_:)))
            
            label.addGestureRecognizer(tapGesture)
        }
    }
    
    fileprivate func setupBottomLineAndScrollLine(){
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        let bottomLineH:CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: bounds.size.height-bottomLineH, width: kScreenW, height: bottomLineH)
        addSubview(bottomLine)
        
        guard let firstLabel = titleLables.first else{return}
        
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: bounds.size.height-kLineHeight, width: firstLabel.bounds.size.width-10, height: kLineHeight)
        scrollLine.center.x = firstLabel.center.x
        scrollBg.addSubview(scrollLine)
    }
}

//MARK:-监听lable点击
extension PageTitleView{
    @objc fileprivate func clickTitleLable(_ tapGesture:UITapGestureRecognizer) {
        guard let currenLable = tapGesture.view as? UILabel else {return}
        let currentIndex = currenLable.tag
        
        if oldIndex == currentIndex {return}
        let oldLable = titleLables[oldIndex]
        oldLable.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
        currenLable.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        oldIndex = currentIndex

//        let scrollLineX = CGFloat(currentIndex)*currenLable.bounds.size.width
        UIView.animate(withDuration: 0.5) {
//            self.scrollLine.frame.origin.x = scrollLineX
            self.scrollLine.center.x = currenLable.center.x
        }
        
        delegate?.pageTitleView(self, selectedIndex: currentIndex)
    }
}

//MARK:-对外暴露的方法
extension PageTitleView{
    func pageTitleViewScrollTo(fromIndex:Int ,toIndex:Int,progress:CGFloat){
        
        print(progress)
        let toLable = titleLables[toIndex]
        let fromeLable = titleLables[fromIndex]
        scrollLine.center.x = fromeLable.center.x+(toLable.center.x-fromeLable.center.x)*progress
        
        let deltaColor = (kSelectColor.0-kNormalColor.0,kSelectColor.1-kNormalColor.1,kSelectColor.2-kNormalColor.2)
        fromeLable.textColor = UIColor(r: kSelectColor.0-deltaColor.0*progress, g: kSelectColor.1-deltaColor.1*progress, b: kSelectColor.2-deltaColor.2*progress)
        toLable.textColor = UIColor(r: kNormalColor.0+deltaColor.0*progress, g: kNormalColor.1+deltaColor.1*progress, b: kNormalColor.2+deltaColor.2*progress)
        oldIndex = toIndex
    }
}
