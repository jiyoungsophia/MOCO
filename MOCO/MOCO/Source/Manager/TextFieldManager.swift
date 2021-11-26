//
//  TextFieldManager.swift
//  MOCO
//
//  Created by 지영 on 2021/11/22.
//

import UIKit

final class textFieldManager {
    private init() {}
    static let shared = textFieldManager()
    
//    @objc func zeroFilter(_ textField: UITextField) {
//        if let text = textField.text, let intText = Int(text) {
//            textField.text = "\(intText)"
//        } else {
//            textField.text = ""
//        }
//    }
    
    func changeTextField(textField: UITextField, string: String, alertLabel: UILabel, range: NSRange, maxLength: Int) -> Bool {
        if let textWithoutSeparator = textField.text?.replacingOccurrences(of: NumberFormatter.defaultFormat.groupingSeparator, with: "") {
            var beforeForemattedString = textWithoutSeparator + string // 이전 입력숫자 + 새 입력숫자
            
            if NumberFormatter.defaultFormat.number(from: string) != nil { // 10글자 이하일 때
                if let formattedNumber = NumberFormatter.defaultFormat.number(from: beforeForemattedString), let formattedString = NumberFormatter.defaultFormat.string(from: formattedNumber), formattedString.count < 14 {
                    textField.text = formattedString
                    alertLabel.isHidden = true
                    return false
                    
                } else { // 10글자 이상이면 입력 제한
                    guard let text = textField.text,
                          let rangeOfTextToReplace = Range(range, in: text) else {
                        return false
                    }
                    let substringToReplace = text[rangeOfTextToReplace]
                    let count = text.count - substringToReplace.count + string.count
                    alertLabel.isHidden = false
                    return count < 14
                }
            } else {
                if string == "" { // 백스페이스일때
                    alertLabel.isHidden = true
                    
                    let lastIndex = beforeForemattedString.index(beforeForemattedString.endIndex, offsetBy: -1)
                    beforeForemattedString = String(beforeForemattedString[..<lastIndex])
                    if let formattedNumber = NumberFormatter.defaultFormat.number(from: beforeForemattedString), let formattedString = NumberFormatter.defaultFormat.string(from: formattedNumber){
                        textField.text = formattedString
                        return false
                    }
                } else { // 문자일때
                    let invalidCharacters = CharacterSet(charactersIn: "0123456789").inverted
                    return string.rangeOfCharacter(from: invalidCharacters) == nil
                }
            }
        }
        return true
    }
}
