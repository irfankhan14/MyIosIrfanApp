//
//  AccountTableViewCell.swift
//  Irfan Khan S
//
//  Created by Irfan Khan on 08/12/22.
//

import UIKit

class AccountTableViewCell: UITableViewCell {

    @IBOutlet weak var viewAccounts: UIView!
    @IBOutlet weak var imgAccountType: UIImageView!
    @IBOutlet weak var txtTransactionType: UILabel!
    @IBOutlet weak var txtReason: UILabel!
    @IBOutlet weak var txtTimestamp: UILabel!
    @IBOutlet weak var txtAmount: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
