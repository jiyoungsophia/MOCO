//
//  ViewController.swift
//  MOCO
//
//  Created by 지영 on 2021/11/15.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        for family in UIFont.familyNames {
            print(family)
            
            for sub in UIFont.fontNames(forFamilyName: family) {
                print("======> \(sub)")
            }
        }
    }
    
    
}

