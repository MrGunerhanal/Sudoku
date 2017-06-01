//
//  OnboardingCellHello.swift
//  Example
//
//  Created by Steven Barnegren on 31/03/2017.
//  Copyright © 2017 Steve Barnegren. All rights reserved.
//

import UIKit

class OnboardingCellHello: UICollectionViewCell {
    
    // MARK: - Public
    
    func setTitle(_ text: String) {
        titleLabel.text = text
    }
    
        
    @IBOutlet weak private var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
    }
    
}
