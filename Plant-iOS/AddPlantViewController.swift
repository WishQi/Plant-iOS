//
//  AddPlantViewController.swift
//  Plant-iOS
//
//  Created by 李茂琦 on 26/11/2016.
//  Copyright © 2016 Li Maoqi. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class AddPlantViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    
    @IBOutlet weak var plantImage: UIImageView!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!

    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBAction func doneCreate(_ sender: AnyObject) {
        postPlantsInfo()
        self.navigationController?.popViewController(animated: true)
    }

    

    let url_requestForRuffId = "http://115.159.1.222:5200/app/ruffs/all"
    let url_requestForVarieties = "http://115.159.1.222:5200/app/varieties/all"
    let url_post = "http://115.159.1.222:5200/app/plants/plant"
    var ruffIdArray = [JSON]()
    var sexArray = ["male","female"]
    var varietiesArray = [JSON]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.dataSource = self
        pickerView.delegate = self
        
        // Do any additional setup after loading the view.
        
        request()
        
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return ruffIdArray.count
        case 1:
            return sexArray.count
        case 2:
            return varietiesArray.count
        default:
            return 0
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return ruffIdArray[row]["name"].string
        case 1:
            return sexArray[row]
        case 2:
            return varietiesArray[row]["name"].string
        default:
            return ""
        }
    }
    
    func requestForRuffId(){
        Alamofire.request(url_requestForRuffId, method: .get ).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(json)
                self.ruffIdArray = json["ruffs"].arrayValue
                self.pickerView.reloadComponent(0)
            case .failure(let error):
                print(error)
                showAlert()
            }
        }
    }
    
    func requestForVarieties(){
        Alamofire.request(url_requestForVarieties, method: .get ).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(json)
                self.varietiesArray = json["varieties"].arrayValue
                self.pickerView.reloadComponent(2)
            case .failure(let error):
                print(error)
                showAlert()
            }
        }
    }
    
    func request(){
        requestForRuffId()
        requestForVarieties()
    }
    
    func postPlantsInfo() {
        let ruffIdSelected = ruffIdArray[pickerView.selectedRow(inComponent: 0)]["name"]
        let sexSelected = sexArray[pickerView.selectedRow(inComponent: 1)]
        let varietySelected = varietiesArray[pickerView.selectedRow(inComponent: 2)]["_id"]
        
        let parameters: Parameters = [
            "varieties": "\(varietySelected)",
            "ruffName": "\(ruffIdSelected)",
            "sex": "\(sexSelected)",
            "img": "http://img5.imgtn.bdimg.com/it/u=3732793912,1940191151&fm=21&gp=0.jpg",
            "age": Double(ageTextField.text!)!,
            "name": "\(nameTextField.text!)"
            
        ]
        
        Alamofire.request(url_post, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(json)
             
            case .failure(let error):
                print(error)
                showAlert()
            }
        }

        
    }

}
