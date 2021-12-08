//
//  IncomeViewController.swift
//  MOCO
//
//  Created by 지영 on 2021/11/21.
//

import UIKit
import RealmSwift

class IncomeViewController: UIViewController {
    
    static let identifier = "IncomeViewController"
    
    @IBOutlet weak var incomeTextField: UITextField!
    @IBOutlet weak var border: UIView!
    @IBOutlet weak var lengthAlertLabel: UILabel!
    @IBOutlet weak var resetButton: UIButton!
    
    var incomeData: [Income] = []

    var year: Int = 0
    var month: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        loadIncome()
        navConfigure()
        configure()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        incomeTextField.becomeFirstResponder()
    }
    
    func navConfigure() {
        navigationItem.title = "budget".localized()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "checkmark"), style: .plain, target: self, action: #selector(saveButtonClicked))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeButtonClicked))
        
        navigationItem.rightBarButtonItem?.tintColor = .black
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
    
    func configure() {
        incomeTextField.delegate = self
        incomeTextField.addTarget(self, action: #selector(zeroFilter(_:)), for: .editingChanged)
        
        lengthAlertLabel.text = "length_alert".localized(with: 8, comment: "8글자")
        lengthAlertLabel.isHidden = true
        
        resetButton.redButton()
        resetButton.setTitle("reset".localized(), for: .normal)
    }
    
    func loadIncome() {
  
        incomeData = RealmManager.shared.loadIncome(year: year, month: month)

        if !incomeData.isEmpty {
            resetButton.isHidden = false
            incomeTextField.placeholder = incomeData[0].amount.formatWithSeparator
            print(incomeData[0].amount.formatWithSeparator)
        } else {
            resetButton.isHidden = true
            incomeTextField.placeholder = "amount".localized()
        }
    }
    
    @objc func saveButtonClicked() {
        // 입력 있을때
        if let income = incomeTextField.text, income != "0", income != "" {
            
            let amount = InputManager.shared.textToInt(text: income)
            let now = DateFormatter.krFormat.string(from: Date())
    
            if incomeData.isEmpty { // 새 수입등록
                let newIncome = Income(amount: amount, regDate: DateFormatter.krFormat.date(from: now)!, year: year, month: month)
                RealmManager.shared.saveIncome(income: newIncome)
            } else { // 업데이트
                RealmManager.shared.updateIncome(income: incomeData[0], amount: amount, regDate: Date())
            }
            self.dismiss(animated: true, completion: nil)
            
        } else {    // 입력 없을 때
            presentAlert(title: "failedtosave".localized(), message: "writebudget".localized(), okTitle: "ok".localized()) {
            self.incomeTextField.becomeFirstResponder()
            }
        }
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
    
    @IBAction func resetButtonClicked(_ sender: UIButton) {
        presentAlert(title: "초기화하시겠습니까?", message: "이번 달 예산이 초기화됩니다", okTitle: "삭제") {
            RealmManager.shared.deleteIncome(id: self.incomeData[0]._id)
            self.closeButtonClicked()
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
        return textFieldManager.shared.changeTextField(textField: textField, string: string, alertLabel: lengthAlertLabel, range: range, maxLength: 11)
    }
}
