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
        
        // Do any additional setup after loading the view.
        
    }
    
    
    @IBAction func swipeAction(_ sender: UISwipeGestureRecognizer) {
        if swipeRecognizer.direction == .right {
            hero.modalAnimationType = .slide(direction: .right)
            hero.dismissViewController()
        }
    }
    
}
