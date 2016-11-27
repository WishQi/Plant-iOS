//
//  MessagesViewController.swift
//  Plant-iOS
//
//  Created by 李茂琦 on 26/11/2016.
//  Copyright © 2016 Li Maoqi. All rights reserved.
//

import UIKit

class MessagesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    // TableView
    @IBOutlet weak var messagesTableView: UITableView!
    
    // Message Model
    var messages = [Message]() {
        didSet {
            messagesTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        
        // 测试数据
        let message = Message()
        message.plantType = "flower"
        message.name = "limaoqi"
        message.warning = "I am hungry"
        messages.append(message)
        
        
        super.viewDidLoad()

        messagesTableView.delegate = self
        messagesTableView.dataSource = self
        
        timer = Timer.scheduledTimer(timeInterval: 10.0,
                                              target: self,
                                              selector: #selector(MessagesViewController.askForNewMessages),
                                              userInfo: nil,
                                              repeats: true)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(createNewMessage(notification:)),
                                               name: Notification.Name("NewMessages"),
                                               object: nil)
    }
    
    // private functions
    @objc private func createNewMessage(notification: Notification) {
        messages = notification.userInfo!["NewMessages"] as! Array + messages
    }
    
    private var timer: Timer!
    @objc fileprivate func askForNewMessages() {
        Message.getData()
    }
    

    // TableView DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as? MessageTableViewCell {
            let message = messages[indexPath.row]
            if let image = TypeImages[message.plantType] {
                cell.plantImageView.image = image
            } else {
                cell.plantImageView.image = TypeImages["default"]!
            }
            cell.plantNameLabel.text = message.name
            cell.warningInfoLabel.text = message.warning
            return cell
        } else {
            return UITableViewCell()
        }
    }

}
