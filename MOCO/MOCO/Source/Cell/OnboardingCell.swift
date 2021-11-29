//
//  OnboardingCell.swift
//  MOCO
//
//  Created by 지영 on 2021/11/30.
//

import UIKit

class OnboardingCell: UICollectionViewCell {
    
    static let identifier = "OnboardingCell"
    
    @IBOutlet weak var slideImageView: UIImageView!
    @IBOutlet weak var slideTitleLabel: UILabel!
    @IBOutlet weak var slideDescriptionLabel: UILabel!
    
    func setup(_ slide: OnboardingSlide) {
        slideImageView.image = slide.image
        slideTitleLabel.text = slide.title
        slideDescriptionLabel.text = slide.description
        
    }
}
