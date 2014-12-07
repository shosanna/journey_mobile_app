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

    }


    func refresh(sender:AnyObject)
    {
        //  Request for current minitask
        if (token != nil) {
            Alamofire.request(.GET, "http://localhost:3000/api/v1/minitasks/current", parameters: ["authentication_token": token])
                .responseJSON { (_, _, json, _) in
                    self.currentTask = json as NSDictionary
                    }
                }
        

        // Request for all user's minitasks
        if (token != nil) {
            Alamofire.request(.GET, "http://localhost:3000/api/v1/minitasks", parameters: ["authentication_token": token ])
                    .responseJSON { (_, _, JSON, _) in
        
                    let minitasks = JSON as NSArray
                        
                        self.dailyTasks.removeAll(keepCapacity: false)
                        for minitask in minitasks {
                          
                            var reason = ((minitask as NSDictionary)["reason"]) as? String

                            if reason != nil {
                                self.dailyTasks.append(reason!)
                                self.tableView.reloadData()
                            }
                            
                        }
                }
            }
        self.refreshControl.endRefreshing()
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
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 85.0
    }
    
    func isMoodSelected() -> Bool {
        return !selectedMood.isEmpty
    }
    
    @IBAction func submitDailyTask(sender: UIButton) {
        
        infoLabel.hidden = true
 
        if (explainField.hasText() && isMoodSelected()) {
            if (!Authentication().isLoggedIn()) {
                presentLoginVC()
            } else {
     
            if (token != nil) {
                Alamofire.request(.PUT, "http://localhost:3000/api/v1/minitasks/145", parameters: [
                    "authentication_token": token,
                    "minitask": [
                        "reason": explainField.text,
                        "selected_choice": selectedMood],
                    ])
                    .responseJSON { (_, _, json, _) in
                        println(json)
                    }
                }
            explainField.text = ""
            }

        } else {
            infoLabel.hidden = false
            infoLabel.text = "Please select a mood and explain why"
        }
      
    }
    
    func presentLoginVC() {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let vc : UIViewController = mainStoryboard.instantiateViewControllerWithIdentifier("loginVC") as UIViewController
        navigationController!.presentViewController(vc, animated: false, completion: nil)
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
