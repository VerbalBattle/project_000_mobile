//
//  AvatarDisplayView.swift
//  ButterUp
//
//  Created by Horst Schmalfuß on 30.10.15.
//  Copyright © 2015 ButterUp inc. All rights reserved.
//

import UIKit

class AvatarDisplayView: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var aboutMe: UITextField!
    @IBOutlet weak var avatarName: UITextField!
    @IBOutlet weak var addAvatar: UIButton!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var addImage: UIButton!
    @IBOutlet weak var imageView: UIImageView!

    var avatarPost = AvatarRequests()

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
    
    // Do something about image by yourself
    
    // dissmiss the image picker controller window
    
    
    func convertImageToBase64(image: UIImage) -> String {
        var imageData = UIImageJPEGRepresentation(image, 0.0)!
        let base64String = imageData.base64EncodedStringWithOptions([])
        return base64String
    }
    self.imageView.image = image

    var avatar = avatarName.text
    var avatarAboutMe = aboutMe.text
    
    var base64String = convertImageToBase64(self.imageView.image!)
//    print(base64String)
    

    avatarPost.postAvatar(base64String, avatarName: avatar!, avatarAboutMe: avatarAboutMe!)
    
    self.dismissViewControllerAnimated(true, completion: nil)
    
}
    
//    submit button where all data gets sent to the server -> when making get request while on profile page ->getting the data back


}

