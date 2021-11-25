//
//  TripTableViewCell.swift
//  Tourist
//
//  Created by Anatoliy Serputov on 2021-11-25.
//

import UIKit

class TripTableViewCell: UITableViewCell {

    @IBOutlet weak var TripTitleLabel: UILabel!
    @IBOutlet weak var TripPriceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
