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
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(createNewMessage(notification:)),
                                               name: Notification.Name("NewMessage"),
                                               object: nil)
    }
    
    // private functions
    @objc private func createNewMessage(notification: Notification) {
        let message = Message()
        message.plantType = notification.userInfo!["plantType"] as! String
        message.name = notification.userInfo!["name"] as! String
        message.warning = notification.userInfo!["warning"] as! String
        messages.append(message)
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
                cell.plantImageView.image = TypeImages["default.png"]!
            }
            cell.plantNameLabel.text = message.name
            cell.warningInfoLabel.text = message.warning
            return cell
        } else {
            return UITableViewCell()
        }
    }

}
