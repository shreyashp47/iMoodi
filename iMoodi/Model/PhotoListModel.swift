//
//  PhotoListModel.swift
//  iMoodi
//
//  Created by Shreyash Pattewar on 30/12/23.
//

import Foundation

struct PhotoListModel {
    
    let conditionId: Int
    let cityName : String
    let temperature: Double
    
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
    
    
}
