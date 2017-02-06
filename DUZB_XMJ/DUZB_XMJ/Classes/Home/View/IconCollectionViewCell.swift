//
//  IconCollectionViewCell.swift
//  DUZB_XMJ
//
//  Created by user on 16/12/28.
//  Copyright © 2016年 XMJ. All rights reserved.
//

import UIKit
import Alamofire
class IconCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var iconImg: UIImageView!
    @IBOutlet weak var iconL: UILabel!
    
    var dataM:CellGroupModel?{
        didSet{
            iconL.text = dataM?.tag_name
//            guard let iconUrl = URL(string:(dataM?.icon_url)!) else {
//                return
//            }
//            iconImg.kf.setImage(with: iconUrl, placeholder: UIImage(named: "home_more_btn"))
            if let iconUrl = URL(string: dataM?.icon_url ?? "") {
                iconImg.kf.setImage(with: iconUrl, placeholder: UIImage(named: "home_more_btn"))
            }else{
                iconImg.image = UIImage(named: "home_more_btn")
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        iconImg.layer.cornerRadius = 22
        iconImg.layer.masksToBounds = true
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
