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
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(row: Search) {
        placeLabel.text = row.placeName
        addressLabel.text = row.roadAddress
        categoryLabel.text = row.categoryName
    }

}
