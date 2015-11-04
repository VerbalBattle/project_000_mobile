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

    func getUser() ->JSON {
        if let currentUserStr = NSUserDefaults.standardUserDefaults().stringForKey("user") {
            if let currentUser = currentUserStr.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) {
                
                return JSON(data: currentUser)
            }
        }
        return JSON("{}")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationController?.navigationBarHidden = true
        let user = getUser()
        for (key,value) in user["avatars"] {
           avatars[key] = value
        }
        avatarID = [String] (avatars.keys)
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
        var user = getUser()

        if let cellIndexPath = self.tableView.indexPathForCell(view) {
            print(cellIndexPath.row)
     //     slice array at index cellIndexPath.row
            let indx = cellIndexPath.row
            self.avatars.removeValueForKey(avatarID[indx])
            avatarID = [String] (avatars.keys)
        }
        
        user["avatars"] = JSON(self.avatars)

        let str = user.rawString(NSUTF8StringEncoding)
        
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setValue(str, forKey: "user")
        defaults.synchronize()
        
        self.tableView.reloadData()
    }
    
    func edit(sender: AnyObject) {
        print("deleting")
        print(sender)
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
                if(imageSrc == "data:,") {
                    imageBinary = "R0lGODlhAQABAIAAAP///////yH5BAEKAAEALAAAAAABAAEAAAICTAEAOw=="

                } else {
                    imageBinary = String(imageSrc.characters.split {$0 == ","}[1])
                }
                image = convertBase64ToImage(imageBinary)
            }
        }
        
        imageView.image = image
        print(imageView)
        cell.addSubview(deleteButton)
        cell.addSubview(editButton)
        cell.addSubview(imageView)
        cell.addSubview(avatarName)
        cell.addSubview(aboutMe)
//        cell.addSubview(imageView)
        
        return cell
    }
}
