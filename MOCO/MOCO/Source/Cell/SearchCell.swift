//
//  SearchCell.swift
//  MOCO
//
//  Created by 지영 on 2021/11/23.
//

import UIKit

class SearchCell: UITableViewCell {

    static let identifier = "SearchCell"
    
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var adressLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
