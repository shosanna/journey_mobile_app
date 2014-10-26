//
//  DashboardDataSource.swift
//  journey
//
//  Created by Zuzana Dostálová on 25/10/14.
//  Copyright (c) 2014 zuzana.dostalova. All rights reserved.
//

import UIKit

class DashboardDataSource: NSObject, UITableViewDataSource {

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCellWithIdentifier("dailyTask", forIndexPath: indexPath) as UITableViewCell
    }
}
