//
//  ExpenseViewController.swift
//  MOCO
//
//  Created by 지영 on 2021/11/21.
//

import UIKit
import Hero
import RealmSwift

class ExpenseViewController: UIViewController {
    
    static let identifier = "ExpenseViewController"
    
    @IBOutlet weak var expenseTextField: UITextField!
    @IBOutlet weak var expenseBorder: UIView!
    @IBOutlet weak var expenseAlertLabel: UILabel!
    
    @IBOutlet weak var dateButton: UIButton!
    @IBOutlet weak var dateBorder: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var placeView: UIView!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var placeMemoLabel: UILabel!
    @IBOutlet weak var placeMemoAlertLabel: UILabel!
    @IBOutlet weak var placeTextField: UITextField!
    @IBOutlet weak var placeBorder: UIView!
    @IBOutlet weak var onlineButton: UIButton!
    @IBOutlet weak var offlineButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    var buttonStatus: Bool = false
    var expenseData: Expense?
    var dateList: [Int] = []
    var isOffline: Bool = false
    var placeId: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navConfigure()
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if expenseData != nil {
            editConfig()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        expenseTextField.becomeFirstResponder()
    }
    
    func navConfigure() {
        navigationItem.title = "expense".localized()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "checkmark"), style: .plain, target: self, action: #selector(saveButtonClicked))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeButtonClicked))
        
        navigationItem.rightBarButtonItem?.tintColor = .black
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
    
