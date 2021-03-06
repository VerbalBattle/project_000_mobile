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
    let socket = SocketIOClient(socketURL: "http://localhost:3000", options: [.Log(true), .ForcePolling(true)])
    
    @IBOutlet weak var send: UIButton!
    @IBOutlet weak var input: UITextField!
    @IBOutlet weak var chatView: UITableView!
    var messages: [String] = []
    var ids: [Int] = []
   
    var avatarID: String = ""
    var roomID: String = ""
    var currentSource: String = ""
    var oppImage: String = ""
    var oppImageAv: Bool = false
    var imageData: String = ""
    var room = RoomRequest()
    var user = User()
    

    func convertBase64ToImage(base64String: String) -> UIImage {
        let decodedData = NSData(base64EncodedString: base64String, options: NSDataBase64DecodingOptions(rawValue: 0) )
        let decodedimage = UIImage(data: decodedData!)
        return decodedimage!
    }

    
    func validUrl(invalid: String) -> UIImage {
        var imageBinary = ""
        if(invalid == "data:," || invalid == "data:image/png;base64," || invalid == "") {
            imageBinary = "R0lGODlhAQABAIAAAP///////yH5BAEKAAEALAAAAAABAAEAAAICTAEAOw=="
            
        } else {
            imageBinary = String(invalid.characters.split {$0 == ","}[1])
        }
        return convertBase64ToImage(imageBinary)
    }
    
    
    func processMessages(messages:[(String,JSON)]) {
//        get imagess from avatars here
       
        self.messages = []
        for oneMessage in messages {
            self.messages.append(oneMessage.1["message"].string!)
            print("name are", oneMessage.1)
            self.ids.append(oneMessage.1["avatarID"].int!)
        }
         self.chatView.reloadData()
//        use messages to render table view
        
    }
    
    func updateRoom() {
        print("updatig rooms")
        room.getMessages(self.roomID, callback: processMessages)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("all room data is here", user.getUser()["avatars"][self.avatarID]["rooms"][self.roomID]["opponentImage"])
        self.imageData = user.getUser()["avatars"][self.avatarID]["rooms"][self.roomID]["opponentImage"].string!
        if imageData != "data:,"{
            print("image here")
            oppImageAv = true
        } else {
            print("no image av")
        }
        var timer = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: "updateRoom", userInfo: nil, repeats: true)
        print("oppimage is the value we want", self.oppImage)
        print("socket event")
        socket.on("connect") {data, ack in
            print("socket connected")
        
        self.socket.on("client:turnUpdate") {data, ack in
            print(data, "message form otehr client")
         }
        }
        socket.connect()
        
        self.currentSource = user.getUser()["avatars"][self.avatarID]["imageSource"].string!
        print(validUrl(self.currentSource))
        
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
    
    
        let label = UILabel(frame: CGRect(x:20, y:10, width:200, height:50))
        label.text = self.messages[indexPath.row]
       //        var from  = UILabel(frame: CGRect(x:20, y:50, width:200, height:50))
//        from.text = self.ids[indexPath.row]
    
        cell.addSubview(label)
        let info = UILabel(frame: CGRect(x:20, y:30, width:200, height:50))
        info.text = String(self.ids[indexPath.row])
//        cell.addSubview(from)
        cell.addSubview(info)
        let profile = validUrl(self.currentSource)
        let imageView = UIImageView(frame: CGRect(x:70, y:65, width:70, height:70))
        imageView.image = profile
    
    imageView.layer.cornerRadius = imageView.frame.height/2
    imageView.layer.borderWidth = 1.0
    imageView.layer.masksToBounds = false
    imageView.layer.borderColor = UIColor.whiteColor().CGColor
    imageView.clipsToBounds = true
    
    if String(self.ids[indexPath.row]) == self.avatarID {
        cell.addSubview(imageView)
////    
//        var oppImage = validUrl(self.imageData)
//        let oppView = UIImageView(frame: CGRect(x:70, y:5, width:70, height:70))
//        oppView.image = oppImage
//        cell.addSubview(oppView)
//        print("curretnsource", self.currentSource)
    } else {
    
    if  oppImageAv {
        print("it is here yeihhh")
//        append opponent image to cell
        var image = validUrl(self.imageData)
        var view = UIImageView(frame: CGRect(x:70, y:65, width:70, height:70))
        view.image = image
        
        view.layer.cornerRadius = view.frame.height/2
        view.layer.borderWidth = 1.0
        view.layer.masksToBounds = false
        view.layer.borderColor = UIColor.whiteColor().CGColor
        view.clipsToBounds = true
        

        cell.addSubview(view)
        
    }
      
    
    }
        return cell
    }
    
   func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 150
    }
    
    
    @IBAction func send(sender: AnyObject) {
        let inp = input.text
        input.text = ""
        
        if inp! != ""{
        room.postMessage(self.roomID, message: inp!, avID: self.avatarID)
//        self.messages.append(inp!)
////        var id = String(self.avatarID)
//        self.ids.append(Int(self.avatarID)!)
        self.chatView.reloadData()
        }
    }
}
