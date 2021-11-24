//
//  UIView+Extensions.swift
//  MOCO
//
//  Created by 지영 on 2021/11/19.
//

import Foundation
import UIKit

extension UIView {
    
    func setViewShadow(backgroundColor: UIColor) {
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = 10
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = .zero
        self.layer.masksToBounds = false
    }
    
    func setCellShadow(backView: UIView) {
        backView.backgroundColor = UIColor.mocoPink
        backView.layer.masksToBounds = true
        backView.layer.cornerRadius = 10
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.4
        self.layer.shadowOffset = .zero
    }
    
    func setTopCornerRound(cornerRadius: CGFloat, maskedCorners: CACornerMask) {
            clipsToBounds = true
            layer.cornerRadius = cornerRadius
            layer.maskedCorners = CACornerMask(arrayLiteral: maskedCorners)
        }
}
