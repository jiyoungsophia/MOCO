//
//  MonthCell.swift
//  MOCO
//
//  Created by 지영 on 2021/11/19.
//

import UIKit

class MonthCell: UICollectionViewCell {
    static let identifier = "MonthCell"
    
    @IBOutlet weak var monthButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

//    @IBAction func monthButtonClicked(_ sender: UIButton) {
//        monthButton.setTitleColor(UIColor.mocoOrange, for: .normal)
//    }
}
