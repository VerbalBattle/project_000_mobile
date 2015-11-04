//
//  editAvatar.swift
//  ButterUp
//
//  Created by Horst Schmalfuß on 04.11.15.
//  Copyright © 2015 ButterUp inc. All rights reserved.
//

import UIKit
import SwiftyJSON

class editAvatar: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var editAvatar: UIButton!
    @IBOutlet weak var changeImage: UIButton!
    @IBOutlet weak var editedImage: UIImageView!
    @IBOutlet weak var username: UITextField!

    @IBOutlet weak var aboutMe: UITextField!
    
    var base64String: String = ""
//    get this through segue
    var currentAvatarID: String = ""
    
    var avatarHandler =  AvatarRequests()
    var buser = User()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("calling edit controller")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func changeImage(sender: AnyObject) {
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary){
            print("Button capture")
            let imag = UIImagePickerController()
            imag.delegate = self
            imag.sourceType = UIImagePickerControllerSourceType.PhotoLibrary;
            //imag.mediaTypes = [kUTTypeImage];
            imag.allowsEditing = false
            self.presentViewController(imag, animated: true, completion: nil)
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
        
        self.editedImage.image = image
        
        
        func convertImageToBase64(image: UIImage) -> String {
            let imageData = UIImageJPEGRepresentation(image, 0.0)!
            let base64String = imageData.base64EncodedStringWithOptions([])
            return base64String
        }
        
        self.base64String = convertImageToBase64(self.editedImage.image!)
        
        
        self.dismissViewControllerAnimated(true, completion: nil)

    }
    
    
   

    

    @IBAction func editAvatar(sender: AnyObject) {
        print("hello clicked")
//        put request to avatars
        let image = self.base64String
        let avatarName = self.username.text
        let aboutMe = self.aboutMe.text
        
        var user = buser.getUser()
        //        set user avatar object to new avatar JSON object
//        getting id from segue for this 3
        var avatar = [String:String]()
//        build avatar with current values
        
        avatar["aboutMe"] = self.aboutMe.text
        avatar["avatarName"] = self.username.text
        avatar["image"] = self.base64String
//        this time not getting back anything from the server -> jsonify it??
        user["avatars"]["3"] = avatar
        print("editing avatar", avatar)
        //save to localstorage
        let str = user.rawString(NSUTF8StringEncoding)
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setValue(str, forKey: "user")
        defaults.synchronize()
        
       
        NSNotificationCenter.defaultCenter().postNotificationName("load", object: nil)
        self.dismissViewControllerAnimated(true, completion: {});

        
      
//        data name aboutMe
        let id = String(4)
        
        avatarHandler.putAvatar(id, data:image, avatarName:avatarName!, AboutMe:aboutMe!)
    }
    
}
