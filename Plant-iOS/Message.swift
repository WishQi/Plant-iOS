//
//  Message.swift
//  Plant-iOS
//
//  Created by 李茂琦 on 26/11/2016.
//  Copyright © 2016 Li Maoqi. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Message {
    
    // public
    var plantType = ""
    var name = ""
    var warning = ""
    var done = false
    
    // 与后端交互，处理后端数据
    static func getData() {
        var newMessages = [Message]()
        Alamofire.request("http://115.159.1.222:5200/app/plants/data/dangerEvent").validate().responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(json)
                let warnings = json["dangerEventList"].arrayValue
                for each in warnings {
                    let message = Message()
                    message.name = each["plantId"]["name"].stringValue
                    message.warning = each["sentence"].stringValue
                    message.plantType = each["plantId"]["varieties"].stringValue
                    message.done = each["isSolved"].boolValue
                    newMessages.append(message)
                    print(newMessages[0].name)
                }
                Message.broadcastController(newMessages)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // 以广播的方式通知Controller
    static func broadcastController(_ newMessages: [Message]) {
        NotificationCenter.default.post(name: Notification.Name("NewMessages"),
                                        object: nil,
                                        userInfo: ["NewMessages": newMessages])
    }
    
}
