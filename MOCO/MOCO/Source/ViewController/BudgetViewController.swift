//
//  BudgetViewController.swift
//  MOCO
//
//  Created by 지영 on 2021/11/18.
//

import UIKit
import Hero
import RealmSwift


class BudgetViewController: UIViewController {
    
    @IBOutlet weak var incomeView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var floationgButton: UIButton!
    @IBOutlet weak var monthTitleButton: UIButton!
    @IBOutlet weak var ddayLabel: UILabel!
    @IBOutlet weak var incomeLabel: UILabel!
    @IBOutlet weak var percentLabel: UILabel!
    @IBOutlet weak var registerLabel: UILabel!
    @IBOutlet weak var alertImageView: UIImageView!
    
    @IBOutlet weak var mapViewButton: UIButton!
    @IBOutlet weak var mapContainerView: UIView!
    
    var placeData: [Place] = []
    var incomeData: [Income] = []

    var dateList: [Int] = []
    
    var expenseData: [Expense] = [] {
        didSet {
            print("didSet")
            self.collectionView.reloadData()
        }
    }

    var isOffline: Bool = false
    var placeId: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)

        swipeGesture()
        configure()
        //TODO: 날짜 조회
        dateList = InputManager.shared.dateToYearMonth(date: Date())
        // isFirstRun 에 추가
//        RealmManager.shared.saveOnline()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        print(#function)
        
        loadIncome()
        loadExpense()
        configureIncomeView()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
    }
    
    func loadIncome() {
        incomeData = RealmManager.shared.loadIncome(year: dateList[0], month: dateList[1])
        
    }
    
    func loadExpense() {
        expenseData = RealmManager.shared.loadExpense(year: dateList[0], month: dateList[1])
    }

    func configureIncomeView() {
        if incomeData.isEmpty {
            registerLabel.isHidden = false
        } else {
            registerLabel.isHidden = true
            
            let totalIncome = incomeData[0].amount
            let totalExpense = expenseData.map { $0.amount }.reduce(0) { $0 + $1 }
            let result = totalIncome - totalExpense
            var resultText = ""
            if result > 0 {
                alertImageView.isHidden = true
                resultText = "+\(result.formatWithSeparator)"
            } else {
                alertImageView.isHidden = false
                resultText = result.formatWithSeparator
            }
            incomeLabel.text = resultText
            
            // percentage
            let percent = Int(( Double(totalExpense) / Double(totalIncome) ) * 100)
            percentLabel.text = "\(100 - percent)%"
            print(percent)
        }
    }
    
    func configure() {
        incomeView.setViewShadow(backgroundColor: UIColor.mocoBlue)
        
        let nibName = UINib(nibName: ExpenseCell.identifier, bundle: nil)
        collectionView.register(nibName, forCellWithReuseIdentifier: ExpenseCell.identifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        monthTitleButton.semanticContentAttribute = .forceRightToLeft
        monthTitleButton.setTitle(DateFormatter.monthFormat.string(from: Date()), for: .normal)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(incomeTapGesture))
        incomeView.addGestureRecognizer(tap)
        
        floationgButton.layer.shadowColor = UIColor.black.cgColor
        floationgButton.layer.shadowOffset = .zero
        floationgButton.layer.shadowOpacity = 0.2
        
        mapContainerView.isHidden = true
        
        registerLabel.text = "registerbudget".localized()
        registerLabel.backgroundColor = UIColor.mocoBlue
        registerLabel.isHidden = true
        
        ddayLabel.text = "🕰  D - \(InputManager.shared.calculateDday())"
        
        alertImageView.isHidden = true
    }
    
    func swipeGesture() {
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeLeft.direction = .right
        self.view.addGestureRecognizer(swipeLeft)
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            if swipeGesture.direction == .right {
                let sb = UIStoryboard(name: "Setting", bundle: nil)
                let vc = sb.instantiateViewController(withIdentifier: SettingViewController.identifier) as! SettingViewController
                vc.modalPresentationStyle = .fullScreen
                vc.hero.modalAnimationType = .slide(direction: .right)
                present(vc, animated: true, completion: nil)
            }
        }
    }
    
    @objc func incomeTapGesture() {
        let sb = UIStoryboard(name: "Write", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: IncomeViewController.identifier) as! IncomeViewController
        
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true, completion: nil)
    }
    
    @IBAction func showMapView(_ sender: UIButton) {
        if mapContainerView.isHidden == true {
            mapViewButton.setImage(UIImage(systemName: "map.fill"), for: .normal)
            mapContainerView.isHidden = false
        } else {
            mapViewButton.setImage(UIImage(systemName: "map"), for: .normal)
            mapContainerView.isHidden = true
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
    
    // 지출 새로 입력시 삭제버튼 hidden
    @IBAction func floatingButtonClicked(_ sender: UIButton) {
        let sb = UIStoryboard(name: "Write", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: ExpenseViewController.identifier) as! ExpenseViewController
        let nav = UINavigationController(rootViewController: vc)
        
        vc.buttonStatus = true
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true, completion: nil)
    }
}

extension BudgetViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return expenseData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExpenseCell.identifier, for: indexPath) as? ExpenseCell else {
            return UICollectionViewCell()
        }
        let item = expenseData[indexPath.item]
        placeData = RealmManager.shared.loadPlace(id: item.placeId ?? 0)
        cell.configureCell(item: item, place: placeData[0])
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Write", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: ExpenseViewController.identifier) as! ExpenseViewController
        vc.buttonStatus = false
        vc.expenseData = expenseData[indexPath.item]
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true, completion: nil)
    }
    
}

extension BudgetViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing: CGFloat = 28
        let width = UIScreen.main.bounds.width - (spacing * 2)
        return CGSize(width: width, height: 90)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
}

