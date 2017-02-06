//
//  NormallCollectionViewCell.swift
//  DUZB_XMJ
//
//  Created by user on 16/12/26.
//  Copyright © 2016年 XMJ. All rights reserved.
//

import UIKit
import Kingfisher
class NormallCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var roomNameL: UILabel!
    @IBOutlet weak var roomImg: UIImageView!
    @IBOutlet weak var nickNameL: UILabel!
    @IBOutlet weak var OnlineBtn: UIButton!

    var normalModel:NormalCellModel?{
        didSet{
            guard let normalM = normalModel else {
                return
            }
            if normalM.online > 10000 {
                let oneline = "\(Int(normalM.online/10000))万在线"
                
                OnlineBtn.setTitle(oneline, for: .normal)
            }else{
                OnlineBtn.setTitle("\(normalM.online)在线", for: .normal)
            }
            roomNameL.text = normalM.room_name
            nickNameL.text = normalM.nickname
            
            guard let imgURL = URL(string:normalM.vertical_src) else {
                return
            }
            roomImg.kf.setImage(with: imgURL, placeholder: UIImage(named:"Img_default"))
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
