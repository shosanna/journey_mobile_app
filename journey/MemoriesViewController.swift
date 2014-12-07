//
//  MemoriesViewController.swift
//  journey
//
//  Created by Zuzana Dostálová on 27/10/14.
//  Copyright (c) 2014 zuzana.dostalova. All rights reserved.
//

import UIKit

class MemoriesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var memories = [String]()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var formView: UIView!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var memoryText: UITextView!
    @IBOutlet weak var placeField: UITextField!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var dateField: UITextField!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var submitButton: UIButton!
    
    override func viewDidLoad() {
            super.viewDidLoad()
 
            var old = formView.frame
            formView.frame = CGRectMake(old.origin.x, old.origin.y, old.width, 0);
            formView.alpha = 0
            
            memoryText.layer.borderWidth = 0.5;
            memoryText.layer.borderColor = dateField.layer.borderColor
            memoryText.layer.cornerRadius = 5;
        
            // Registering custom cell
            var nipName=UINib(nibName: "MemoryTableViewCell", bundle: nil)
            self.tableView.registerNib(nipName, forCellReuseIdentifier: "memory")
    }


    @IBAction func showMemoryForm(sender: UIButton) {
        UIView.animateWithDuration(0.5, animations: {
            if (self.formView.alpha == 0) {
                self.formView.alpha = 1
            } else {
                self.formView.alpha = 0
            }

        })
    }
    
    @IBAction func memorySubmit(sender: UIButton) {
        if (placeField.hasText() && dateField.hasText() && memoryText.hasText()) {
            
            infoLabel.hidden = true;
            memories.append(memoryText.text)
            tableView.reloadData()
                
            placeField.text = ""
            memoryText.text = ""
            dateField.text = ""
                
            placeField.resignFirstResponder()
            memoryText.resignFirstResponder()
            dateField.resignFirstResponder()

        } else {
            infoLabel.text = "All fields are required!"
            infoLabel.hidden = false;
        }
    }
    

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memories.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // Cell definition
        let cell = tableView.dequeueReusableCellWithIdentifier("memory", forIndexPath: indexPath) as MemoryTableViewCell
        
        if ( memories.count > 0 && !memories[indexPath.row].isEmpty ) {
             cell.memoryText.text = memories[indexPath.row]
        }
       
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100.0
    }

    var selectedIndex: NSIndexPath?
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedIndex = indexPath
        performSegueWithIdentifier("memoryDetail", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "memoryDetail") {
            let vc = segue.destinationViewController as MemoryDetailViewController
            vc.memory = memories[selectedIndex!.row]
        }
    }
 

}
