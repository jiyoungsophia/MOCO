//
//  OnboardingViewController.swift
//  MOCO
//
//  Created by 지영 on 2021/11/30.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    static let identifier = "OnboardingViewController"
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var slides: [OnboardingSlide] = []
    var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
            
            if currentPage == slides.count - 1 {
                nextButton.setTitle("Get Started", for: .normal)
            } else {
                nextButton.setTitle("Next", for: .normal)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        slides = [
            OnboardingSlide(title: "on1title".localized(), description: "on1desc".localized(), image:UIImage(named: "onboarding2")!),
            OnboardingSlide(title: "on2title".localized(), description: "on2desc".localized(), image: UIImage(named: "onboarding3")!),
            OnboardingSlide(title: "on3title".localized(), description: "on3desc".localized(), image: UIImage(named: "onboarding1")!)
        ]
    }
    
    
    @IBAction func nextButtonClicked(_ sender: UIButton) {
        if currentPage == slides.count - 1 {
            dismiss(animated: true, completion: nil)
            let sb = UIStoryboard(name: "Budget", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: BudgetViewController.identifier) as! BudgetViewController
            UIApplication.shared.windows.first?.rootViewController = vc
            UIApplication.shared.windows.first?.makeKeyAndVisible()
            
        } else {
            currentPage += 1
            
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
}

extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCell.identifier, for: indexPath) as! OnboardingCell
        
        cell.setup(slides[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
    }
}
