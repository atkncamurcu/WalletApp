//
//  CoinTableViewCell.swift
//  CoinApp
//
//  Created by ATAKAN on 3.07.2019.
//  Copyright © 2019 Xicy. All rights reserved.
//

import UIKit

class CoinTableViewCell: UITableViewCell {

    @IBOutlet weak var ivCoin: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var ivBackground2: UIView!
    
    let gradientLayer = CAGradientLayer()
    
    func configureCell(colors: [UIColor]) {
        let colorSet = [colors[0],colors[1]]
        let location = [0.0, 1.0]
        ivBackground2.layer.cornerRadius=10
        ivBackground2.layer.masksToBounds = true
        ivBackground2.addGradient(with: gradientLayer, colorSet: colorSet, locations: location)
        ivBackground2.backgroundColor = .clear
    }
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: self.layer)
        gradientLayer.frame = self.contentView.bounds
    }
}
