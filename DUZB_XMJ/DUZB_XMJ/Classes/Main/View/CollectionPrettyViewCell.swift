//
//  CollectionPrettyViewCell.swift
//  DUZB_XMJ
//
//  Created by user on 16/12/27.
//  Copyright © 2016年 XMJ. All rights reserved.
//

import UIKit
import Kingfisher
class CollectionPrettyViewCell: UICollectionViewCell {
    @IBOutlet weak var locationL: UILabel!
    @IBOutlet weak var nickNameL: UILabel!
    @IBOutlet weak var roomImg: UIImageView!
    @IBOutlet weak var onlineL: UILabel!
   
    var cellModel : NormalCellModel?{
        didSet{
            guard let cellModel = cellModel else {
                return
            }
            if cellModel.online > 10000 {
                onlineL.text = "\(Int(cellModel.online/10000))万在线"
            }else{
                onlineL.text = "\(cellModel.online)在线"
            }
            locationL.text = cellModel.anchor_city
            nickNameL.text = cellModel.nickname
            
            guard let imgURL = URL(string:cellModel.vertical_src) else {
                return
            }
            roomImg.kf.setImage(with: imgURL, placeholder: UIImage(named:"live_cell_default_phone"))
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
