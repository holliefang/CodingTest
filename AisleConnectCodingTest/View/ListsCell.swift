//
//  ListsCell.swift
//  AisleConnectCodingTest
//
//  Created by Sihan Fang on 2019/8/16.
//  Copyright © 2019 Sihan Fang. All rights reserved.
//

import UIKit

class ListsCell: UITableViewCell {
    static let cellID = "ListsCell"
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var numberOfItemLabel: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
