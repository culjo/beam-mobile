//
//  ItemCell.swift
//  beam mobile
//
//  Created by MAC on 1/26/19.
//  Copyright © 2019 novugrid. All rights reserved.
//

import UIKit
import Kingfisher

class ItemCell: UITableViewCell {
    
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var subTitleLabe2: UILabel!
    @IBOutlet weak var metaLabel: UILabel!
    @IBOutlet weak var imageDisplayView: UIImageView!

    var userProduct: UserProduct?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateModel(with userProduct: UserProduct) {
        
        self.userProduct = userProduct
        
        guard self.userProduct != nil else {
            return
        }
        titleLabel.text = self.userProduct?.product.name
        
        imageDisplayView.kf.indicatorType = .activity
        let processor = RoundCornerImageProcessor(cornerRadius: 20)
        imageDisplayView.kf.setImage(with: URL(string: self.userProduct!.product.image), options: [.processor(processor)])
        
    }
    
    
}
