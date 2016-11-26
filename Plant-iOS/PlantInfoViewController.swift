//
//  PlantInfoViewController.swift
//  Plant-iOS
//
//  Created by 李茂琦 on 26/11/2016.
//  Copyright © 2016 Li Maoqi. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SwiftChart

class PlantInfoViewController: UIViewController {
    
    @IBOutlet weak var plantVariety: UILabel!
    @IBOutlet weak var plantAge: UILabel!
    @IBOutlet weak var plantSex: UILabel!
    @IBOutlet weak var plantMood: UILabel!
    
    @IBOutlet weak var plantCategImage: UIImageView!
    @IBOutlet weak var plantName: UILabel!
    @IBOutlet weak var illumination: UILabel!
    @IBOutlet weak var humidity: UILabel!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var sound: UILabel!
    
    @IBOutlet weak var temChart: Chart!
    @IBOutlet weak var humChart: Chart!
    @IBOutlet weak var illuChart: Chart!
    
    
    var plantInstance = Plant()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        plantName.text = plantInstance.name
        plantCategImage.image = UIImage(named: plantInstance.image)
        illumination.text = plantInstance.infoIllumination
        humidity.text = plantInstance.infoHumidity
        temperature.text = plantInstance.infoHumidity
        sound.text = plantInstance.infoSound
        
        plantVariety.text = plantInstance.varieties
        plantAge.text = String(plantInstance.age)
        plantSex.text = plantInstance.sex
        plantMood.text = String(plantInstance.mood)
        
        getTheTemperatureChart()
        getTheHumChart()
        getTheSunChart()
    }
    
    // 温度
    func getTheTemperatureChart() {
        var temps = [Float]()
        Alamofire.request("http://115.159.1.222:5200/app/plant" + plantInstance.id + "data/tempHum/day/1").validate().responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value).arrayValue
                print(json)
                for each in json {
                    let temp = each["temperature"].floatValue
                    temps.append(temp)
                }
                self.temChart = Chart()
                let series = ChartSeries(temps)
                series.color = ChartColors.greenColor()
                self.temChart.add(series)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // 湿度
    func getTheHumChart() {
        var hums = [Float]()
        Alamofire.request("http://115.159.1.222:5200/app/plant" + plantInstance.id + "data/tempHum/day/1").validate().responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value).arrayValue
                print(json)
                for each in json {
                    let hum = each["humidity"].floatValue / 100
                    hums.append(hum)
                }
                self.humChart = Chart()
                let series = ChartSeries(hums)
                series.color = ChartColors.greenColor()
                self.humChart.add(series)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // 光照
    func getTheSunChart() {
        var illuminations = [Float]()
        Alamofire.request("http://115.159.1.222:5200/app/plant" + plantInstance.id + "data/illumination/day/1").validate().responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value).arrayValue
                print(json)
                for each in json {
                    let illumination = each["illumination"].floatValue
                    illuminations.append(illumination)
                }
                self.illuChart = Chart()
                let series = ChartSeries(illuminations)
                series.color = ChartColors.greenColor()
                self.illuChart.add(series)
                
            case .failure(let error):
                print(error)
            }
        }
    }

}
