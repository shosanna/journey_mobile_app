//
//  DashboardTableViewController.swift
//  journey
//
//  Created by Zuzana Dostálová on 30/10/14.
//  Copyright (c) 2014 zuzana.dostalova. All rights reserved.
//

import UIKit
import Alamofire

class DashboardViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var emotionFirst: UIButton!
    @IBOutlet weak var emotionSecond: UIButton!
    @IBOutlet weak var emotionThird: UIButton!
    @IBOutlet weak var explainField: UITextField!

    var dailyTasks = [String]()
    var moods = [String]()
    var selectedMood = String()
    let token: String! = Authentication().getLoggedKey()
    var currentTask = NSDictionary()
    
    var refreshControl:UIRefreshControl! 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Registering a custom cell
        var nibName = UINib(nibName: "DashboardTableViewCell", bundle: nil)
        self.tableView.registerNib(nibName, forCellReuseIdentifier: "dailyTask")
        
        // Pull to refresh
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshControl)
        
        //  Request for current minitask
        if (token != nil) {
            Alamofire.request(.GET, "http://localhost:3000/api/v1/minitasks/current", parameters: ["authentication_token": token])
                .responseJSON { (_, _, json, _) in
                    self.currentTask = json as NSDictionary
                    
                    // Set texts for mood buttons / every day there are another moods
                    var title1 = (self.currentTask["choices"] as? [String])![0]
                    var title2 = (self.currentTask["choices"] as? [String])![1]
                    var title3 = (self.currentTask["choices"] as? [String])![2]
                    
                    self.emotionFirst.setTitle(title1, forState: nil)
                    self.emotionSecond.setTitle(title2, forState: nil)
                    self.emotionThird.setTitle(title3, forState: nil)
            }
        }
        
        // Request for all user's minitasks
        loadAllMinitasks()
        
    }


    func refresh(sender:AnyObject)
    {
        // Request for all user's minitasks
        loadAllMinitasks()
        self.refreshControl.endRefreshing()
    }

    // Request for all user's minitasks implementation
    func loadAllMinitasks() {
        if (token != nil) {
            Alamofire.request(.GET, "http://localhost:3000/api/v1/minitasks", parameters: ["authentication_token": token ])
                .responseJSON { (_, _, JSON, _) in
                    
                    let minitasks = JSON as NSArray
                    
                    self.dailyTasks.removeAll(keepCapacity: false)
                    self.moods.removeAll(keepCapacity: false)
                    
                    //  For each minitask in user's history - save it to local arrays
                    for minitask in minitasks {
                        
                        var reason = ((minitask as NSDictionary)["reason"]) as? String
                        var mood = ((minitask as NSDictionary)["selected_choice"]) as? String
                        
                        if reason != nil && mood != nil {
                            self.dailyTasks.append(reason!)
                            self.moods.append(mood!)
                            self.tableView.reloadData()
                        }
                        
                    }
            }
        }
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
            cell.dashboardTitle.text = moods[indexPath.row]
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 85.0
    }
    
    func isMoodSelected() -> Bool {
        return !selectedMood.isEmpty
    }
    
    //    Updating actual minitask which the user completed in the form and sending it to the server
    @IBAction func submitDailyTask(sender: UIButton) {
        infoLabel.hidden = true
 
        if (explainField.hasText() && isMoodSelected()) {
            if (token != nil) {
                let taskID: Int = currentTask["id"] as Int
                
                // Request for update
                Alamofire.request(.PUT, "http://localhost:3000/api/v1/minitasks/\(taskID)", parameters: [
                    "authentication_token": token,
                    "minitask": [
                        "reason": explainField.text,
                        "selected_choice": selectedMood],
                    ])
                explainField.text = ""
                }

        } else {
            infoLabel.hidden = false
            infoLabel.text = "Please select a mood and explain why"
        }
    }
    
    // Selecting a button will save selected mood
    @IBAction func selectMood(sender: UIButton) {
        emotionFirst.backgroundColor = UIColor.clearColor()
        emotionSecond.backgroundColor = UIColor.clearColor()
        emotionThird.backgroundColor = UIColor.clearColor()
        
        sender.backgroundColor = UIColor.lightGrayColor()
        sender.setNeedsDisplay()
        
        if (sender ==  emotionFirst) {
           selectedMood = emotionFirst.titleLabel!.text! as String
        } else if ( sender == emotionSecond) {
            selectedMood = emotionSecond.titleLabel!.text! as String
        } else if ( sender == emotionThird ) {
            selectedMood = emotionThird.titleLabel!.text! as String

        }
    }
    
}
