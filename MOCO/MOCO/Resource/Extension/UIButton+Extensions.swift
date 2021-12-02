//
//  UIButton+Extensions.swift
//  MOCO
//
//  Created by 지영 on 2021/11/22.
//

import UIKit

extension UIButton {
    func placeButtonClicked() {
        self.backgroundColor = UIColor.mocoPink
        self.setTitleColor(.white, for: .normal)
        self.layer.cornerRadius = 22
        self.layer.masksToBounds = false
    }
    
    func placeButton() {
        self.backgroundColor = UIColor.lightGray
        self.setTitleColor(.white, for: .normal)
        self.layer.cornerRadius = 22
        self.layer.masksToBounds = false
    }
    
    func redButton() {
        self.backgroundColor = .clear
        self.setTitleColor(UIColor.mocoRed, for: .normal)
        self.layer.masksToBounds = false
    }
}

