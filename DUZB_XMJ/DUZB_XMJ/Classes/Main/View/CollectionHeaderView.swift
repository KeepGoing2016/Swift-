//
//  CollectionHeaderView.swift
//  DUZB_XMJ
//
//  Created by user on 16/12/26.
//  Copyright © 2016年 XMJ. All rights reserved.
//

import UIKit

class CollectionHeaderView: UICollectionReusableView {
    @IBOutlet weak var groupIconImg: UIImageView!
    
    @IBOutlet weak var groupName: UILabel!
    
    @IBOutlet weak var moreBtn: UIButton!
    var groupM:CellGroupModel?{
        didSet{
            guard let groupM = groupM else {
                return
            }
            groupIconImg.image = UIImage(named: groupM.icon_name)
            groupName.text = groupM.tag_name
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}

//MARK:-对外提供
extension CollectionHeaderView{
    class func headerView()->CollectionHeaderView{
        return Bundle.main.loadNibNamed("CollectionHeaderView", owner: self, options: nil)?.first as! CollectionHeaderView
    }
}
