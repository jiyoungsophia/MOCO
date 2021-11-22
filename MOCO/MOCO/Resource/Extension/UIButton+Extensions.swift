//
//  UIButton+Extensions.swift
//  MOCO
//
//  Created by 지영 on 2021/11/22.
//

import UIKit

extension UIButton {
    func placeButtonClicked() {
        self.backgroundColor = UIColor.mocoBlue
        self.setTitleColor(.white, for: .normal)
        self.layer.cornerRadius = 25
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = .zero
        self.layer.masksToBounds = false
    }
    
    func placeButton() {
        self.backgroundColor = UIColor.lightGray
        self.setTitleColor(.white, for: .normal)
        self.layer.cornerRadius = 25
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = .zero
        self.layer.masksToBounds = false
    }
    
    func redButton() {
        self.backgroundColor = .clear
        self.setTitleColor(UIColor.mocoRed, for: .normal)
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.mocoRed.cgColor
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = false
    }
}