    func configure() {
        placeView.isHidden = true
        dateButton.setTitle(DateFormatter.defaultFormat.string(from: expenseData?.regDate ?? Date()), for: .normal)
        
        expenseTextField.delegate = self
        placeTextField.delegate = self
        
        expenseTextField.addTarget(self, action: #selector(zeroFilter(_:)), for: .editingChanged)
        expenseTextField.placeholder = "amount".localized()
        expenseTextField.text = expenseData?.amount.formatWithSeparator
        expenseAlertLabel.text = "length_alert".localized(with: 8, comment: "8글자")
        expenseAlertLabel.isHidden = true
        
        dateLabel.text = "date".localized()
        dateButton.isUserInteractionEnabled = buttonStatus
        if dateButton.isUserInteractionEnabled == false {
            dateButton.setTitleColor(.lightGray, for: .normal)
        }
        
        placeLabel.text = "place".localized()
        placeMemoLabel.text = "place".localized()
        placeMemoAlertLabel.text = "length_alert".localized(with: 15, comment: "15글자")
        placeMemoAlertLabel.isHidden = true
        
        onlineButton.placeButton()
        onlineButton.setTitle("online".localized(), for: .normal)
        offlineButton.placeButton()
        offlineButton.setTitle("offline".localized(), for: .normal)
        
        deleteButton.redButton()
        deleteButton.setTitle("delete".localized(), for: .normal)
        deleteButton.isHidden = buttonStatus
            
    }
    
    func editConfig() {
        if expenseData?.isOffline == true {
            offlineButton.placeButtonClicked()
            onlineButton.placeButton()
            onlineButton.isUserInteractionEnabled = false
            placeTextField.isUserInteractionEnabled = false
            placeTextField.textColor = .lightGray
            placeId = expenseData?.placeId ?? 0
        } else if expenseData?.isOffline == false {
            onlineButton.placeButtonClicked()
            offlineButton.placeButton()
        }
        placeView.isHidden = false
        placeLabel.isHidden = true
        placeTextField.text = expenseData?.memo
    }
    
    @objc func saveButtonClicked() {
        // 입력 다 한 경우
        if let expenseText = expenseTextField.text, expenseText != "0", expenseText != "",
           let date = DateFormatter.defaultFormat.date(from: dateButton.currentTitle!),
           let placeText = placeTextField.text, placeText != "" {
            
            let amount = InputManager.shared.textToInt(text: expenseText)
            if offlineButton.backgroundColor == UIColor.mocoPink && placeTextField.textColor == UIColor.lightGray {
                isOffline = placeStatus.offline.description
            } else {
                isOffline = placeStatus.online.description
            }
            
            dateList = InputManager.shared.dateToYearMonth(date: date)

            if let expense = expenseData { // 수정일 경우
                RealmManager.shared.updateExpense(expense: expense, amount: amount, regDate: date, isOffline: isOffline, placeId: placeId, memo: placeText, year: dateList[0], month: dateList[1])
                self.dismiss(animated: true, completion: nil)
            } else { // 새로 등록일 경우
                let newExpense = Expense(amount: amount, regDate: date, isOffline: isOffline, placeId: placeId, memo: placeText, year: dateList[0], month: dateList[1])
                RealmManager.shared.saveExpense(expense: newExpense)
                self.dismiss(animated: true, completion: nil)
            }
        } else { // 하나라도 입력 없을 때
            presentOkAlert(title: "failedtosave".localized(), message: "enterall".localized())
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
    
    @IBAction func dateButtonClicked(_ sender: UIButton) {
        self.dateBorder.backgroundColor = UIColor.mocoPink
        
        guard let contentView = self.storyboard?.instantiateViewController(withIdentifier: "DatePickerViewController") as? DatePickerViewController else {
            return
        }
        contentView.view.backgroundColor = .clear
        self.datePickerAlert(contentView: contentView, dateBorder: self.dateBorder, dateButton: self.dateButton)
    }
    
    func checkMaxLength(textField: UITextField!, maxLength: Int, alertLabel: UILabel) {
        if (textField.text!.count > maxLength) {
            textField.deleteBackward()
            alertLabel.isHidden = false
        } else {
            alertLabel.isHidden = true
        }
    }
    
    
    @IBAction func onlineButtonClicked(_ sender: UIButton) {
        placeView.isHidden = false
        placeLabel.isHidden = true
        placeTextField.text = "online".localized()
        onlineButton.placeButtonClicked()
        offlineButton.placeButton()
    }
    
    @IBAction func offlineButtonClicked(_ sender: UIButton) {
        offlineButton.placeButtonClicked()
        onlineButton.placeButton()
        
        if placeView.isHidden == false {
            placeView.isHidden = true
            placeTextField.text = ""
        }
        
        let sb = UIStoryboard(name: "Search", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: SearchViewController.identifier) as! SearchViewController
        present(vc, animated: true, completion: nil)
        
        vc.selectPlaceHandler = { [weak self] idData, nameData in
            self?.placeLabel.isHidden = true
            self?.placeView.isHidden = false
            self?.placeTextField.isUserInteractionEnabled = false
            self?.placeTextField.text = nameData
            self?.placeId = idData
            self?.placeTextField.textColor = .lightGray
        }
    }
    
    @IBAction func memoDidChange(_ sender: UITextField) {
        checkMaxLength(textField: placeTextField, maxLength: 15, alertLabel: placeMemoAlertLabel)
    }
    
    @IBAction func deleteButtonClicked(_ sender: UIButton) {
        presentAlert(title: "삭제하시겠습니까?", message: "이 지출이 삭제됩니다", okTitle: "삭제") {
            RealmManager.shared.deleteExpense(id: self.expenseData!._id)
            self.closeButtonClicked()
        }
    }
    
}

extension ExpenseViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == expenseTextField {
            self.expenseBorder.backgroundColor = UIColor.mocoPink
        } else {
            self.placeBorder.backgroundColor = UIColor.mocoPink
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == expenseTextField {
            self.expenseBorder.backgroundColor = UIColor.lightGray
        } else {
            self.placeBorder.backgroundColor = UIColor.lightGray
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == expenseTextField {
            return textFieldManager.shared.changeTextField(textField: expenseTextField, string: string, alertLabel: expenseAlertLabel, range: range, maxLength: 11)
        } else {
            return true
        }
    }
}
