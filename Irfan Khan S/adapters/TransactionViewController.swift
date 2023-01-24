//
//  TransactionViewController.swift
//  Irfan Khan S
//
//  Created by Irfan Khan on 16/12/22.
//

import Foundation
import UIKit

protocol TransactionsHandler {
    func insertTransaction(transactionData: TransactionsData, addHome: Bool)
    func updateTransaction(transactionData: TransactionsData)
}


class TransactionViewController: UIViewController , UIPickerViewDelegate, UIPickerViewDataSource {
    
    static let identifier = "TransactionViewController"
    var delegate: TransactionsHandler?
    
    
    @IBOutlet weak var dialogView: UIView!
    @IBOutlet weak var edtAmount: UITextField!
    @IBOutlet weak var spnTransactionType: UITextField!
    @IBOutlet weak var edtReason: UITextField!
    @IBOutlet weak var onChangeTimestamp: UISwitch!
    @IBOutlet weak var onAddHome: UISwitch!
    @IBOutlet weak var onTransactionCancel: UILabel!

    
    var transactionTypeList = Array<String>()
    var updatedTransactionData: TransactionsData? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //adding an overlay to the view to give focus to the dialog box
        view.backgroundColor = UIColor.black.withAlphaComponent(0.50)
        setDialogViewParams()
        initTransaction()
        
    }
    
    private func setDialogViewParams() {
        
        //customizing the dialog box view
                
        dialogView.layer.cornerRadius = 6.0
        dialogView.layer.borderWidth = 1.2
        dialogView.layer.borderColor = UIColor(named: "dialogBoxGray")?.cgColor
        
        
        let pickerView = UIPickerView()
        pickerView.dataSource = self
        pickerView.delegate = self
        spnTransactionType.inputView = pickerView
    }
    
    private func initTransaction() {
        fetchTransactionType()

        let tap = UITapGestureRecognizer(target: self, action: #selector(onCancelTransactionTap))
        onTransactionCancel.isUserInteractionEnabled = true
        onTransactionCancel.addGestureRecognizer(tap)

        edtAmount.placeholder = NSLocalizedString("txt_enter_amount", comment: "")
        spnTransactionType.text = NSLocalizedString("transactions_type1", comment: "")
        edtReason.placeholder = NSLocalizedString("txt_enter_reason", comment: "")
        
        if (updatedTransactionData != nil) {
            var updatedAmount: Double = updatedTransactionData?.amount ?? 0.0
            if(updatedTransactionData?.transactionType == Constants.init().TXT_CASH_WITHDRAWAL) {
                updatedAmount = -1 * updatedAmount
            }
            edtAmount.text = String(updatedAmount)
            spnTransactionType.text = updatedTransactionData?.transactionType
            edtReason.text = updatedTransactionData?.reason
        }
    }
    
    @objc
    func onCancelTransactionTap(sender:UITapGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onTransactionAdd(_ sender: Any) {
        
        let amount = edtAmount.text ?? ""
        let amountValue = Double(amount) ?? 0.0
        let transactionType = spnTransactionType.text ?? ""
        let reason = edtReason.text ?? ""

        let validate = validateFields(amount: amountValue, transactionType: transactionType, reason: reason)
        
        if (validate) {
            let timestamp = Constants.init().fetchCurrentTimestamp(pattern: Constants.init().plainDateFormat())
            
            let id: Int = updatedTransactionData?.id ?? 0
            let transactionData = TransactionsData(idValue: id, amountValue: amountValue, transactionValue: transactionType, reasonValue: reason, timestampValue: timestamp, accountValue: "")
            
            if(updatedTransactionData == nil) {
                self.delegate?.insertTransaction(transactionData: transactionData, addHome: onAddHome.isOn)
            } else {
                self.delegate?.updateTransaction(transactionData: transactionData)
            }
            
            self.dismiss(animated: true, completion: nil)
        } else {
            self.showToast(message: NSLocalizedString("txt_incorrect_data", comment: ""), font: .systemFont(ofSize: 12.0))
        }
    }
    
    private func validateFields(amount: Double, transactionType: String, reason: String) -> Bool {
        if (amount == 0.0 || transactionType == "" || reason == "") {
            return false
        } else {
            return true
        }
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
     
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return transactionTypeList.count
    }
        
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return transactionTypeList[row]
    }
        
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let transactionType = transactionTypeList[row]
        print(transactionType)
        spnTransactionType.text = transactionType
    }
    
    
    private func fetchTransactionType() {
        transactionTypeList.removeAll()
        transactionTypeList.append(Constants.init().TXT_CASH_DEPOSIT)
        transactionTypeList.append(Constants.init().TXT_CASH_WITHDRAWAL)
        transactionTypeList.append(Constants.init().TXT_CASH_BACK)
    }
    
    //MARK:- functions for the viewController
    static func showPopup(parentVC: UIViewController, data: TransactionsData?) {
        
        //creating a reference for the dialogView controller
        if let popupViewController = UIStoryboard(name: "TransactionStoryboard", bundle: nil).instantiateViewController(withIdentifier: "TransactionViewController") as? TransactionViewController {
            popupViewController.modalPresentationStyle = .custom
            popupViewController.modalTransitionStyle = .crossDissolve
            
            
            //setting the delegate of the dialog box to the parent viewController
            popupViewController.delegate = parentVC as? TransactionsHandler
            popupViewController.updatedTransactionData = data
            
            //presenting the pop up viewController from the parent viewController
            parentVC.present(popupViewController, animated: true)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        updatedTransactionData = nil
    }
}
