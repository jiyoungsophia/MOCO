//
//  MapViewController.swift
//  MOCO
//
//  Created by 지영 on 2021/11/18.
//

import UIKit
import NMapsMap
import CoreLocation

// TODO: 프로그레스바!!!

class MapViewController: UIViewController {
    
    static let identifier = "MapViewController"
    
    @IBOutlet weak var mapView: UIView!
    @IBOutlet weak var locationButton: UIView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        print(#function)
        collectionViewConfig()
        locationManager.delegate = self
    }

    
    func collectionViewConfig() {
        let nibName = UINib(nibName: ExpenseCell.identifier, bundle: nil)
        collectionView.register(nibName, forCellWithReuseIdentifier: ExpenseCell.identifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension MapViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExpenseCell.identifier, for: indexPath) as? ExpenseCell else {
            return UICollectionViewCell()
        }
        
        return cell
    }
}

extension MapViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing: CGFloat = 28
        let width = UIScreen.main.bounds.width - (spacing * 2)
        return CGSize(width: width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 28, bottom: 0, right: 28)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
}

extension MapViewController: CLLocationManagerDelegate {
    
}
