//
//  TableViewCell.swift
//  HallMorgan_CE02-2
//
//  Created by Morgan Hall on 11/29/21.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var responsibilityLabel: UILabel!
    @IBOutlet weak var listedResponsibilities: UILabel!
    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
