//
//  editAvatarViewController.swift
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
    @IBOutlet weak var avatarName: UITextField!
    var id: String = ""
    var about:  String = ""
    var name: String = ""
    var imageD: String = ""
    @IBOutlet weak var cancelEdit: UIBarButtonItem!
    @IBOutlet weak var aboutMe: UITextField!
    
    var base64String: String = ""
//    get this through segue
    var currentAvatarID: String = ""
    
    var avatarHandler =  AvatarRequests()
    var buser = User()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        avatarName.text = name
        aboutMe.text = about
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
            return "data:image/png;base64," + base64String
        }
        self.base64String = convertImageToBase64(self.editedImage.image!)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func cancelEdit(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {});
    }
    
    @IBAction func editAvatar(sender: AnyObject) {
        print("hello clicked")
//        put request to avatars
        var user = buser.getUser()
        //        set user avatar object to new avatar JSON object
//        getting id from segue for this 3

//        build avatar with current values
        
        user["avatars"][self.id]["aboutMe"] = JSON(self.aboutMe.text!)
        user["avatars"][self.id]["avatarName"] = JSON(self.avatarName.text!)
        user["avatars"][self.id]["imageSource"] = JSON(self.base64String)
////        this time not getting back anything from the server -> jsonify it??
        //save to localstorage
        let str = user.rawString(NSUTF8StringEncoding)
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setValue(str, forKey: "user")
        defaults.synchronize()
       
        NSNotificationCenter.defaultCenter().postNotificationName("load", object: nil)
        self.dismissViewControllerAnimated(true, completion: {});

//        data name aboutMe
        print("simon ID",self.id)
        avatarHandler.putAvatar(self.id, data:self.base64String, avatarName:self.avatarName.text!, AboutMe:self.aboutMe.text!)
    }
    
}
