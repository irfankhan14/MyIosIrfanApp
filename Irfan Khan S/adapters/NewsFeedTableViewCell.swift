//
//  NewsFeedTableViewCell.swift
//  Irfan Khan S
//
//  Created by Irfan Khan on 31/01/23.
//

import UIKit

class NewsFeedTableViewCell: UITableViewCell {

    @IBOutlet weak var txtNewsTitle: UILabel!
    @IBOutlet weak var txtAuthor: UILabel!
    @IBOutlet weak var txtSource: UILabel!
    @IBOutlet weak var txtTimeStamp: UILabel!
    
    @IBOutlet weak var imgNewsArticle: UIImageView!
    @IBOutlet weak var imgShareNews: UIImageView!
    @IBOutlet weak var imgMoreNews: UIImageView!
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
