//
//  SettingViewController.swift
//  MOCO
//
//  Created by 지영 on 2021/11/24.
//

import UIKit
import MobileCoreServices
import MessageUI
import Hero
import Zip
import JGProgressHUD

class SettingViewController: UIViewController {
    
    static let identifier = "SettingViewController"
    
    let progress = JGProgressHUD()

    @IBOutlet var swipeRecognizer: UISwipeGestureRecognizer!
    @IBOutlet weak var settingLabel: UILabel!
    @IBOutlet weak var backupButton: UIButton!
    @IBOutlet weak var restoreButton: UIButton!
    @IBOutlet weak var feedbackButton: UIButton!
    @IBOutlet weak var versionButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        swipeRecognizer.direction = .left
        
        settingLabel.text = "setting".localized()
        backupButton.setTitle("backup".localized(), for: .normal)
        restoreButton.setTitle("restore".localized(), for: .normal)
        feedbackButton.setTitle("feedback".localized(), for: .normal)
        versionButton.setTitle("version".localized(with: [1,0,0]), for: .normal)
        
    }
    
    // 도큐먼트 폴더 위치
    func documentDirectoryPath() -> String? {
        let documentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let path = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)
        
        if let directoryPath = path.first {
            return directoryPath
        } else {
            return nil
        }
    }
    
    func presentActivityViewController() {
        let fileName = (documentDirectoryPath()! as NSString).appendingPathComponent("archive.zip")
        let fileURL = URL(fileURLWithPath: fileName)
        
        let vc = UIActivityViewController(activityItems: [fileURL], applicationActivities: [])
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func backupButtonClicked(_ sender: UIButton) {
        var urlPaths = [URL]()
        
        if let path = documentDirectoryPath() {
            let realm = (path as NSString).appendingPathComponent("default.realm")
            if FileManager.default.fileExists(atPath: realm) {
                urlPaths.append(URL(string: realm)!)
            } else {
                presentOkAlert(title: "nobackupfile".localized(), message: "")
            }
        }
        do {
            let zipFilePath = try Zip.quickZipFiles(urlPaths, fileName: "MOCO_backup") // Zip
            presentActivityViewController()
        }
        catch {
            print("Something went wrong")
        }
    }
    
    @IBAction func restoreButtonClicked(_ sender: UIButton) {
        let documentPicker = UIDocumentPickerViewController(documentTypes: [kUTTypeArchive as String], in: .import)
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        self.present(documentPicker, animated: true, completion: nil)
    }
    
    @IBAction func feedbackButtonClicked(_ sender: UIButton) {
        if MFMailComposeViewController.canSendMail() {
            
            let compseVC = MFMailComposeViewController()
            compseVC.mailComposeDelegate = self
            
            compseVC.setToRecipients(["sophiathedev@gmail.com"])
            compseVC.setSubject("[MOCO 피드백]")
            compseVC.setMessageBody("MOCO에 대한 피드백이나 문의사항을 남겨주세요 :)", isHTML: false)
            
            self.present(compseVC, animated: true, completion: nil)
        }
        else {
            presentOkAlert(title: "checkemail".localized(), message: "")
        }
    }
    
    
    @IBAction func backButtonClicked(_ sender: UIButton) {
        hero.modalAnimationType = .slide(direction: .left)
        hero.dismissViewController()
    }
    
    @IBAction func swipeAction(_ sender: UISwipeGestureRecognizer) {
        if swipeRecognizer.direction == .left {
            hero.modalAnimationType = .slide(direction: .left)
            hero.dismissViewController()
        }
    }
}

extension SettingViewController: UIDocumentPickerDelegate {
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {

        guard let selectedFileURL = urls.first else { return }
        let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let sandboxFileURL = directory.appendingPathComponent(selectedFileURL.lastPathComponent)
        
        if FileManager.default.fileExists(atPath: sandboxFileURL.path) {
            do {
                let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                let fileURL = documentDirectory.appendingPathComponent("archive.zip")
                
                self.progress.show(in: self.view, animated: true)
                try Zip.unzipFile(fileURL, destination: documentDirectory, overwrite: true, password: nil, progress: { progress in
                    print("progress: \(progress)")
                    self.progress.dismiss(animated: true)
                    self.presentOkAlert(title: "restorecomplete".localized(), message: "")
                }, fileOutputHandler: { unzipFile in
                    print("unzipFile: \(unzipFile)")
                })
            } catch {
                print("error")
            }
            
        } else {
            do {
                try FileManager.default.copyItem(at: selectedFileURL, to: sandboxFileURL)
                
                let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                let fileURL = documentDirectory.appendingPathComponent("archive.zip")
                
                self.progress.show(in: self.view, animated: true)
                try Zip.unzipFile(fileURL, destination: documentDirectory, overwrite: true, password: nil, progress: { progress in
                    print("progress: \(progress)")
                    self.progress.dismiss(animated: true)
                    self.presentOkAlert(title: "restorecomplete".localized(), message: "")
                }, fileOutputHandler: { unzipFile in
                    print("unzipFile: \(unzipFile)")
                })
            } catch {
                print("error")
            }
        }
    }
}

extension SettingViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}
