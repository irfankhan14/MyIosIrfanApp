//
//  DashBoardViewController.swift
//  Irfan Khan S
//
//  Created by Irfan Khan on 23/01/23.
//

import UIKit

class DashBoardViewController: UIViewController , UICollectionViewDelegate,
                               UICollectionViewDataSource {
    
    @IBOutlet weak var txtAppname: UILabel!
    @IBOutlet weak var txtEmailAddress: UILabel!
    @IBOutlet weak var txtPhoneNumber: UILabel!
    
    @IBOutlet weak var txtDaily: UILabel!
    @IBOutlet weak var txtWeekly: UILabel!
    @IBOutlet weak var txtLowBalanceData: UILabel!
    
    @IBOutlet weak var txtDailyIncome: UILabel!
    @IBOutlet weak var txtDailyExpense: UILabel!
    @IBOutlet weak var txtWeeklyIncome: UILabel!
    @IBOutlet weak var txtWeeklyExpense: UILabel!
    @IBOutlet weak var dashBoardNewsCollection: UICollectionView!
    @IBOutlet weak var newsCardView: CustomCardView!
    
    var newsCategoryList = Array<String>()
    var selectedNewsDataList = Array<String>()
    var databaseManager: DatabaseManager? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        let uiNib = UINib(nibName: "DashBoardNewsCollectionViewCell", bundle: nil)
        dashBoardNewsCollection?.contentInsetAdjustmentBehavior = .always
        dashBoardNewsCollection.register(uiNib, forCellWithReuseIdentifier: "dashboard_news_cell")
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        databaseManager = DatabaseManager.getInstance()
        
        fetchMyAccountData()
        fetchBalanceData()
        initiliazeAccountWithCounters()
        fetchNewsData()
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return newsCategoryList.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dashboard_news_cell", for: indexPath) as! DashBoardNewsCollectionViewCell
        
        cell.txtNewsCategory.text = newsCategoryList[indexPath.row]
        
        if(fetchSelectedNews(selectedNews: newsCategoryList[indexPath.row])) {
            cell.imgDashBoardNews.image = UIImage(named: "ic_rectangle_fill")
            cell.txtNewsCategory.textColor = UIColor.white
            if(newsCategoryList[indexPath.row] == Constants().NEWS_KEY_SEARCH) {
                cell.txtNewsCategory.text = selectedNewsDataList[1]
            }
        } else {
            if(fetchSelectedCategory(selectedNews: newsCategoryList[indexPath.row])) {
                cell.imgDashBoardNews.image = UIImage(named: "ic_rectangle_fill")
                cell.txtNewsCategory.textColor = UIColor.white
            } else {
                cell.imgDashBoardNews.image = UIImage(named: "ic_rectangle_border")
                cell.txtNewsCategory.textColor = UIColor.black
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        
        if(indexPath.row == 0) {
            updateNewsData(title: Constants().NEWS_HEADLINES, description: Constants().NEWS_KEY_HEADLINES)
        } else if(indexPath.row == 1) {
            showAlertDialogForNewsSearch()
        } else {
            updateNewsData(title: Constants().NEWS_CATEGORY, description: newsCategoryList[indexPath.row])
        }
    }
    
    private func showAlertDialogForNewsSearch() {
        let alert = UIAlertController(
            title: NSLocalizedString("title_news", comment: ""),
            message: NSLocalizedString("txt_dialog_keyword", comment: ""),
            preferredStyle: .alert)
        
        alert.addTextField { (textField:UITextField) in
            textField.placeholder = NSLocalizedString("title_news", comment: "")
        }
        alert.addAction(UIAlertAction(
            title: NSLocalizedString("txt_submit", comment: ""),
            style: .default,
            handler: { (action:UIAlertAction) in
                let description = alert.textFields![0] as UITextField
                self.updateNewsData(title: Constants().NEWS_SEARCH, description: description.text ?? "" )
            }
        ))
        alert.addAction(UIAlertAction(
            title: NSLocalizedString("txt_cancel", comment: ""),
            style: .cancel,
            handler: nil)
        )
        self.present(alert, animated: true, completion: nil)
    }
    
    private func updateNewsData(title: String, description: String) {
        let newsData = title + "," + description + "," + selectedNewsDataList[2] + "," + selectedNewsDataList[3] + "," + selectedNewsDataList[4]
        let query = "Update " + Constants().TABLE_SET_DEFAULTS + " set " + Constants().SET_DEFAULTS_COLUMN_DESCRIPTION + " = '" + newsData + "'" + " where " + Constants().SET_DEFAULTS_COLUMN_TITLE + " = '" + Constants().NEWS_DATA + "'"
        
        if (databaseManager!.handleInsertDeleteUpdate(query: query)) {
            showToast(message: NSLocalizedString("txt_news_updated", comment: ""), font: .systemFont(ofSize: 12.0))
            fetchNewsData()
            dashBoardNewsCollection.reloadData()
        }
    }
    
    private func fetchSelectedNews(selectedNews: String) -> Bool {
        if(selectedNewsDataList.isEmpty) {
            return false
        } else {
            let newsTitle = selectedNewsDataList[0]
            let selectedNewsValue = selectedNews.replacingOccurrences(of: " ", with: "")
            if(newsTitle.containsIgnoringCase(selectedNewsValue)) {
                return true
            } else {
                return false
            }
        }
    }
    
    private func fetchSelectedCategory(selectedNews: String) -> Bool {
        if(selectedNewsDataList.isEmpty) {
            return false
        } else {
            let newsTitle = selectedNewsDataList[1]
            let selectedNewsValue = selectedNews.replacingOccurrences(of: " ", with: "")
            if(newsTitle.containsIgnoringCase(selectedNewsValue)) {
                return true
            } else {
                return false
            }
        }
    }
    
    private func fetchMyAccountData() {
        txtAppname.text = NSLocalizedString("app_name", comment: "")
        txtEmailAddress.text = "irfan@gmail.com\nkhan@gmail.com"
        txtPhoneNumber.text = "+91 9876543210"
    }
    
    private func fetchBalanceData() {
        txtDaily.text = NSLocalizedString("txt_today", comment: "")
        txtWeekly.text = NSLocalizedString("txt_weekly", comment: "")
        txtLowBalanceData.text = NSLocalizedString("txt_balance_data", comment: "")
    }
    
    private func initiliazeAccountWithCounters() {
        let dateFormat = Constants().TXT_DATE_FORMAT.replacingOccurrences(of: "-", with: "")
        let startTime = Constants().TXT_START_TIME
        let endTime = Constants().TXT_END_TIME
        
        let todayStartTime = UtilityDates().fetchCurrentTimestamp(pattern: dateFormat) + startTime
        let todayEndTime = UtilityDates().fetchCurrentTimestamp(pattern: dateFormat) + endTime
        
        let weeklyStartTime = UtilityDates().getFirstDayOfWeek(pattern: dateFormat) + startTime
        let weeklyEndTime = UtilityDates().getLastDayOfWeek(pattern: dateFormat) + endTime
        
        let dailyQuery = "Select sum(" + Constants().ACCOUNT_TRANSACTIONS_COLUMN_AMOUNT +
        ") from " + Constants().TABLE_ACCOUNT_TRANSACTIONS + " where " +
        Constants().ACCOUNT_TRANSACTIONS_COLUMN_TIMESTAMP + ">='" + todayStartTime + "' and " + Constants().ACCOUNT_TRANSACTIONS_COLUMN_TIMESTAMP + "<='" + todayEndTime + "' and " + Constants().ACCOUNT_TRANSACTIONS_COLUMN_TRANSACTION_TYPE
        
        let weeklyQuery = "Select sum(" + Constants().ACCOUNT_TRANSACTIONS_COLUMN_AMOUNT +
        ") from " + Constants().TABLE_ACCOUNT_TRANSACTIONS + " where " +
        Constants().ACCOUNT_TRANSACTIONS_COLUMN_TIMESTAMP + ">='" + weeklyStartTime + "' and " + Constants().ACCOUNT_TRANSACTIONS_COLUMN_TIMESTAMP + "<='" + weeklyEndTime + "' and " + Constants().ACCOUNT_TRANSACTIONS_COLUMN_TRANSACTION_TYPE
        
        let dailyIncomeQuery = dailyQuery + "!='" + Constants().TXT_CASH_WITHDRAWAL + "'"
        let dailyExpenseQuery = dailyQuery + "='" + Constants().TXT_CASH_WITHDRAWAL + "'"
        
        let weeklyIncomeQuery = weeklyQuery + "!='" + Constants().TXT_CASH_WITHDRAWAL + "'"
        let weeklyExpenseQuery = weeklyQuery + "='" + Constants().TXT_CASH_WITHDRAWAL + "'"
        
        let dailyIncome = fetchRoundedAmountValues(amount: databaseManager!.fetchData(query: dailyIncomeQuery))
        let dailyExpense = fetchRoundedAmountValues(amount: databaseManager!.fetchData(query: dailyExpenseQuery))
        let weeklyIncome = fetchRoundedAmountValues(amount: databaseManager!.fetchData(query: weeklyIncomeQuery))
        let weeklyExpense = fetchRoundedAmountValues(amount: databaseManager!.fetchData(query: weeklyExpenseQuery))
        
        incrementLabel(label: txtDailyIncome, endValue: dailyIncome)
        incrementLabel(label: txtDailyExpense, endValue: dailyExpense)
        incrementLabel(label: txtWeeklyIncome, endValue: weeklyIncome)
        incrementLabel(label: txtWeeklyExpense, endValue: weeklyExpense)
    }
    
    private func fetchNewsData() {
        
        let selectQuery = "Select " + Constants().SET_DEFAULTS_COLUMN_DESCRIPTION + " from " + Constants().TABLE_SET_DEFAULTS + " where " + Constants().SET_DEFAULTS_COLUMN_TITLE + " = '"
        let newsDataQuery = selectQuery + Constants().NEWS_DATA + "'"
        let newsCategoryQuery = selectQuery + Constants().NEWS_CATEGORY + "'"
        
        let newsData = databaseManager!.fetchData(query: newsDataQuery)
        let newsCategory = databaseManager!.fetchData(query: newsCategoryQuery)

        let newsDataArray = newsData.components(separatedBy: ",")
        selectedNewsDataList.removeAll()
        for data in newsDataArray {
            selectedNewsDataList.append(data)
        }
        
        let newsCategoryArray = newsCategory.components(separatedBy: ", ")
        newsCategoryList.removeAll()
        newsCategoryList.append(Constants().NEWS_KEY_HEADLINES)
        newsCategoryList.append(Constants().NEWS_KEY_SEARCH)
        for data in newsCategoryArray {
            newsCategoryList.append(data.capitalizingFirstLetter())
        }
        
        dashBoardNewsCollection.reloadData()
        
        let numberOfColumns: CGFloat = 3
        if let flowLayout = dashBoardNewsCollection?.collectionViewLayout as? UICollectionViewFlowLayout {
            let horizontalSpacing = flowLayout.scrollDirection == .vertical ? flowLayout.minimumInteritemSpacing : flowLayout.minimumLineSpacing
            let cellWidth = (dashBoardNewsCollection.frame.width - max(0, numberOfColumns - 1)*horizontalSpacing)/numberOfColumns
            flowLayout.itemSize = CGSize(width: cellWidth, height: 44)
            flowLayout.minimumLineSpacing = 2
        }
    }
    
    
    
    @IBAction func onExemptReasons(_ sender: Any) {
        
    }
    
    private func fetchRoundedAmountValues(amount: String) -> Int {
        let abcd: Double = Double(amount) ?? 0.0
        var result = Int(abcd.rounded())
        if (result < 0) {
            result *= -1
        }
        return result
    }
    
    private func incrementLabel(label: UILabel, endValue: Int) {
        if(endValue == 0) {
            label.text = "\(endValue)"
        } else {
            let duration: Double = 1.0 //seconds
            DispatchQueue.global().async {
                for i in 0 ..< (endValue + 1) {
                    let sleepTime = UInt32(duration/Double(endValue) * 1000000.0)
                    usleep(sleepTime)
                    DispatchQueue.main.async {
                        label.text = "\(i)"
                    }
                }
            }
        }
    }
}
