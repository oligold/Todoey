//
//  AppDelegate.swift
//  Todoey
//
//  Created by Olivier Goldschmidt on 5/10/19.
//  Copyright © 2019 Olivier Goldschmidt. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
//        print (Realm.Configuration.defaultConfiguration.fileURL)
        
        
        do{
            _ = try Realm()
        }catch{
            print ("Errpr initializing new realm, \(error)")
        }
        
        
        
        return true
    }
    
}

