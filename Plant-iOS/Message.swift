//
//  Message.swift
//  Plant-iOS
//
//  Created by 李茂琦 on 26/11/2016.
//  Copyright © 2016 Li Maoqi. All rights reserved.
//

import Foundation

class Message {
    
    // public
    var plantType = ""
    var name = ""
    var warning = ""
    
    // 与后端交互，处理后端数据
    
    
    // 以广播的方式通知Controller
    private func broadcastController() {
        NotificationCenter.default.post(name: Notification.Name("NewMessage"),
                                        object: nil,
                                        userInfo: ["plantType": plantType, "name": name, "warning": warning])
    }
    
}
