//
//  UIViewController+Extension.swift
//  MOCO
//
//  Created by 지영 on 2021/11/22.
//

import UIKit

extension UIViewController {
    func datePickerAlert(contentView: DatePickerViewController, dateBorder: UIView, dateButton: UIButton) {
        let alert = UIAlertController(title: "날짜를 선택해주세요", message: "", preferredStyle: .alert)
        
        alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor.white
        alert.setValue(contentView, forKey: "contentViewController")
        
        let cancel = UIAlertAction(title: "취소", style: .destructive) { _ in
            dateBorder.backgroundColor = UIColor.lightGray
        }
        
        let ok = UIAlertAction(title: "확인", style: .cancel) { _ in
            let value = DateFormatter.defaultFormat.string(from: contentView.datePicker.date)
            
            dateButton.setTitle(value, for: .normal)
            dateBorder.backgroundColor = UIColor.lightGray
        }
        alert.addAction(cancel)
        alert.addAction(ok)
        
        present(alert, animated: true, completion: nil)
    }
    
}
