//
//  ExpenseViewController.swift
//  MOCO
//
//  Created by 지영 on 2021/11/21.
//

import UIKit
import Hero

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navConfigure()
        configure()
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
        dateButton.setTitle(DateFormatter.defaultFormat.string(from: Date()), for: .normal)
        
        expenseTextField.delegate = self
        placeTextField.delegate = self
        
        expenseTextField.addTarget(self, action: #selector(zeroFilter(_:)), for: .editingChanged)
        expenseTextField.placeholder = "amount".localized()
        expenseAlertLabel.text = "length_alert".localized(with: 10, comment: "10글자")
        expenseAlertLabel.isHidden = true
        
        dateLabel.text = "date".localized()

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
//        self.navigationController?.pushViewController(vc, animated: true)
        //TODO: search controller에서 돌아왔을때 (closure)
//        placeView.isHidden = false
//        placeTextField.isUserInteractionEnabled = false
//        placeTextField.text = "오프라인주소"
    }
    
    @IBAction func memoDidChange(_ sender: UITextField) {
        checkMaxLength(textField: placeTextField, maxLength: 15, alertLabel: placeMemoAlertLabel)
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
            return textFieldManager.shared.changeTextField(textField: expenseTextField, string: string, alertLabel: expenseAlertLabel, range: range, maxLength: 10)
        } else {
            return true
        }
    }
    
}
