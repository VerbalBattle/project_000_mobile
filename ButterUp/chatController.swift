//
//  chatController.swift
//  ButterUp
//
//  Created by Horst Schmalfuß on 02.11.15.
//  Copyright © 2015 ButterUp inc. All rights reserved.
//

import UIKit

class chatController: UITableViewController {
    
    var messages = ["hello you fucker", " you are a fucker!!!", "getting chocolate?", "german..."]
    var avatars = ["simon", "bowen", "simon", "bowen", "simo", "bowen", "simon", "bowen"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.messages.count
    }
    
    func append() {
//        get input value and append it to messages array
        
    }
    
    
    override
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->   UITableViewCell {
        let cell = UITableViewCell()
        let label = UILabel(frame: CGRect(x:0, y:0, width:400, height:50))
        label.text = "Message: "+self.messages[indexPath.row]
        let avatar = UILabel(frame: CGRect(x:20, y:20, width:400, height:50))
        
//        keeping track of turn to see which avtar to place on which side of the view
        avatar.text = "Avatar: " + self.avatars[indexPath.row]
        cell.addSubview(avatar)
      
        cell.addSubview(label)
        
        return cell
    }
    
    
    
    
    
    
    


}
