//
//  MemoriesViewController.swift
//  journey
//
//  Created by Zuzana Dostálová on 27/10/14.
//  Copyright (c) 2014 zuzana.dostalova. All rights reserved.
//

import UIKit

class MemoriesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        MemoryText.hidden = true;
        PlaceField.hidden = true;
        PlaceLabel.hidden = true;
        DateField.hidden = true;
        DateLabel.hidden = true;
        SubmitButton.hidden = true;
        

        // Do any additional setup after loading the view.
    }


    @IBAction func AddMemory(sender: UIButton) {
        MemoryText.hidden = false;
        PlaceField.hidden = false;
        PlaceLabel.hidden = false;
        DateField.hidden = false;
        DateLabel.hidden = false;
        SubmitButton.hidden = false;
    }
    
    @IBOutlet weak var MemoryText: UITextView!
    @IBOutlet weak var PlaceField: UITextField!
    @IBOutlet weak var PlaceLabel: UILabel!
    @IBOutlet weak var DateField: UITextField!
    @IBOutlet weak var DateLabel: UILabel!
    @IBOutlet weak var SubmitButton: UIButton!


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
