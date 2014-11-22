//
//  AddUserViewController.swift
//  TZData
//
//  Created by Henry on 2014/11/22.
//  Copyright (c) 2014年 Cloudbay. All rights reserved.
//

import UIKit

class AddUserViewController: UIViewController {

    @IBOutlet var nameLabel : UITextField?
    var db : CCDB = CCDB()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addUserButtonDidTouch() {
        var value = [
            "name": nameLabel!.text
        ]
        var newUser = self.db.user.create(value)
        self.db.save()
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
