//
//  AppDelegate.swift
//  Todoey
//
//  Created by Andrew Taylor on 13/03/2018.
//  Copyright © 2018 Andrew Taylor. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
      //  print(Realm.Configuration.defaultConfiguration.fileURL!)

        do {
            let realm = try Realm()
        } catch {
            print("Error \(error)")
        }
        
        return true
    }
    
 


    

}

