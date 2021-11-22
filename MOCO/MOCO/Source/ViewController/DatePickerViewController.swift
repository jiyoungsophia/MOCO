//
//  DatePickerViewController.swift
//  MOCO
//
//  Created by 지영 on 2021/11/22.
//

import UIKit

class DatePickerViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()

        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } else {
            
        }
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Date()
        
    }
    

}
