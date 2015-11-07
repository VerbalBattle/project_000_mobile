//
//  LobbyTableController.swift
//  ButterUp
//
//  Created by Horst Schmalfuß on 01.11.15.
//  Copyright © 2015 ButterUp inc. All rights reserved.
//

import UIKit
import SwiftyJSON

class LobbyTableController: UITableViewController {
    
    @IBOutlet weak var avatars: UITableView!
    
    var myArray = ["simon","bowen", "zack", "blaine"]
    var avatar: [String:JSON] = [:]
    var avatarID: [String] = []
    var avatarHandler = AvatarRequests()
    var buser = User()
    var roomIDs:[String] = []

    var request = AvatarRequests()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let user = buser.getUser()
       
        for (key,value) in user["avatars"] {
            avatar[key] = value
        }
        avatarID = [String] (avatar.keys)

        
    }
    
    
    // UITableViewDataSource Functions
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.avatar.count
    }
    
    func matchmaking(sender: AnyObject) {
       
        let button = sender as! UIButton
        let view = button.superview  as! UITableViewCell
        
        var user = buser.getUser()
        
        if let cellIndexPath = self.tableView.indexPathForCell(view) {
            let indx = cellIndexPath.row
            let curravatarID = avatarID[indx]
          
            if let item = avatar[curravatarID] {
//                print(item["stats"])
//                elo: avatarStats['Elo'],
//                avatarType: avatarStats['Avatar Type'],
//                winLossRatio: avatarStats['Win/Loss Ratio'],
//                winStreak: avatarStats['Win Streak']
//            };
                var elo = item["stats"]["elo"].intValue
                var type = item["stats"]["avatarType"].string
                var winLossRatio = item["stats"]["winLossRatio"].intValue
                var winStr = item["stats"]["winStreak"].int
               
                avatarHandler.matchMaking(Int(curravatarID)! , elo: elo, type: type!, winloss: winLossRatio, winStreak: winStr!)
            }
        }
        
    }
    
    func goRoom (sender: UIButton) {
        print("going to room", sender.titleLabel!.text)
        let  viewController = self.storyboard!.instantiateViewControllerWithIdentifier("realRoom") as! RoomViewController
        let navController = UINavigationController(rootViewController: viewController)

        var user = buser.getUser()

        let button = sender as! UIButton
        
        let view = button.superview  as! UITableViewCell
        
        if let cellIndexPath = self.tableView.indexPathForCell(view) {
            //     slice array at index cellIndexPath.row
            let indx = cellIndexPath.row
            let curravatarID = avatarID[indx]
            if let roomID =  sender.titleLabel!.text {
                viewController.roomID = roomID
            }
            viewController.avatarID = curravatarID

          
            
//            tabViewController.roomID = Int()
            
//            getting roomID
////            getting the number of which room is actually getting chose
//            tabViewController.roomID = u["avatars"][curravatarID]["rooms"]["1"]["roomID"].string!
//            print(u["avatars"][curravatarID]["rooms"]["1"]["roomID"], "this is what i want to print") -> getting roomID to pass to roomviewcontroller
//           
           
        }
        self.presentViewController(navController, animated: true, completion: nil)
        
    
}
    
    
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
    

       

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->   UITableViewCell {
        let cell = UITableViewCell()
        let avatarName = UILabel(frame: CGRect(x:20, y:20, width:200, height:60))
        let aboutMe = UILabel(frame: CGRect(x:20, y:205, width:200, height:120))
        let makeMatch = UIButton(frame: CGRect(x:180, y:40, width:140, height:60))
        var yCor : CGFloat = 90
        let goToRoom = UIButton(frame: CGRect(x:30, y:yCor, width:140, height:30))

        makeMatch.addTarget(self, action: "matchmaking:", forControlEvents: .TouchUpInside)
        goToRoom.addTarget(self, action: "goRoom:", forControlEvents: .TouchUpInside)

        
//        button.setTitle("Make Match", forState: UIControlState.Normal)
        makeMatch.backgroundColor = UIColor.greenColor()
        goToRoom.backgroundColor = UIColor.blueColor()
        

        var label = UILabel(frame: CGRect(x:280, y:40, width:140, height:60))
        
        if let lab = self.avatar[avatarID[indexPath.row]] {
            avatarName.text = lab["avatarName"].string
            makeMatch.setTitle("Match " + avatarName.text! , forState: UIControlState.Normal)
            aboutMe.text = lab["aboutMe"].string
            var imagesource = lab["imageSource"]
            var image = validUrl(imagesource.string!)
            print("image is", image)
            var imageV = UIImageView(frame: CGRect(x:140, y:15, width:70, height:70))
            imageV.image = image
            
            imageV.layer.cornerRadius = imageV.frame.height/2
            imageV.layer.borderWidth = 1.0
            imageV.layer.masksToBounds = false
            imageV.layer.borderColor = UIColor.whiteColor().CGColor
            imageV.clipsToBounds = true

            print("rounded image")
            var rooms = lab["rooms"]
           
          
            for (key,subJson):(String, JSON) in rooms {
//                 avatarName.text = subJson["roomID"].string
                print("the sub json is", subJson)
                var opponent = subJson["opponentName"]
                print("id is here", subJson["roomID"])
               
                
                label.text = opponent.string
                print(subJson["roomID"].string, "roomID")
//                does not get added to button as value -> maybe because not av sometimes
//                getting real roomID instead of hard coded one
//                only append button when rooms actually exists
                print("key is", key)
                if key != "null" {
                goToRoom.setTitle(key, forState: UIControlState.Normal)
                var roomWith = subJson["opponentName"].string!
                var enemyLabel = UILabel(frame: CGRect(x:50, y:140, width:200, height:25))
                enemyLabel.text = "In a room with:" + roomWith
                var str =  subJson["opponentImage"].string
                var turn = subJson["canTakeTurn"].bool
                
                    if turn == true {
                        var turnLabel = UILabel(frame: CGRect(x:50, y:170, width:200, height:25))
                        turnLabel.text = "Its your turn to write"
                        cell.addSubview(turnLabel)
                    }
                  
                var image =  validUrl(str!)
                var view = UIImageView(frame: CGRect(x:50, y:160, width:70, height:70))
                view.image = image
                view.layer.cornerRadius = view.frame.height/2
                view.layer.borderWidth = 1.0
                view.layer.masksToBounds = false
                view.layer.borderColor = UIColor.whiteColor().CGColor
                view.clipsToBounds = true
                    
    
                print("adding opp image", view, str)
                cell.addSubview(view)
                
                cell.addSubview(enemyLabel)
//                cell.addSubview(goToRoom)
//                    add button here with incrementing coordinates
                print("appending gotoroom", key, yCor)
                    
                print("button check coords", goToRoom)
//                    appending button of multi room to cell
      
                cell.addSubview(goToRoom)
            }
        }
            print(self.roomIDs)
//            cell.addSubview(joinRoom)
            cell.addSubview(label)
            cell.addSubview(aboutMe)
            cell.addSubview(avatarName)
            cell.addSubview(makeMatch)
            cell.addSubview(imageV)
      }
        return cell
    }
    
    
    // UITableViewDelegate Functions
        override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
            return 350
        }
    
    
    func handleClick(sender: UIButton) {
        print("got clicked, making match")
//        making post request to matchmaking
        
    }

 
}