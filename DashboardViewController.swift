//
//  DashboardTableViewController.swift
//  journey
//
//  Created by Zuzana Dostálová on 30/10/14.
//  Copyright (c) 2014 zuzana.dostalova. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var emotionFirst: UIButton!
    @IBOutlet weak var emotionSecond: UIButton!
    @IBOutlet weak var emotionThird: UIButton!
    @IBOutlet weak var explainField: UITextField!

    var dailyTasks = [String]()
    var selectedMood = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Registering a custom cell
        var nibName = UINib(nibName: "DashboardTableViewCell", bundle: nil)
        self.tableView.registerNib(nibName, forCellReuseIdentifier: "dailyTask")
    }


    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dailyTasks.count
    }


    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // Cell definition
        let cell = tableView.dequeueReusableCellWithIdentifier("dailyTask", forIndexPath: indexPath) as DashboardTableViewCell
        
        if ( dailyTasks.count > 0 && !dailyTasks[indexPath.row].isEmpty ) {
            // Text and title
            cell.dashboardText.text = dailyTasks[indexPath.row]
            cell.dashboardTitle.text = selectedMood
        
            // Datum
            let date = NSDate()
            let formatter = NSDateFormatter()
            formatter.timeStyle = .ShortStyle
            formatter.stringFromDate(date)
            
            cell.dashboardDate.text = formatter.stringFromDate(date)
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 75.0
    }
    
    func isMoodSelected() -> Bool {
        return !selectedMood.isEmpty
    }
    
    @IBAction func submitDailyTask(sender: UIButton) {
        
        infoLabel.hidden = true
 
        if (explainField.hasText() && isMoodSelected()) {
            if (!Authentication().isLoggedIn()) {
                let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
                let vc : UIViewController = mainStoryboard.instantiateViewControllerWithIdentifier("loginVC") as UIViewController
                navigationController?.pushViewController(vc, animated: false)
            } else {
                dailyTasks.append(explainField.text)
                tableView.reloadData()
                explainField.text = ""
            }

        } else {
            infoLabel.hidden = false
            infoLabel.text = "Please select a mood and explain why"
        }
    }
    
    @IBAction func selectMood(sender: UIButton) {
        // TODO: there must be a better way :)
        emotionFirst.backgroundColor = UIColor.clearColor()
        emotionSecond.backgroundColor = UIColor.clearColor()
        emotionThird.backgroundColor = UIColor.clearColor()
        
        sender.backgroundColor = UIColor.lightGrayColor()
        sender.setNeedsDisplay()
        
        if (sender ==  emotionFirst) {
           selectedMood = "Fragile"
        } else if ( sender == emotionSecond) {
            selectedMood = "Crazy"
        } else if ( sender == emotionThird ) {
            selectedMood = "Sweet"
        }
    }
    
}
