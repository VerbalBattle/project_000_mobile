//
//  RoomViewController.swift
//  ButterUp
//
//  Created by Horst Schmalfuß on 04.11.15.
//  Copyright © 2015 ButterUp inc. All rights reserved.
//

import UIKit
import SwiftyJSON

class RoomViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var exitChat: UIBarButtonItem!
    
    @IBOutlet weak var send: UIButton!
    @IBOutlet weak var input: UITextField!
    @IBOutlet weak var chatView: UITableView!
    var messages = ["hello"]
    var avatarID: String = ""
    var roomID: String = ""
    var room = RoomRequest()
    
    
    func processMessages(messages:[String:JSON]) {
        print(messages)
//        use messages to render table view
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("makgin request to rooms", self.roomID)
        room.getMessages(self.roomID, callback: processMessages)
        self.chatView.delegate = self
        self.chatView.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    @IBAction func exitChat(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: {});
    }
    

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.messages.count
    }
    

   func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->   UITableViewCell {
        let cell = UITableViewCell()
        var label = UILabel(frame: CGRect(x:20, y:20, width:200, height:50))
        label.text = self.messages[indexPath.row] as! String
        cell.addSubview(label)
        return cell
    }
    
   func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    
    @IBAction func send(sender: AnyObject) {
        var inp = input.text
        input.text = ""
        
        if inp! != ""{
        room.postMessage(self.roomID, message: inp!, avID: self.avatarID)
        self.messages.append(inp!)
        self.chatView.reloadData()
        }
    }
}
