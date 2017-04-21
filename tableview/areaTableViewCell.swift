//
//  areaTableViewCell.swift
//  tableview
//
//  Created by 陈发登 on 20/3/17.
//  Copyright © 2017 陈发登. All rights reserved.
//

import UIKit

class areaTableViewCell: UITableViewCell {
    
    @IBOutlet weak var tupian: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var province: UILabel!
    @IBOutlet weak var heart: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
