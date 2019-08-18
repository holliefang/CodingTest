//
//  ListCell.swift
//  AisleConnectCodingTest
//
//  Created by Sihan Fang on 2019/8/18.
//  Copyright © 2019 Sihan Fang. All rights reserved.
//

import UIKit

class ListCell: UITableViewCell {
    static let cellID = "ListCell"
    
    @IBOutlet weak var bookCoverImageView: UIImageView!
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var bookAuthorLabel: UILabel!
    
    var product: Product? {
        didSet {
            guard let product = product else {return}
            bookCoverImageView.image = product.imageUrl.getImage()
            bookTitleLabel.text = product.name
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization codestatic let cellID = "ListsCell"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
