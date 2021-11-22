//
//  BudgetViewController.swift
//  MOCO
//
//  Created by 지영 on 2021/11/18.
//

import UIKit
import Hero

enum ViewStatus {
    case income
    case expense
}

class BudgetViewController: UIViewController {

    @IBOutlet weak var incomeView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var floationgButton: UIButton!
    @IBOutlet weak var monthTitleButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        swipeGesture()
        configuration()
        floationgButton.layer.shadowColor = UIColor.black.cgColor
        floationgButton.layer.shadowOffset = .zero
        floationgButton.layer.shadowOpacity = 0.2
        
        let localizedDate = DateFormatter.localizedString(from: Date(), dateStyle: .medium, timeStyle: .none)
        print(localizedDate)
    }
    
    func configuration() {
        incomeView.setViewConfig(backgroundColor: UIColor.mocoBlue)
        
        let nibName = UINib(nibName: ExpenseCell.identifier, bundle: nil)
        collectionView.register(nibName, forCellWithReuseIdentifier: ExpenseCell.identifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        monthTitleButton.semanticContentAttribute = .forceRightToLeft
        monthTitleButton.setTitle(DateFormatter.monthFormat.string(from: Date()), for: .normal)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(incomeTapGesture))
        incomeView.addGestureRecognizer(tap)
    }
    
    @objc func incomeTapGesture() {
        let sb = UIStoryboard(name: "Write", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: IncomeViewController.identifier) as! IncomeViewController

        let nav = UINavigationController(rootViewController: vc)
        present(nav, animated: true, completion: nil)
    }
    
    func swipeGesture() {
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            if swipeGesture.direction == .left {
                let sb = UIStoryboard(name: "Map", bundle: nil)
                let vc = sb.instantiateViewController(withIdentifier: MapViewController.identifier) as! MapViewController
                vc.modalPresentationStyle = .fullScreen
                vc.hero.modalAnimationType = .slide(direction: .left)
                present(vc, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func yearlyButtonClicked(_ sender: UIButton) {
        let sb = UIStoryboard(name: "Yearly", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: YearlyViewController.identifier) as! YearlyViewController
        
        vc.monthButtonActionHandler = { selectedMonth in
        self.monthTitleButton.setTitle(selectedMonth, for: .normal)
        }
        
        vc.hero.modalAnimationType = .fade
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func floatingButtonClicked(_ sender: UIButton) {
        let sb = UIStoryboard(name: "Write", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: ExpenseViewController.identifier) as! ExpenseViewController

        let nav = UINavigationController(rootViewController: vc)
        present(nav, animated: true, completion: nil)
    }
}

extension BudgetViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExpenseCell.identifier, for: indexPath) as? ExpenseCell else {
            return UICollectionViewCell()
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Write", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: ExpenseViewController.identifier) as! ExpenseViewController

        let nav = UINavigationController(rootViewController: vc)
        present(nav, animated: true, completion: nil)
    }
}

extension BudgetViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing: CGFloat = 28
        let width = UIScreen.main.bounds.width - (spacing * 2)
        return CGSize(width: width, height: 100)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
}

