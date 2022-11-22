//
//  HomeViewController.swift
//  Irfan Khan S
//
//  Created by Irfan Khan on 17/11/22.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDelegate,
                          UICollectionViewDataSource {
    
    @IBOutlet weak var collectionAccounts: UICollectionView!
    @IBOutlet weak var txtAccounts: UILabel!
    
    var accountsList = Array<HomeItems>()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        initializeAccountsList()
        
        
        
        let nibcell = UINib(nibName: "HomeCollectionViewCell", bundle: nil)
        collectionAccounts?.contentInsetAdjustmentBehavior = .always
        collectionAccounts.register(nibcell, forCellWithReuseIdentifier: "accounts_cell")
        
        
        let numOfCoumns = 5
        let width = (self.view.frame.size.width - CGFloat((numOfCoumns - 1) * 10)) / CGFloat(numOfCoumns)
        let layout = collectionAccounts.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: width)
        
        let collectionCell = 72
        collectionAccounts.frame = CGRect(x: 0, y: 48, width: collectionCell*5, height: collectionCell*2)

    }
    
    private func initializeAccountsList() {
        txtAccounts.text = NSLocalizedString("txt_my_accounts", comment: "")
        
        accountsList.removeAll()
        
        accountsList.append(HomeItems(idValue: 0, nameValue: NSLocalizedString("txt_sbi", comment: ""), imageValue: UIImage(named: "ic_home_sbi")!))
        accountsList.append(HomeItems(idValue: 1, nameValue: NSLocalizedString("txt_icici", comment: ""), imageValue: UIImage(named: "ic_home_icici")!))
        accountsList.append(HomeItems(idValue: 2, nameValue: NSLocalizedString("txt_icici_credit", comment: ""), imageValue: UIImage(named: "ic_home_credit_card")!))
        accountsList.append(HomeItems(idValue: 3, nameValue: NSLocalizedString("txt_zerodha", comment: ""), imageValue: UIImage(named: "ic_home_zerodha")!))
        accountsList.append(HomeItems(idValue: 4, nameValue: NSLocalizedString("txt_pf", comment: ""), imageValue: UIImage(named: "ic_home_pf")!))
        
        
        accountsList.append(HomeItems(idValue: 5, nameValue: NSLocalizedString("txt_paytm", comment: ""), imageValue: UIImage(named: "ic_home_paytm")!))
        accountsList.append(HomeItems(idValue: 6, nameValue: NSLocalizedString("txt_phonepe", comment: ""), imageValue: UIImage(named: "ic_home_phonepe")!))
        accountsList.append(HomeItems(idValue: 7, nameValue: NSLocalizedString("txt_amazon_pay", comment: ""), imageValue: UIImage(named: "ic_home_amazon_pay")!))
        accountsList.append(HomeItems(idValue: 8, nameValue: NSLocalizedString("txt_fast_tag", comment: ""), imageValue: UIImage(named: "ic_home_fast_tag")!))
        accountsList.append(HomeItems(idValue: 9, nameValue: NSLocalizedString("txt_home", comment: ""), imageValue: UIImage(named: "ic_home_accounts_home")!))
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return accountsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "accounts_cell", for: indexPath) as! HomeCollectionViewCell
        cell.homeItemImage.image = accountsList[indexPath.row].image
        cell.homeItemName.text = accountsList[indexPath.row].name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        let name = accountsList[indexPath.row].name
        print("Item selected at position " + indexPath.row.description + " is " + name)
    }

    
}
