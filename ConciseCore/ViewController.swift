//
//  ViewController.swift
//  TZData
//
//  Created by Henry on 2014/11/22.
//  Copyright (c) 2014年 Cloudbay. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView : UITableView?
    var db : CCDB = CCDB()
    var users : [User]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.users = db.user.all()
        // Do any additional setup after loading the view, typically from a nib.
        db.save { (error) in

        }
    }
    
    override func viewDidAppear(animated: Bool) {
        self.users = db.user.all()
        self.tableView?.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: TableView DataSource -
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.users!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        var user = self.users![indexPath.row]
        cell.textLabel.text = user.name
        return cell
    }
}

