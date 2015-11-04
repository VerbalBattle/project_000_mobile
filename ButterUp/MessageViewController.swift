//
//  ChatController.swift
//  ButterUp
//
//  Created by Horst Schmalfuß on 30.10.15.
//  Copyright © 2015 ButterUp inc. All rights reserved.
//

import UIKit
import Foundation
import JSQMessagesViewController


class MessageViewController: JSQMessagesViewController {
    
    
    var mess1 = Message (text: "i am bowen and i am smart", senderId: "1", roomId: "9",senderDisplayName: "bowen" )
    var mess2 = Message (text: "i am simon and i am smart", senderId: "2", roomId: "9",senderDisplayName: "simon")
    var messages: [Message] = []
    var outgoingBubbleImageView = JSQMessagesBubbleImageFactory().outgoingMessagesBubbleImageWithColor(UIColor.jsq_messageBubbleBlueColor())
    var incomingBubbleImageView = JSQMessagesBubbleImageFactory().incomingMessagesBubbleImageWithColor(UIColor.jsq_messageBubbleGreenColor())
    var batchMessages = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyScrollsToMostRecentMessage = true
        self.inputToolbar!.contentView!.textView!.delegate = self;
        
        self.senderId = (senderId != nil) ? senderId : "Anonymous"
        self.senderDisplayName = (senderDisplayName != nil) ? senderDisplayName : "Anonymous"
        
        messages.append(mess1)
        messages.append(mess2)
        messages.append(Message (text: "i am bowen and i am smart2 and this world isnt fair i am bowen and i am smart2 and this world isnt fair", senderId: "2", roomId: "9",senderDisplayName: "bowen" ))
        messages.append(Message (text: "i am simon and i am smart2 i am bowen and i am smart2 and this world isnt fair", senderId: "2", roomId: "9",senderDisplayName: "simon" ))
        messages.append(Message (text: "i am bowen and i am smart3 i am bowen and i am smart2 and this world isnt fair", senderId: "1", roomId: "9",senderDisplayName: "bowen" ))
        messages.append(Message (text: "i am bowen and i am smart3 i am bowen and i am smart2 and this world isnt fair", senderId: "2", roomId: "9",senderDisplayName: "simon" ))
//        var label = UILabel(10)
//        label.text = "hello bowen"
//        self.view.addSubview(label)
        
//        get all the message by passing in the room id
//        rendering it on the table view

    }
    
    
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, messageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageData! {
        return messages[indexPath.item]
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageBubbleImageDataSource! {
        let message = messages[indexPath.item]
        
        if message.senderId() == "1" {
            return outgoingBubbleImageView
        }
        
        return incomingBubbleImageView
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageAvatarImageDataSource! {
        let message = messages[indexPath.item]
        if message.senderId() == "1" {
            var image = UIImage(named: "battle-1")
            return JSQMessagesAvatarImageFactory.avatarImageWithImage(image, diameter: 5)
        } else {
            var image = UIImage(named: "lobby")
            return JSQMessagesAvatarImageFactory.avatarImageWithImage(image, diameter: 5)
        }
    }

    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = super.collectionView(collectionView, cellForItemAtIndexPath: indexPath) as! JSQMessagesCollectionViewCell
        
        let message = messages[indexPath.item]
        if message.senderId() == senderId {
            cell.textView!.textColor = UIColor.blackColor()
        } else {
            cell.textView!.textColor = UIColor.whiteColor()
        }
//        
//        let attributes : [NSObject:AnyObject] = [NSForegroundColorAttributeName:cell.textView!.textColor!, NSUnderlineStyleAttributeName: 1]
//        cell.textView!.linkTextAttributes = attributes
//        
//        cell.textView!.linkTextAttributes = [NSForegroundColorAttributeName: cell.textView!.textColor!, NSUnderlineStyleAttributeName: NSUnderlineStyle.StyleSingle]
        return cell
    }

    override func collectionView(collectionView: JSQMessagesCollectionView!, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout!, heightForMessageBubbleTopLabelAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        let message = messages[indexPath.item]
        
        // Sent by me, skip
        if message.senderId() == "1" {
            return CGFloat(0.0);
        }
        
        // Same as previous sender, skip
        if indexPath.item > 0 {
            let previousMessage = messages[indexPath.item - 1];
            if previousMessage.senderId() == message.senderId() {
                return CGFloat(0.0);
            }
        }
        
        return kJSQMessagesCollectionViewCellLabelHeightDefault
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
