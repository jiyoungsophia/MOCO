//
//  YearlyViewController.swift
//  MOCO
//
//  Created by 지영 on 2021/11/19.
//

import UIKit

// TODO: months 선언 위치
class YearlyViewController: UIViewController {
    
    static let identifier = "YearlyViewController"
    
    var months : [String] = []
    
    var calendar = Calendar.current
    let dateFormatter = DateFormatter()
    var components = DateComponents()
    
    var monthButtonActionHandler: ((String) -> (Void))?

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var hearderView: UIView!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        collectionViewConfig()
        makeMonthYear()
    }
    
    func configure() {
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        backView.layer.cornerRadius = 10
        collectionView.layer.cornerRadius = 10
        hearderView.backgroundColor = UIColor.mocoOrange
        hearderView.setTopCornerRound(cornerRadius: 10, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
        
        dateFormatter.dateFormat = "yyyy"
        components.year = calendar.component(.year, from: Date())
        
        months = calendar.shortMonthSymbols
    }
    
    func collectionViewConfig(){
        let nibName = UINib(nibName: MonthCell.identifier, bundle: nil)
        collectionView.register(nibName, forCellWithReuseIdentifier: MonthCell.identifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let layout = UICollectionViewFlowLayout()
        let width = collectionView.frame.width / 5
        let height = collectionView.frame.height / 4
        layout.itemSize = CGSize(width: width, height: height)
        collectionView.collectionViewLayout = layout
    }
    
    
    func makeMonthYear() {
        let monthOfYear = calendar.date(from: components)
        self.yearLabel.text = dateFormatter.string(from: monthOfYear!)
    }
    
    @IBAction func prevButtonClicked(_ sender: UIButton) {
        components.year = components.year! - 1
        makeMonthYear()
    }
    
    @IBAction func nextButtonClicked(_ sender: UIButton) {
        components.year = components.year! + 1
        makeMonthYear()
    }
    
    @IBAction func recognizeTap(_ sender: UITapGestureRecognizer) {
        hero.dismissViewController()
    }
    
    @objc func monthButtonClicked(selectButton: UIButton) {
        
        selectButton.setTitleColor(UIColor.mocoOrange, for: .normal)
        if let label = selectButton.titleLabel, let monthLabelText = label.text, let year = components.year {
 
            guard let userLanguage = Locale.current.languageCode else {return}
            var rawDate : String = ""
            
            // button setTitle
            if userLanguage == "ko" {
                rawDate = "\(year)년 \(monthLabelText)"
            } else {
                rawDate = "\(monthLabelText), \(year)"
            }
            monthButtonActionHandler?(rawDate)
            

            // realm filter
            if let date = DateFormatter.monthFormat.date(from: rawDate) {
                let realmDate = calendar.dateComponents(in: .current, from: date)
                
                guard let year = realmDate.year else {return}
                guard let month = realmDate.month else {return}
                   
                NotificationCenter.default.post(name: NSNotification.Name("dateNoti"), object: nil, userInfo: ["year": year,"month": month])
            }
            
        }
        hero.dismissViewController()
    }
}

extension YearlyViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return months.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MonthCell.identifier, for: indexPath) as? MonthCell else {
            return UICollectionViewCell()
        }
        
        cell.monthButton.setTitle(months[indexPath.item], for: .normal)
        cell.monthButton.addTarget(self, action: #selector(monthButtonClicked(selectButton:)), for: .touchUpInside)
        return cell
    }    
}
