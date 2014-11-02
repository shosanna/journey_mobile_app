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
    var titles = ["Blue", "Soft", "Arrogant", "Lovely", "Happy", "Bored"]
    var texts = ["I miss Sweden so much", "Everything was great today", "I feel like I can do anything", "...", "Swift is finally wokring!", "I just wish I can sleep!"]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var nipName=UINib(nibName: "DashboardTableViewCell", bundle: nil)
        self.tableView.registerNib(nipName, forCellReuseIdentifier: "DailyTask")
    }


    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }


    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // Cell definition
        let cell = tableView.dequeueReusableCellWithIdentifier("DailyTask", forIndexPath: indexPath) as DashboardTableViewCell
        
        // Title and Text
        cell.DashboardTitle?.text = titles[indexPath.row]
        cell.DashboardText.text = texts[indexPath.row]
        
        // Datum
        let date = NSDate()
        let formatter = NSDateFormatter()
        formatter.timeStyle = .ShortStyle
        formatter.stringFromDate(date)
        
        cell.DashboardDate.text = formatter.stringFromDate(date)
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 75.0
    }

    
    
}
