//
//  TableViewCell.swift
//  Piita
//
//  Created by 中嶋裕也 on 2018/11/21.
//  Copyright © 2018 中嶋裕也. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    
    @IBOutlet var iconImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var autherLabel: UILabel!
    


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.minimumScaleFactor = 0.7
        iconImageView.layer.cornerRadius = 10
        iconImageView.clipsToBounds = true
        self.clipsToBounds = true
        iconImageView.image = UIImage(named: "icon.png")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
