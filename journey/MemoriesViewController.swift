//
//  MemoriesViewController.swift
//  journey
//
//  Created by Zuzana Dostálová on 27/10/14.
//  Copyright (c) 2014 zuzana.dostalova. All rights reserved.
//

import UIKit

class Memory {
    let text: String
    let latitude: Double
    let longitude: Double
    
    init(text: String, latitude: Double, longitude: Double) {
        self.text = text
        self.latitude = latitude
        self.longitude = longitude
    }
    
}

class MemoriesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var memories = [Memory]()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var formView: UIView!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var memoryText: UITextView!


    @IBOutlet weak var latField: UITextField!
    @IBOutlet weak var lonField: UITextField!

    @IBOutlet weak var submitButton: UIButton!
    
    override func viewDidLoad() {
            super.viewDidLoad()
 
            var old = formView.frame
            formView.frame = CGRectMake(old.origin.x, old.origin.y, old.width, 0);
            formView.alpha = 0
            
            memoryText.layer.borderWidth = 0.5;
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
        if (latField.hasText() && lonField.hasText() && memoryText.hasText()) {
            
            infoLabel.hidden = true;
            let lat = NSString(string: latField.text).doubleValue
            let lon = NSString(string: lonField.text).doubleValue
            
            let memory = Memory(text: memoryText.text, latitude: lat, longitude: lon)
            memories.append(memory)
            tableView.reloadData()
                
            latField.text = ""
            memoryText.text = ""
            lonField.text = ""
                
            latField.resignFirstResponder()
            memoryText.resignFirstResponder()
            lonField.resignFirstResponder()

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
        
        if (memories.count > 0 && !memories[indexPath.row].text.isEmpty) {
            cell.memoryText.text = memories[indexPath.row].text
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
