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
    
    @IBOutlet weak var txtData: UILabel!
    @IBOutlet weak var collectionData: UICollectionView!
    
    var accountsList = Array<HomeItems>()
    var dataList = Array<HomeItems>()
    var othersList = Array<HomeItems>()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        initializeAccountsList()
        initializeDataList()
        initializeOthersList()
        
        
        setCollectionLayout(collection: collectionAccounts, collectionKey: "accounts_cell", itemSize: accountsList.count)
        setCollectionLayout(collection: collectionData, collectionKey: "data_cell",
                            itemSize: dataList.count)

    }
    
    private func setCollectionLayout(collection: UICollectionView!,
                                     collectionKey: String, itemSize: Int) {
        let uiNib = UINib(nibName: "HomeCollectionViewCell", bundle: nil)
        collection?.contentInsetAdjustmentBehavior = .always
        collection.register(uiNib, forCellWithReuseIdentifier: collectionKey)
        
        let numOfCoumns = 5
        let collectionSize = 72
        
        let width = (self.view.frame.size.width - CGFloat((numOfCoumns - 1) * 10)) / CGFloat(numOfCoumns)
        let layout = collection.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: width)
        
        
        collection.frame = CGRect(x: 0, y: 48,
                                  width: collectionSize * numOfCoumns,
                                  height: collectionSize * itemSize / numOfCoumns)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        if (collectionView == self.collectionAccounts) {
            return accountsList.count
        } else {
            return dataList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (collectionView == self.collectionAccounts) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "accounts_cell", for: indexPath) as! HomeCollectionViewCell
            cell.homeItemImage.image = accountsList[indexPath.row].image
            cell.homeItemName.text = accountsList[indexPath.row].name
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "data_cell", for: indexPath) as! HomeCollectionViewCell
            cell.homeItemImage.image = dataList[indexPath.row].image
            cell.homeItemName.text = dataList[indexPath.row].name
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        
        if (collectionView == self.collectionAccounts) {
            let name = accountsList[indexPath.row].name
            print("Item selected at position " + indexPath.row.description + " is " + name)
        } else {
            let name = dataList[indexPath.row].name
            print("Item selected at position " + indexPath.row.description + " is " + name)
        }
        
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
    
    private func initializeDataList() {
        txtData.text = NSLocalizedString("txt_my_data", comment: "")
        
        dataList.removeAll()
        
        dataList.append(HomeItems(idValue: 10, nameValue: NSLocalizedString("txt_my_social_media", comment: ""), imageValue: UIImage(named: "ic_home_social_media")!))
        dataList.append(HomeItems(idValue: 11, nameValue: NSLocalizedString("txt_my_education", comment: ""), imageValue: UIImage(named: "ic_home_education")!))
        dataList.append(HomeItems(idValue: 12, nameValue: NSLocalizedString("txt_my_interview", comment: ""), imageValue: UIImage(named: "ic_home_interview_qa")!))
        dataList.append(HomeItems(idValue: 13, nameValue: NSLocalizedString("txt_my_compiler", comment: ""), imageValue: UIImage(named: "ic_compiler")!))
        dataList.append(HomeItems(idValue: 14, nameValue: NSLocalizedString("txt_app_usage", comment: ""), imageValue: UIImage(named: "ic_app_usage")!))
        
        dataList.append(HomeItems(idValue: 15, nameValue: NSLocalizedString("txt_personal_defaults", comment: ""), imageValue: UIImage(named: "ic_home_security")!))
        dataList.append(HomeItems(idValue: 16, nameValue: NSLocalizedString("txt_my_notes", comment: ""), imageValue: UIImage(named: "ic_home_notes")!))
        dataList.append(HomeItems(idValue: 17, nameValue: NSLocalizedString("txt_send_resume", comment: ""), imageValue: UIImage(named: "ic_home_send_resume")!))
        dataList.append(HomeItems(idValue: 18, nameValue: NSLocalizedString("txt_view_resume", comment: ""), imageValue: UIImage(named: "ic_home_view_resume")!))
        dataList.append(HomeItems(idValue: 19, nameValue: NSLocalizedString("txt_wireless_media", comment: ""), imageValue: UIImage(named: "ic_wireless_media")!))
        
        
        dataList.append(HomeItems(idValue: 20, nameValue: NSLocalizedString("txt_my_sms", comment: ""), imageValue: UIImage(named: "ic_home_sms")!))
        dataList.append(HomeItems(idValue: 21, nameValue: NSLocalizedString("txt_payment_reminders", comment: ""), imageValue: UIImage(named: "ic_payment_reminders")!))
        dataList.append(HomeItems(idValue: 22, nameValue: NSLocalizedString("txt_my_education", comment: ""), imageValue: UIImage(named: "ic_home_education")!))
        dataList.append(HomeItems(idValue: 23, nameValue: NSLocalizedString("txt_app_usage", comment: ""), imageValue: UIImage(named: "ic_app_usage")!))
        dataList.append(HomeItems(idValue: 24, nameValue: NSLocalizedString("title_daily_workouts", comment: ""), imageValue: UIImage(named: "ic_dialy_workouts")!))
        
    }
    
    private func initializeOthersList() {
        
    }
}
