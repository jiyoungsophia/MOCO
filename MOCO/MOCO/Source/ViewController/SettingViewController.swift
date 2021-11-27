//
//  SettingViewController.swift
//  MOCO
//
//  Created by 지영 on 2021/11/24.
//

import UIKit
import Hero

class SettingViewController: UIViewController {
    
    static let identifier = "SettingViewController"
    
    @IBOutlet var swipeRecognizer: UISwipeGestureRecognizer!
    override func viewDidLoad() {
        super.viewDidLoad()
        navConfigure()
        // Do any additional setup after loading the view.
        swipeRecognizer.direction = .left
        
    }
    
    func navConfigure() {
        navigationItem.title = "budget".localized()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "checkmark"), style: .plain, target: self, action: #selector(saveButtonClicked))
        
      
        navigationItem.rightBarButtonItem?.tintColor = .black
    }
    
    @objc func saveButtonClicked() {
        
    }
    
    @IBAction func swipeAction(_ sender: UISwipeGestureRecognizer) {
        if swipeRecognizer.direction == .left {
            hero.modalAnimationType = .slide(direction: .left)
            hero.dismissViewController()
        }
    }
    
}
