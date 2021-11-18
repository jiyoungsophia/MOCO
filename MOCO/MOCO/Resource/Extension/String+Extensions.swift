//
//  String+Extensions.swift
//  MOCO
//
//  Created by 지영 on 2021/11/18.
//

import Foundation


extension String {
    func localized(comment: String = "") -> String {
        return NSLocalizedString(self, value: "", comment: comment)
    }
    
    func localized(with argument: CVarArg = [], comment: String = "") -> String {
            return String(format: self.localized(comment: comment), argument)
        }
}
