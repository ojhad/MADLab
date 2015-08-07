//
//  ImageTableViewCell.swift
//  MADLab
//
//  Created by Dilip Ojha on 2015-08-07.
//  Copyright (c) 2015 madlab. All rights reserved.
//

import UIKit

class ImageTableViewCell: UITableViewCell {

    @IBOutlet weak var ivImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
