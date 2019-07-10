//
//  ViewController.swift
//  CoinApp
//
//  Created by ATAKAN on 3.07.2019.
//  Copyright © 2019 Xicy. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tblCoins: UITableView!
    @IBOutlet weak var lblPrice: UILabel!
    
    lazy var coins = NSArray()
    var gradients : [[UIColor]]!
    
    @IBOutlet weak var vwContainer: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.gradients = [Colors.firstrow,Colors.secondrow,Colors.thirdrow,Colors.fourthrow]
        
        tblCoins.separatorColor = UIColor.clear
        
        view.setGradientBackground(gradients: Colors.gradientBackground, start: CGPoint(x:0.5,y:0), end: CGPoint(x:0,y:1) )
        tblCoins.backgroundColor = UIColor.clear
    
        let priceText = NSMutableAttributedString(string: "103.463,59")
        priceText.addAttribute(.foregroundColor, value: UIColor.black, range: NSRange(location: 0, length: 7))
        priceText.addAttribute(.foregroundColor, value: UIColor.gray, range: NSRange(location: 7, length: 3))
        lblPrice.attributedText = priceText
        
        self.vwContainer.layer.shadowColor = UIColor(red: 216 / 255, green: 216 / 255, blue: 216 / 255, alpha: 1.0).cgColor
        self.vwContainer.layer.shadowOpacity = 1
        self.vwContainer.layer.shadowOffset = .zero
        self.vwContainer.layer.shadowRadius = 1
        
        Alamofire.request("http://webdev.test/coins").responseJSON { response in
            if let json = response.result.value as? NSArray{
                self.coins = json
                self.tblCoins.dataSource = self
                self.tblCoins.delegate = self
                self.tblCoins.reloadData()
                self.tblCoins.tableFooterView = UIView()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.coins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var currentCell : CoinTableViewCell!
        
        if let cell = tableView.cellForRow(at: indexPath) as? CoinTableViewCell{
            currentCell = cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "CoinTableViewCell", for: indexPath) as! CoinTableViewCell
            currentCell = cell
        }
        
        let cell = currentCell!
        
        cell.backgroundColor = UIColor.clear
        
        let coin = self.coins[indexPath.row] as! NSDictionary
        let current = coin.object(forKey: "current") as! NSDictionary
        
        cell.lblName.text = coin.object(forKey: "name") as? String
        let price = current.object(forKey: "price") as! String
        cell.lblPrice.text = "\(price) $"
        
        let img = coin.object(forKey: "img") as! String
        
        cell.ivCoin.contentMode = .scaleAspectFit
        cell.ivCoin.sd_setImage(with: URL(string: img))
        cell.configureCell(colors: self.gradients[indexPath.row % 4])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CoinDetailViewController") as! CoinDetailViewController
        vc.currentCoin = self.coins[indexPath.row] as? NSDictionary
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
