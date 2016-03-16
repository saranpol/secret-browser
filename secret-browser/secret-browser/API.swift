//
//  API.swift
//  horo-for-touch-id
//
//  Created by saranpol on 10/16/2557 BE.
//  Copyright (c) 2557 hlpth. All rights reserved.
//

import UIKit

//let API_HOST = "secret-browser.appspot.com"

private let _singletonInstance = API()


class API {
    
    var mDocDir = ""
    var mVC: ViewController?
    
    class var a: API {
        return _singletonInstance
    }
    
    init(){
        mDocDir = NSSearchPathForDirectoriesInDomains(.DocumentDirectory,.UserDomainMask,true)[0]
    }
    
    func getViewController(sid:String, id:String) -> UIViewController {
        let storyboard = UIStoryboard(name: sid, bundle: nil)
        return storyboard.instantiateViewControllerWithIdentifier(id)
    }
    
//    func getAPIUrl(name:String, isHttps:Bool) -> String {
//        var http = "http://"
//        if(isHttps){
//            http = "https://"
//        }
//        return http + API_HOST + "/" + name
//    }
//    
//    typealias Res = Response<AnyObject, NSError> -> Void
//    
//    // #########
//    //    API
//    // #########
//    
//
//    func api_data(res: Res) {
//        let url = getAPIUrl("data", isHttps: false)
//        var p = [String:String]()
//        p["time"] = String(NSDate().timeIntervalSince1970)
//        request(.GET, url, parameters: p).responseJSON(completionHandler: res)
//    }
//    
//
//    
//    func getSet(d: AnyObject?) -> AnyObject? {
//        return d?.objectForKey("Set")
//    }
//    
//    func getName(d: AnyObject?) -> String {
//        return d?.objectForKey("Name") as? String ?? ""
//    }
//    
//    func getData(d: AnyObject?) -> AnyObject? {
//        return d?.objectForKey("Data")
//    }
//    
//    func getAdmobID(d: AnyObject?) -> String {
//        return d?.objectForKey("AdmobID") as? String ?? ""
//    }
//    
//    func getImage(d: AnyObject?) -> String {
//        return d?.objectForKey("I") as? String ?? ""
//    }
//
//    func getVideo(d: AnyObject?) -> String {
//        return d?.objectForKey("V") as? String ?? ""
//    }

    
    
    
    // Data Store
    
    func deleteData(key: String) {
        let u = NSUserDefaults.standardUserDefaults()
        u.removeObjectForKey(key)
        u.synchronize()
    }
    
    func saveData(data: AnyObject?, key: String) {
        if(data != nil){
            let u = NSUserDefaults.standardUserDefaults()
            u.setValue(NSKeyedArchiver.archivedDataWithRootObject(data!), forKey: key)
            u.synchronize()
        }
    }
    
    func loadData(key: String) -> AnyObject? {
        let u = NSUserDefaults.standardUserDefaults()
        let data: AnyObject! = u.valueForKey(key)
        if data != nil {
            return NSKeyedUnarchiver.unarchiveObjectWithData(data as! NSData)
        }
        return nil
    }
    
    
//    // Google Analytics
//    func setupAnalytics() {
//        let g = GAI.sharedInstance()
//        g.trackerWithTrackingId("UA-73653891-1")
//        g.trackUncaughtExceptions = true
//        g.logger.logLevel = GAILogLevel.Warning
//    }
//
//    
//    func trackPage(s: String) {
//        //print(s)
//        let t = GAI.sharedInstance().defaultTracker
//        t.set(kGAIScreenName, value: s)
//        
//        let b = GAIDictionaryBuilder.createScreenView()
//        t.send(b.build() as [NSObject : AnyObject])
//    }
}



extension NSNull {
    func length() -> Int { return 0 }
    func integerValue() -> Int { return 0 }
    func floatValue() -> CGFloat { return 0 }
    func objectForKey(key:NSObject) -> AnyObject? { return nil }
    func objectAtIndex(i:Int) -> AnyObject? { return nil }
    func boolValue() -> Bool { return false }
}

