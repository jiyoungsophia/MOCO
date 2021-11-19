//
//  MapViewController.swift
//  MOCO
//
//  Created by 지영 on 2021/11/18.
//

import UIKit
import Hero

class MapViewController: UIViewController {
    
    static let identifier = "MapViewController"
    
    @IBOutlet var swipeRecognizer: UISwipeGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func swipeAction(_ sender: UISwipeGestureRecognizer) {
        if swipeRecognizer.direction == .right {
            hero.modalAnimationType = .slide(direction: .right)
            hero.dismissViewController()
        }
    }
}
