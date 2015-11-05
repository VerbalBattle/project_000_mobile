//
//  chatController.swift
//  ButterUp
//
//  Created by Horst Schmalfuß on 02.11.15.
//  Copyright © 2015 ButterUp inc. All rights reserved.
//

import UIKit
import Socket_IO_Client_Swift

class ChatViewController: UITableViewController {
    
    @IBOutlet weak var input: UITextField!
    
    var messages = ["hello you fucker", " you are a fucker!!!", "getting chocolate?", "german...", "hello bowen"]
    var avatars = ["simon", "bowen", "simon", "bowen", "simo", "bowen", "simon", "bowen"]
    var id: Int = 0
    var roomID:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("got id", self.id, "my room is is", self.roomID)
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
    
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
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
    
    func inputText(sender: UIButton) {
        print("event")
        print(sender)
        let inputText = input.text
        print(inputText)
        if let inp = inputText{
        self.messages.append(inp)
        print(inp)
        input.text = ""
        self.tableView.reloadData()
        }
        
    }
    
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let vw = UIView()
        let label = UILabel(frame: CGRect(x:20, y:20, width:400, height:50))
        label.text = "Ready to Chat?"
        let send = UIButton(frame: CGRect(x:20, y:50, width:200, height:50))
       
        send.setTitle("send message", forState: UIControlState.Normal)
       
        send.addTarget(self, action: "inputText:", forControlEvents: .TouchUpInside)
        send.backgroundColor = UIColor.greenColor()

        vw.addSubview(send)
        vw.addSubview(label)
    
        return vw
    }
   
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    
    
    


}
