//
//  LobbyTableController.swift
//  ButterUp
//
//  Created by Horst Schmalfuß on 01.11.15.
//  Copyright © 2015 ButterUp inc. All rights reserved.
//

import UIKit

class LobbyTableController: UITableViewController {
    
    @IBOutlet weak var avatars: UITableView!
    
    var myArray = ["simon","bowen", "zack", "blaine"]
    var request = AvatarRequests()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        request.getAvatars(5)
        
    }
    
    
    // UITableViewDataSource Functions
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.myArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->   UITableViewCell {
        let cell = UITableViewCell()
        let label = UILabel(frame: CGRect(x:0, y:0, width:200, height:50))
        label.text = myArray[indexPath.row]
        let button = UIButton(frame: CGRect(x:0, y:0, width:200, height:50))
        button.setTitle("Make Match", forState: UIControlState.Normal)
         button.addTarget(self, action: "handleClick:", forControlEvents: UIControlEvents.TouchUpInside)
        let imageView = UIImageView()
        let image = UIImage(named: "magnify")
        imageView.image = image
        cell.addSubview(imageView)
        cell.addSubview(button)
        cell.addSubview(label)
      
        return cell
    }
    
    
    // UITableViewDelegate Functions
override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 150
    }
    
    
    func handleClick(sender: UIButton) {
        print("got clicked, making match")
//        making post request to matchmaking
        
    }

}
