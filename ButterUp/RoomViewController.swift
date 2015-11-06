//
//  RoomViewController.swift
//  ButterUp
//
//  Created by Horst Schmalfuß on 04.11.15.
//  Copyright © 2015 ButterUp inc. All rights reserved.
//

import UIKit
import SwiftyJSON
import Socket_IO_Client_Swift


class RoomViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var exitChat: UIBarButtonItem!
    
    @IBOutlet weak var send: UIButton!
    @IBOutlet weak var input: UITextField!
    @IBOutlet weak var chatView: UITableView!
    var messages: [String] = []
    var ids: [Int] = []
    var avatarID: String = ""
    var roomID: String = ""
    var room = RoomRequest()
    
    
    func processMessages(messages:[(String,JSON)]) {
//        get imagess from avatars here
        print("messages",messages)
        for oneMessage in messages {
            self.messages.append(oneMessage.1["message"].string!)
            self.ids.append(oneMessage.1["avatarID"].int!)
        }
         self.chatView.reloadData()
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
        let label = UILabel(frame: CGRect(x:20, y:20, width:200, height:50))
    
        label.text = self.messages[indexPath.row]
        print("hello", self.messages[indexPath.row])
//        var from  = UILabel(frame: CGRect(x:20, y:50, width:200, height:50))
//        from.text = self.ids[indexPath.row]
        cell.addSubview(label)
        let info = UILabel(frame: CGRect(x:20, y:40, width:200, height:50))
         info.text = String(self.ids[indexPath.row])
//        cell.addSubview(from)
         cell.addSubview(info)
        return cell
    }
    
   func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    
    @IBAction func send(sender: AnyObject) {
        let inp = input.text
        input.text = ""
        
        if inp! != ""{
        room.postMessage(self.roomID, message: inp!, avID: self.avatarID)
        //self.messages.append(inp!)
        self.chatView.reloadData()
        }
    }
}
