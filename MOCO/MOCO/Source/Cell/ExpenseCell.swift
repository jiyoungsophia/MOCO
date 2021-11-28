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
    @IBOutlet weak var categoryIconLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setCellShadow(backView: backView)
    }
    
    func configureCell(item: Expense, place: Place) {
        
        categoryIconLabel.text = CategoryDict[place.categoryCode ?? "0"]
        placeLabel.text = item.memo
        amountLabel.text = "- \(item.amount.formatWithSeparator)"
        dateLabel.text = DateFormatter.defaultFormat.string(from: item.regDate)
    }
}
