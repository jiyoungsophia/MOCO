//
//  IncomeViewController.swift
//  MOCO
//
//  Created by 지영 on 2021/11/21.
//

import UIKit


// fullscreen!!
class IncomeViewController: UIViewController {
    
    static let identifier = "IncomeViewController"
    
    @IBOutlet weak var incomeTextField: UITextField!
    @IBOutlet weak var border: UIView!
    @IBOutlet weak var lengthAlertLabel: UILabel!
    @IBOutlet weak var resetButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navConfigure()
        
        incomeTextField.delegate = self
        incomeTextField.placeholder = "amount".localized()
        incomeTextField.addTarget(self, action: #selector(zeroFilter(_:)), for: .editingChanged)
        
        lengthAlertLabel.text = "length_alert".localized(with: 10, comment: "10글자")
        lengthAlertLabel.isHidden = true
        
        resetButton.redButton()
        resetButton.setTitle("reset".localized(), for: .normal)
    }
    
    func navConfigure() {
        navigationItem.title = "income".localized()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "checkmark"), style: .plain, target: self, action: #selector(saveButtonClicked))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeButtonClicked))
        
        navigationItem.rightBarButtonItem?.tintColor = .black
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
    
    @objc func saveButtonClicked() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func closeButtonClicked() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func zeroFilter(_ textField: UITextField) {
        if let text = textField.text, let intText = Int(text) {
            textField.text = "\(intText)"
        } else {
            textField.text = ""
        }
    }
}

extension IncomeViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.border.backgroundColor = UIColor.mocoBlue
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.border.backgroundColor = UIColor.lightGray
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return textFieldManager.shared.changeTextField(textField: textField, string: string, alertLabel: lengthAlertLabel, range: range, maxLength: 10)
    }
    
}
