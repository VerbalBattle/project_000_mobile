//
//  TabViewController.swift
//  ButterUp
//
//  Created by Horst Schmalfuß on 30.10.15.
//  Copyright © 2015 ButterUp inc. All rights reserved.
//

import UIKit
import SwiftyJSON

class UserViewController: UITableViewController {
   
    var avatars: [String:JSON] = [:]
    var avatarID: [String] = []
    var avatarHandler = AvatarRequests()
    var buser = User()

    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "loadList:", name:"load", object: nil)
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationController?.navigationBarHidden = true
        let user = buser.getUser()
        for (key,value) in user["avatars"] {
           avatars[key] = value
        }
        avatarID = [String] (avatars.keys)
    }
    
    func loadList(notification: NSNotification) {
        print("load is called")
        let user = buser.getUser()
        for (key,value) in user["avatars"] {
            avatars[key] = value
        }
        avatarID = [String] (avatars.keys)
        self.tableView.reloadData()
    }
    
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.avatars.count
    }
 
    override
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 250
    }
    
    func Delete(sender:AnyObject?) {
        print("editing")
        
        let button = sender as! UIButton
        let view = button.superview  as! UITableViewCell
      
        var user = buser.getUser()

        if let cellIndexPath = self.tableView.indexPathForCell(view) {
     //     slice array at index cellIndexPath.row
            let indx = cellIndexPath.row
            let curravatarID = avatarID[indx]
            self.avatars.removeValueForKey(curravatarID)
            avatarID = [String] (avatars.keys)
            //var i = curravatarID as! Int
            avatarHandler.deleteAvatar(curravatarID)
        }
        
        user["avatars"] = JSON(self.avatars)
    
        let str = user.rawString(NSUTF8StringEncoding)
        
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setValue(str, forKey: "user")
        defaults.synchronize()
        self.tableView.reloadData()
    }
    
    func edit(sender: AnyObject) {
        print("editing")
        let viewController = self.storyboard!.instantiateViewControllerWithIdentifier("edit") as! editAvatar
        
        
        let button = sender as! UIButton
        let view = button.superview  as! UITableViewCell
        
        if let cellIndexPath = self.tableView.indexPathForCell(view) {
            //     slice array at index cellIndexPath.row
            let indx = cellIndexPath.row
            let curravatarID = avatarID[indx]
            viewController.id = curravatarID
            viewController.about = avatars[curravatarID]!["aboutMe"].string!
            viewController.name = avatars[curravatarID]!["avatarName"].string!

        }
            
        self.presentViewController(viewController, animated: true, completion: nil)
        performSegueWithIdentifier("editAvatar", sender: sender)
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->   UITableViewCell {
        let cell = UITableViewCell()
        
        let avatarName = UILabel(frame: CGRect(x:20, y:20, width:200, height:50))
        let aboutMe = UILabel(frame: CGRect(x:20, y:20, width:200, height:120))
        var image = UIImage()
        let imageView = UIImageView(frame: CGRect(x:70, y:100, width:100, height:100))
        let deleteButton = UIButton(frame: CGRect(x:110, y:40, width:80, height:60))
        let editButton = UIButton(frame: CGRect(x:220, y:40, width:80, height:60) )
        deleteButton.setTitle("Delete", forState: UIControlState.Normal)

        editButton.setTitle("Edit", forState: UIControlState.Normal)
        deleteButton.backgroundColor = UIColor.greenColor()
        editButton.backgroundColor = UIColor.redColor()
        
        editButton.addTarget(self, action: "edit:", forControlEvents: .TouchUpInside)
        deleteButton.addTarget(self, action: "Delete:", forControlEvents: .TouchUpInside)
        
        func convertBase64ToImage(base64String: String) -> UIImage {
            let decodedData = NSData(base64EncodedString: base64String, options: NSDataBase64DecodingOptions(rawValue: 0) )
            let decodedimage = UIImage(data: decodedData!)
            return decodedimage!
        }
        
        if let lab = self.avatars[avatarID[indexPath.row]] {
            avatarName.text = lab["avatarName"].string
            aboutMe.text = lab["aboutMe"].string
            if let imageSrc = lab["imageSource"].string {
                var imageBinary = ""
                if(imageSrc == "data:," || imageSrc == "data:image/png;base64," || imageSrc == "") {
                    imageBinary = "R0lGODlhAQABAIAAAP///////yH5BAEKAAEALAAAAAABAAEAAAICTAEAOw=="

                } else {
                    imageBinary = String(imageSrc.characters.split {$0 == ","}[1])
                }
                image = convertBase64ToImage(imageBinary)
            }
        }
        
        imageView.image = image
        cell.addSubview(deleteButton)
        cell.addSubview(editButton)
        cell.addSubview(imageView)
        cell.addSubview(avatarName)
        cell.addSubview(aboutMe)
//        cell.addSubview(imageView)
        
        return cell
    }
}
