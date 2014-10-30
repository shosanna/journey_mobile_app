//
//  MemoriesViewController.swift
//  journey
//
//  Created by Zuzana Dostálová on 27/10/14.
//  Copyright (c) 2014 zuzana.dostalova. All rights reserved.
//

import UIKit

class MemoriesViewController: UIViewController, UIScrollViewDelegate {

        override func viewDidLoad() {
            super.viewDidLoad()
            ScrollView.scrollEnabled = true;
            ScrollView.contentSize =  CGSize(width: 640.0, height: 640.0)
            ScrollView.addSubview(FormView)
            ScrollView.addSubview(MemoriesView)
            
            var old = FormView.frame
            FormView.frame = CGRectMake(old.origin.x, old.origin.y, old.width, 0);
            FormView.alpha = 0
            
            MemoryText.layer.borderWidth = 1;
            MemoryText.layer.borderColor = DateField.layer.borderColor
            MemoryText.layer.cornerRadius = 5;

    }


    @IBAction func AddMemory(sender: UIButton) {
        UIView.animateWithDuration(0.5, animations: {
            if (self.FormView.alpha == 0) {
                self.FormView.alpha = 1
            } else {
                self.FormView.alpha = 0
            }

        })

    }
    
    @IBAction func memorySubmit(sender: UIButton) {
        if (PlaceField.hasText() && DateField.hasText() && MemoryText.hasText()) {
            
            infoLabel.hidden = true;
            
            let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
            let vc : UIViewController = mainStoryboard.instantiateViewControllerWithIdentifier("loginVC") as UIViewController
            navigationController?.pushViewController(vc, animated: true)
            
        } else {
            infoLabel.text = "All fields are required!"
            infoLabel.hidden = false;
        }
    }
    
    @IBOutlet weak var ScrollView: UIScrollView!
    @IBOutlet weak var FormView: UIView!
    @IBOutlet weak var MemoriesView: UIView!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var MemoryText: UITextView!
    @IBOutlet weak var PlaceField: UITextField!
    @IBOutlet weak var PlaceLabel: UILabel!
    @IBOutlet weak var DateField: UITextField!
    @IBOutlet weak var DateLabel: UILabel!
    @IBOutlet weak var SubmitButton: UIButton!

}
