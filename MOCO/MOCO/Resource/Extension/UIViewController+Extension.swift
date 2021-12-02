//
//  UIViewController+Extension.swift
//  MOCO
//
//  Created by 지영 on 2021/11/22.
//

import UIKit

extension UIViewController {

    func presentAlert(title: String, message: String, okTitle: String = "gotosetting".localized(), handler: @escaping () -> ()) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "cancel".localized(), style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: okTitle, style: .default, handler: { _ in
                handler()
            }))
            present(alert, animated: true, completion: nil)
        }
    
    func presentOkAlert(title: String, message: String) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "ok".localized(), style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    
    func openSettingURL() {
            guard let settingURL = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            if UIApplication.shared.canOpenURL(settingURL) {
                UIApplication.shared.open(settingURL, options: [:], completionHandler: nil)
            }
        }
    
}
