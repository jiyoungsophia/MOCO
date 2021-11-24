//
//  ExpenseCell.swift
//  MOCO
//
//  Created by 지영 on 2021/11/19.
//

import UIKit

class ExpenseCell: UICollectionViewCell {

    static let identifier = "ExpenseCell"
    
    @IBOutlet weak var backView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setCellShadow(backView: backView)
        
        
    }
}
