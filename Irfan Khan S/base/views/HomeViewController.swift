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
    @IBOutlet weak var viewAccounts: UIView!
    
    @IBOutlet weak var collectionData: UICollectionView!
    @IBOutlet weak var txtData: UILabel!
    @IBOutlet weak var viewMyData: UIView!
    
    @IBOutlet weak var collectionOthers: UICollectionView!
    @IBOutlet weak var txtOthers: UILabel!
    @IBOutlet weak var viewOthers: UIView!
    
    var accountsList = Array<HomeItems>()
    var dataList = Array<HomeItems>()
    var othersList = Array<HomeItems>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        initializeAccountsList()
        initializeDataList()
        initializeOthersList()
        
        
        setCollectionLayout(uiView: viewAccounts, collection: collectionAccounts,
                            collectionKey: "accounts_cell",
                            itemSize: accountsList.count)
        setCollectionLayout(uiView: viewMyData, collection: collectionData,
                            collectionKey: "data_cell",
                            itemSize: dataList.count)
        setCollectionLayout(uiView: viewOthers, collection: collectionOthers,
                            collectionKey: "others_cell",
                            itemSize: othersList.count)
        
    }
    
    private func setCollectionLayout(uiView: UIView!, collection: UICollectionView!,
                                     collectionKey: String, itemSize: Int) {
        let uiNib = UINib(nibName: "HomeCollectionViewCell", bundle: nil)
        collection?.contentInsetAdjustmentBehavior = .always
        collection.register(uiNib, forCellWithReuseIdentifier: collectionKey)
        
        let padding = 8
        let numOfCoumns = 5
        let collectionSize = 72
        let viewHeight = (itemSize * collectionSize / numOfCoumns) + 64
        
        
        
        // Setting the display of full views (Accounts, Data, Others)
        let screenSize: CGRect = UIScreen.main.bounds
        var yOffset = padding * 5
        if (uiView == viewMyData) {
            yOffset = Int(viewAccounts.frame.height) + (yOffset + 10)
        } else if (uiView == viewOthers) {
            yOffset = Int(viewAccounts.frame.height) + Int(viewMyData.frame.height) + (yOffset + 20)
        }
        uiView.frame = CGRect(x: padding, y: yOffset, width: Int(screenSize.width) - padding * 2, height: viewHeight)
        
        
        
        // Setting the number of items in a row in UICollectionView
        let layout = collection.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: collectionSize, height: collectionSize)
        collection.isScrollEnabled = false
        collection.frame = CGRect(x: 0, y: 48,
                                  width: collectionSize * numOfCoumns,
                                  height: collectionSize * itemSize / numOfCoumns)
        
        //        layout.sectionInset = UIEdgeInsets(top: 15, left: 0, bottom: 15, right: 0)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 2
        collection!.collectionViewLayout = layout
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        if (collectionView == self.collectionAccounts) {
            return accountsList.count
        } else if (collectionView == self.collectionData) {
            return dataList.count
        } else {
            return othersList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (collectionView == self.collectionAccounts) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "accounts_cell", for: indexPath) as! HomeCollectionViewCell
            cell.homeItemImage.image = accountsList[indexPath.row].image
            cell.homeItemName.text = accountsList[indexPath.row].name
            return cell
        } else if (collectionView == self.collectionData){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "data_cell", for: indexPath) as! HomeCollectionViewCell
            cell.homeItemImage.image = dataList[indexPath.row].image
            cell.homeItemName.text = dataList[indexPath.row].name
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "others_cell", for: indexPath) as! HomeCollectionViewCell
            cell.homeItemImage.image = othersList[indexPath.row].image
            cell.homeItemName.text = othersList[indexPath.row].name
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        
        if (collectionView == self.collectionAccounts) {
            var accountsVC : AccountsViewController? = nil
            if let tabArrController = tabBarController?.viewControllers {
                for vc in tabArrController {
                    if vc is AccountsViewController {
                        accountsVC = vc as? AccountsViewController
                    }
                }
            }
            accountsVC?.accountType = fetchAccountType(type: accountsList[indexPath.row].name)
            self.tabBarController?.selectedIndex = 2
        } else if (collectionView == self.collectionData) {

        }  else if (collectionView == self.collectionOthers) {

        }  else {

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
        dataList.append(HomeItems(idValue: 24, nameValue: NSLocalizedString("txt_daily_workouts", comment: ""), imageValue: UIImage(named: "ic_dialy_workouts")!))
        
    }
    
    private func initializeOthersList() {
        txtOthers.text = NSLocalizedString("txt_others", comment: "")
        othersList.removeAll()
        
        othersList.append(HomeItems(idValue: 25, nameValue: NSLocalizedString("txt_my_scanner", comment: ""), imageValue: UIImage(named: "ic_scanner")!))
        othersList.append(HomeItems(idValue: 26, nameValue: NSLocalizedString("txt_my_contacts", comment: ""), imageValue: UIImage(named: "ic_contacts")!))
        othersList.append(HomeItems(idValue: 27, nameValue: NSLocalizedString("txt_my_songs", comment: ""), imageValue: UIImage(named: "ic_songs")!))
        othersList.append(HomeItems(idValue: 28, nameValue: NSLocalizedString("txt_services", comment: ""), imageValue: UIImage(named: "ic_other_services")!))
        othersList.append(HomeItems(idValue: 29, nameValue: NSLocalizedString("txt_log_out", comment: ""), imageValue: UIImage(named: "ic_home_logout")!))
    }
    
    private func fetchAccountType(type: String) -> String {
        var accountType = ""
        if (type == NSLocalizedString("txt_sbi", comment: "")) {
            accountType = Constants.init().ACCOUNTS_SBI
        } else if (type == NSLocalizedString("txt_icici", comment: "")) {
            accountType = Constants.init().ACCOUNTS_ICICI
        } else if (type == NSLocalizedString("txt_icici_credit", comment: "")) {
            accountType = Constants.init().ACCOUNTS_ICICI_CREDIT
        } else if (type == NSLocalizedString("txt_zerodha", comment: "")) {
            accountType = Constants.init().ACCOUNTS_ZERODHA
        } else if (type == NSLocalizedString("txt_paytm", comment: "")) {
            accountType = Constants.init().ACCOUNTS_PAYTM
        } else if (type == NSLocalizedString("txt_amazon_pay", comment: "")) {
            accountType = Constants.init().ACCOUNTS_AMAZON_PAY
        } else if (type == NSLocalizedString("txt_phonepe", comment: "")) {
            accountType = Constants.init().ACCOUNTS_PHONEPE
        } else if (type == NSLocalizedString("txt_pf", comment: "")) {
            accountType = Constants.init().ACCOUNTS_PF
        } else if (type == NSLocalizedString("txt_fast_tag", comment: "")) {
            accountType = Constants.init().ACCOUNTS_FASTTAG
        } else {
            accountType = Constants.init().ACCOUNTS_HOME
        }
        return accountType
    }
}
