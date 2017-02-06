//
//  GameCollectionViewCell.swift
//  DUZB_XMJ
//
//  Created by user on 16/12/29.
//  Copyright © 2016年 XMJ. All rights reserved.
//

import UIKit
import Kingfisher
class GameCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var cellImg: UIImageView!
    @IBOutlet weak var titleL: UILabel!
    @IBOutlet weak var lineV: UIView!
    
    var gameModel:GameModel?{
        didSet{
            titleL.text = gameModel?.tag_name
            if let imgUrl = URL(string:gameModel?.icon_url ?? "") {
                cellImg.kf.setImage(with: imgUrl, placeholder: UIImage(named:"live_cell_default_phone"))
            }else{
                cellImg.image = UIImage(named: "live_cell_default_phone")
            }
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
