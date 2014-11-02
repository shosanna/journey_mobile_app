//
//  MemoryTableViewCell.swift
//  journey
//
//  Created by Zuzana Dostálová on 02/11/14.
//  Copyright (c) 2014 zuzana.dostalova. All rights reserved.
//

import UIKit

class MemoryTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet weak var MemoryText: UILabel!
}
