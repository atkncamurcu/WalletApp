//
//  CoinDetailViewController.swift
//  CoinApp
//
//  Created by ATAKAN on 3.07.2019.
//  Copyright © 2019 Xicy. All rights reserved.
//

import UIKit

class CoinDetailViewController: UIViewController {

    
    var currentCoin : NSDictionary!
    
    
    @IBOutlet weak var lblCurrentCoin: UILabel!
    @IBOutlet weak var ivCurrentCoin: UIImageView!
    @IBOutlet weak var lblCurrentCoinId: UILabel!
    @IBOutlet weak var lblCurrentCoinPrice: UILabel!
    @IBOutlet weak var lblCurrentCreatedDate: UILabel!
    @IBOutlet weak var lblCoinID: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gradient:[UIColor] =  Colors.gradientBackground
        self.view.setGradientBackground(gradients:gradient, start: CGPoint(x:0.5,y: 0), end: CGPoint(x:0,y:1))
        
        let details = currentCoin.object(forKey: "current") as! NSDictionary
        
        lblCurrentCoin.text = currentCoin.object(forKey: "name") as? String
    
        let coin_id = String(details.object(forKey: "id") as! Int)
        
        
        lblCoinID.text = "ID: \(coin_id)"
        
        let current_price = details.object(forKey: "price") as! String
        
        lblCurrentCoinPrice.text = "Price : \(current_price) $"
        
        let created_date = details.object(forKey: "created_at") as! String
        
        lblCurrentCreatedDate.text = "Created Date : \(created_date)"
        
        let current_img = currentCoin.object(forKey: "img") as! String
        
        //ivCurrentCoin.contentMode = UIView.ContentMode.scaleAspectFit
        ivCurrentCoin.sd_setImage(with: URL(string: current_img))
        
        
        
    }

}
