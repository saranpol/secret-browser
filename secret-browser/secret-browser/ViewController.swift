//
//  ViewController.swift
//  secret-browser
//
//  Created by saranpol on 3/13/2559 BE.
//  Copyright © 2559 hlpth. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIWebViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var mWebView: UIWebView!
    @IBOutlet weak var mTextField: UITextField!
    
    var mViewFolderNav: UINavigationController?
    
    let mKeyPassword = "mKeyPassword"
    var mFirstPassword: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        API.a.mVC = self
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let password = API.a.loadData(mKeyPassword) as? String
        if(password == nil){
            alertPassword()
        }else{
            mTextField.becomeFirstResponder()
        }
       
    }
    
    
    
    func gotoViewBrowser() {
        mTextField.text = ""
        mViewFolderNav?.dismissViewControllerAnimated(false, completion: nil)
        mWebView.loadHTMLString("", baseURL: nil)
    }
    

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        mTextField.resignFirstResponder()
        
        let password = API.a.loadData(mKeyPassword) as? String
        if(textField.text == password){
            mViewFolderNav = API.a.getViewController("Main", id: "ViewFolderNav") as? UINavigationController
            presentViewController(mViewFolderNav!, animated: true, completion: nil)
            return true
        }
        
        let r = NSURLRequest(URL: NSURL(string: "http://" + textField.text!)!)
        mWebView.loadRequest(r)
        return true
    }




    func alertPassword() {
        var t: UITextField?
        let v = UIAlertController(title: "Create Your Password", message: "for access hidden photos", preferredStyle: .Alert)
        
        v.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            if(t == nil || t!.text == ""){
                self.alertPassword()
                return
            }
            self.mFirstPassword = t!.text
            self.alertPasswordAgain()
        }))
        
        v.addTextFieldWithConfigurationHandler({(textField: UITextField!) in
            textField.placeholder = "Password"
            t = textField
        })
        
        v.view.setNeedsLayout()
        presentViewController(v, animated: true, completion: nil)
    }
    
    func alertPasswordAgain() {
        var t: UITextField?
        let v = UIAlertController(title: "Enter Password Again", message: "for access hidden photos", preferredStyle: .Alert)
        
        v.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            if(self.mFirstPassword != t!.text){
                self.alertPasswordNotMatch()
                return
            }
            
            API.a.saveData(t!.text, key: self.mKeyPassword)
            self.alertSuccessSetPassword()
        }))
        
        v.addTextFieldWithConfigurationHandler({(textField: UITextField!) in
            textField.placeholder = "Password"
            t = textField
        })
        
        v.view.setNeedsLayout()
        presentViewController(v, animated: true, completion: nil)
    }
    
    
    func alertPasswordNotMatch() {
        let v = UIAlertController(title: "Password Not Match", message: "Please enter password again", preferredStyle: .Alert)
        v.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            self.alertPassword()
        }))
        presentViewController(v, animated: true, completion: nil)
    }
    
    func alertSuccessSetPassword() {
        let v = UIAlertController(title: "Set Password Complete", message: "Enter password in website name to access hidden photos", preferredStyle: .Alert)
        v.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
        }))
        presentViewController(v, animated: true, completion: nil)
    }

}

