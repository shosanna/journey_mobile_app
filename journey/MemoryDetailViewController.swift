//
//  MemoryDetailViewController.swift
//  journey
//
//  Created by Zuzana Dostálová on 28/10/14.
//  Copyright (c) 2014 zuzana.dostalova. All rights reserved.
//

import UIKit

class MemoryDetailViewController: UIViewController {
    
    @IBOutlet weak var memoryDetailDate: UILabel!
    @IBOutlet weak var memoryDetailText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        memoryDetailText.text = memory
        memoryDetailDate.text = "1.1.2014"
        // Do any additional setup after loading the view.
    }
    
    var memory: String?

}
