//
//  AdCollectionViewCell.swift
//  DUZB_XMJ
//
//  Created by user on 16/12/28.
//  Copyright © 2016年 XMJ. All rights reserved.
//

import UIKit
import Kingfisher
class AdCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var adImg: UIImageView!
    @IBOutlet weak var titleL: UILabel!

    var adModel:AdsModel?{
        didSet{
            titleL.text = adModel?.title
            guard let imgUrl = URL(string:(adModel?.pic_url)!) else {
                return
            }
            adImg.kf.setImage(with: imgUrl, placeholder: UIImage(named:"Img_default"))
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        autoresizingMask = [.flexibleWidth,.flexibleHeight]
    }

}
