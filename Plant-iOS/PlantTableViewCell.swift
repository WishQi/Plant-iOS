//
//  PlantTableViewCell.swift
//  Plant-iOS
//
//  Created by 李茂琦 on 26/11/2016.
//  Copyright © 2016 Li Maoqi. All rights reserved.
//

import UIKit

class PlantTableViewCell: UITableViewCell {
    
    @IBOutlet weak var plantCategImage: UIImageView!
    @IBOutlet weak var plantName: UILabel!
    @IBOutlet weak var illumination: UILabel!
    @IBOutlet weak var humidity: UILabel!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var sound: UILabel!
    
    var plantInstance = Plant()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setValueWithInstance() {
        plantName.text = plantInstance.name
        illumination.text = plantInstance.infoIllumination
        humidity.text = plantInstance.infoHumidity
        temperature.text = plantInstance.infoTemperature
        sound.text = plantInstance.infoSound
        setCateImage()
        
        //性别、心情 展示未完成
    }
    func setCateImage() {
        
    }
}
