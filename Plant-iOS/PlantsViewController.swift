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
    
    // TableView DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return plants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "plantCell", for: indexPath) as? PlantTableViewCell {
            
            cell.plantInstance = plants[indexPath.row]
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

