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
    }
    
    override func viewDidAppear(animated: Bool) {
        self.reloadUser()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func deleteUser(index : Int) {
        var user = self.users?[index]
        user?.delete()
        db.save()
        self.reloadUser()
    }
    
    private func reloadUser() {
        self.users = db.user.all()
        self.tableView?.reloadData()
        if let users = self.users {
            for user in users {
                println("\(user.name)")
            }
        }
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
        if let user = self.users?[indexPath.row] {
            cell.textLabel?.text = user.name
        }
        return cell
    }
    
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return .Delete
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            self.deleteUser(indexPath.row)
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }
}

