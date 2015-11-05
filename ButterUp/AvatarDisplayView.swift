//
//  AvatarDisplayView.swift
//  ButterUp
//
//  Created by Horst Schmalfuß on 30.10.15.
//  Copyright © 2015 ButterUp inc. All rights reserved.
//

import UIKit
import SwiftyJSON

class AvatarDisplayView: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var aboutMe: UITextField!
    @IBOutlet weak var avatarName: UITextField!
    @IBOutlet weak var addAvatar: UIButton!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var addImage: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    var buser = User()
    var avatarPost = AvatarRequests()
    
    var avatar: String = ""
    var avatarAboutMe: String = ""
    var base64String: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func submit(sender: AnyObject) {
        print("submit")
    }
    @IBAction func addImage(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary){
            print("Button capture")
            let imag = UIImagePickerController()
            imag.delegate = self
            imag.sourceType = UIImagePickerControllerSourceType.PhotoLibrary;
            //imag.mediaTypes = [kUTTypeImage];
            imag.allowsEditing = false
            self.presentViewController(imag, animated: true, completion: nil)
//        }
        }
    }

    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: AnyObject]) {
        
        var image: UIImage!
        
        // fetch the selected image
        if picker.allowsEditing {
            image = info[UIImagePickerControllerEditedImage] as! UIImage
        } else {
            image = info[UIImagePickerControllerOriginalImage] as! UIImage
        }
       
        
        func convertImageToBase64(image: UIImage) -> String {
            let imageData = UIImageJPEGRepresentation(image, 0.0)!
            let base64String = imageData.base64EncodedStringWithOptions([])
            return "data:image/png;base64," + base64String
        }
        self.imageView.image = image

        self.base64String = convertImageToBase64(self.imageView.image!)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func postAvatar(sender: AnyObject) {
        self.avatar = avatarName.text!
        self.avatarAboutMe = aboutMe.text!
        avatarPost.postAvatar(self.base64String, avatarName: self.avatar, avatarAboutMe: self.avatarAboutMe, callback: addAvatar)
    }
    
    @IBAction func returnToProfileView(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {});
    }
    
    func addAvatar(avatar:[String:JSON]) {
//        get avatarID
        let curravatarID = [String] (avatar.keys)[0]
        var user = buser.getUser()
//        set user avatar object to new avatar JSON object
        user["avatars"][curravatarID] = avatar[curravatarID]!
//        save to localstorage
        let str = user.rawString(NSUTF8StringEncoding)
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setValue(str, forKey: "user")
        defaults.synchronize()
        NSNotificationCenter.defaultCenter().postNotificationName("load", object: nil)
        self.dismissViewControllerAnimated(true, completion: {});
    }
//    submit button where all data gets sent to the server -> when making get request while on profile page ->getting the data back
}

