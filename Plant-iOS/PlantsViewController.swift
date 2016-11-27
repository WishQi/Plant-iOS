//
//  ViewController.swift
//  Plant-iOS
//
//  Created by 李茂琦 on 26/11/2016.
//  Copyright © 2016 Li Maoqi. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class PlantsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let url_requestForPlantsList = "http://115.159.1.222:5200/app/plants/all/1"
    // TableView
    @IBOutlet weak var plantsTableView: UITableView!
    
    // Plant Model
    var plants = [Plant]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        plantsTableView.delegate = self
        plantsTableView.dataSource = self
        
        requestForPlantsList()
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        requestForPlantsList()
    }
    
    // TableView DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return plants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "plantCell", for: indexPath) as? PlantTableViewCell {
            
            cell.plantInstance = plants[indexPath.row]
                        let url = "http://115.159.1.222:5200/app/plants/plant/" + cell.plantInstance.id
            Alamofire.request(url, method: .get ).validate().responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    print(url)
                    print(String(describing:json["params"].arrayValue[0]))
                    
                    cell.plantInstance.infoIllumination = String(describing:json["params"].arrayValue[0])
                    cell.illumination.text = String(describing:json["params"].arrayValue[0])
                    cell.plantInstance.infoTemperature = String(describing:json["params"].arrayValue[1].arrayValue[0])
                    cell.temperature.text = String(describing:json["params"].arrayValue[1].arrayValue[0])
                    
                    cell.plantInstance.infoHumidity = String(describing:json["params"].arrayValue[1].arrayValue[1])
                    cell.humidity.text = String(describing:json["params"].arrayValue[1].arrayValue[1])

                    cell.plantInstance.infoSound = String(describing:json["params"].arrayValue[2])
                    cell.sound.text = String(describing:json["params"].arrayValue[2])
                    
                    
                    
                case .failure(let error):
                    print(error)
                    showAlert()
                }
            }
            cell.setValueWithInstance()
            

            
            return cell
        } else {
            return UITableViewCell()
        }
    }
    

    func requestForPlantsList() {
        Alamofire.request(url_requestForPlantsList, method: .get ).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                print(json["plants"])
                
                
                let jsonPlantArray = json["plants"].arrayValue
                
                self.plants = self.initPlantArray(jsonPlantArray)
                
                self.plantsTableView.reloadData()
                
            case .failure(let error):
                print(error)
                showAlert()
            }
        }
    }
    
    func initPlantArray(_ json:[JSON]) -> [Plant] {
        var array = [Plant]()
        
        for i in 0..<json.count{
            array.append(Plant.init(json: json[i]))
        }
        
        return array
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPlantInfo" {
            if let plantInfoVC = segue.destination as? PlantInfoViewController {
                if let cell = sender as? PlantTableViewCell {
                    plantInfoVC.plantInstance = cell.plantInstance
                    
                }
            }
        }
    }

}

public func showAlert(){
    let alert: UIAlertView = UIAlertView(title: "Networking goes error ", message: "Please check your Network.", delegate: nil, cancelButtonTitle: "OK")
    alert.show()
}

