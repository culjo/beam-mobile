//
//  ProductTableViewCell.swift
//  beam mobile
//
//  Created by MAC on 1/27/19.
//  Copyright © 2019 novugrid. All rights reserved.
//

import UIKit
import Kingfisher


protocol OnCellButtonClicked {
    func onCellButtonClicked(product: Product)
}

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var metaLabel: UILabel!
    @IBOutlet weak var imageDisplayView: UIImageView!
    
    var onCellButtonClicked: OnCellButtonClicked?
    
    var product: Product?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        addButton.layer.cornerRadius = 4.0
        imageDisplayView.layer.cornerRadius = 3.0
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateModel(with product: Product) {
        self.product = product
        
        titleLabel.text = product.name
        subTitleLabel.text = " \u{20A6} \(product.price)"
        metaLabel.text = product.discount
        
        imageDisplayView.kf.indicatorType = .activity
        imageDisplayView.kf.setImage(with: URL(string: product.image))
    }
    
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        
        if let buttonDelegate = onCellButtonClicked {
            
            buttonDelegate.onCellButtonClicked(product: product!)
        }
        
        
    }
    
}
