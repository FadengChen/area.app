//
//  DetailTableViewCell.swift
//  tableview
//
//  Created by 陈发登 on 4/4/17.
//  Copyright © 2017 陈发登. All rights reserved.
//

import UIKit

class DetailTableViewCell: UITableViewCell {
    @IBOutlet weak var ValueLabel: UILabel!

    @IBOutlet weak var fieldLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
