//
//  Message.swift
//  
//
//  Created by Horst Schmalfuß on 29.10.15.
//
//

import Foundation
import Alamofire
import JSQMessagesViewController


class Message : NSObject, JSQMessageData {
    var text_: String
    var senderId_: String
    var date_: NSDate
    var roomId_: String
    var senderDisplayName_: String
    var isMediaMessage_: Bool
    var messageHash_: UInt
    
    convenience init(text: String?, sender: String?) {
        self.init(text: text, sender: sender)
    }
    
    init (text: String?, senderId: String?, roomId: String?, senderDisplayName: String) {
        self.text_ = text!
        self.senderId_ = senderId!
        self.date_ = NSDate()
        self.roomId_ = roomId!
        self.senderDisplayName_ = senderDisplayName
        self.isMediaMessage_ = false
        self.messageHash_ = UInt()
    }
    
    func text() -> String! {
        return text_;
    }
    
    func senderId() -> String! {
        return senderId_;
    }
    func messageHash() -> UInt {
        return messageHash_
    }
    
    func date() -> NSDate! {
        return date_;
    }
    
    func roomId() -> String? {
        return roomId_;
    }
    
    func senderDisplayName() -> String! {
        return senderDisplayName_
    }
    func isMediaMessage() -> Bool {
        return isMediaMessage_
    }
    
}