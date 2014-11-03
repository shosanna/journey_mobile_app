//
//  Authentication.swift
//  journey
//
//  Created by Zuzana Dostálová on 02/11/14.
//  Copyright (c) 2014 zuzana.dostalova. All rights reserved.
//

import UIKit

class Authentication: NSObject {
    let defaults = NSUserDefaults.standardUserDefaults()
    let loginKey = "userLoggedIn"
    
    func login(username: String) {
        defaults.setObject(username, forKey: loginKey)
        defaults.synchronize()
    }
    
    func isLoggedIn() -> Bool {
        return defaults.objectForKey(loginKey) != nil
    }
    
    func reset() {
        defaults.setObject(nil, forKey: loginKey)
        defaults.synchronize()
    }
}
