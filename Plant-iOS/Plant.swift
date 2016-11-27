//
//  PlantModel.swift
//  Plant-iOS
//
//  Created by 李茂琦 on 26/11/2016.
//  Copyright © 2016 Li Maoqi. All rights reserved.
//

import Foundation
import SwiftyJSON

class Plant {
    
    var id = ""
    var name: String = ""
    var varieties: String = ""
    var image: String = ""
    var sex: String = ""
    var age: Float = 0.0
    var mood: Int = 0
    
    var infoPlantName: String = ""
    var infoIllumination: String = ""
    var infoHumidity: String = ""
    var infoTemperature: String = ""
    var infoSound: String = ""
    
    init(json:JSON) {
        //还没完成哦！！！！
        self.name = String(describing:json["name"])
        self.varieties = String(describing:json["varieties"]["name"])
        self.age = Float(json["age"].doubleValue)
        self.sex = json["sex"].string!
        self.mood = json["mood"].intValue
        
    }
    
    init() {
        
    }
    
}
