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
    
    override func viewDidLoad() {
            super.viewDidLoad()
 
            var old = FormView.frame
            FormView.frame = CGRectMake(old.origin.x, old.origin.y, old.width, 0);
            FormView.alpha = 0
            
            MemoryText.layer.borderWidth = 0.5;
            MemoryText.layer.borderColor = DateField.layer.borderColor
            MemoryText.layer.cornerRadius = 5;
        
            // Registering custom cell
            var nipName=UINib(nibName: "MemoryTableViewCell", bundle: nil)
            self.TableView.registerNib(nipName, forCellReuseIdentifier: "Memory")
        
        if (memories.count < 0 ) {
            TableView.hidden = true
        }


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
            memories.append(MemoryText.text)
            TableView.reloadData()
            
            PlaceField.text = ""
            MemoryText.text = ""
            DateField.text = ""
            
            PlaceField.resignFirstResponder()
            MemoryText.resignFirstResponder()
            DateField.resignFirstResponder()
            
//            let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
//            let vc : UIViewController = mainStoryboard.instantiateViewControllerWithIdentifier("loginVC") as UIViewController
//            navigationController?.pushViewController(vc, animated: true)
            
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
        let cell = tableView.dequeueReusableCellWithIdentifier("Memory", forIndexPath: indexPath) as MemoryTableViewCell
        
        if ( memories.count > 0 && !memories[indexPath.row].isEmpty ) {
             cell.MemoryText.text = memories[indexPath.row]
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
    
    @IBOutlet weak var TableView: UITableView!
    @IBOutlet weak var FormView: UIView!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var MemoryText: UITextView!
    @IBOutlet weak var PlaceField: UITextField!
    @IBOutlet weak var PlaceLabel: UILabel!
    @IBOutlet weak var DateField: UITextField!
    @IBOutlet weak var DateLabel: UILabel!
    @IBOutlet weak var SubmitButton: UIButton!

}
