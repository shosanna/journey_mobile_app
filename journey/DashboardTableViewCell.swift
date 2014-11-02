//
//  DashboardTableViewCell.swift
//  journey
//
//  Created by Zuzana Dostálová on 31/10/14.
//  Copyright (c) 2014 zuzana.dostalova. All rights reserved.
//

import UIKit

class DashboardTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet weak var DashboardDate: UILabel!
    
    @IBOutlet weak var DashboardImage: UIImageView!
    
    @IBOutlet weak var DashboardText: UILabel!
    
    @IBOutlet weak var DashboardTitle: UILabel!
}
