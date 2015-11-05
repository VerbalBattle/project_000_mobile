//
//  VoteController.swift
//  ButterUp
//
//  Created by Horst Schmalfuß on 05.11.15.
//  Copyright © 2015 ButterUp inc. All rights reserved.
//

import UIKit
import SwiftyJSON

class VoteController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    
    @IBOutlet weak var vote2: UIButton!
    @IBOutlet weak var vote1: UIButton!
    @IBOutlet weak var voteView: UITableView!
    
    
    func fillView () {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.voteView.delegate = self
        self.voteView.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        get real messages form vote route -> get closed rooms
        return 3
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->   UITableViewCell {
        let cell = UITableViewCell()
        var label = UILabel(frame: CGRect(x:20, y:20, width:200, height:50))
        label.text = "hi"
        cell.addSubview(label)
        return cell
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
}
