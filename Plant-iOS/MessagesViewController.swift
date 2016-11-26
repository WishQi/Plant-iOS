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
    var messages = [Message]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        messagesTableView.delegate = self
        messagesTableView.dataSource = self
    }

    // TableView DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = messagesTableView.dequeueReusableCell(withIdentifier: "messageCell") as? MessageTableViewCell {
            return cell
        } else {
            return UITableViewCell()
        }
    }

}
