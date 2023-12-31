//
//  PhotoListModel.swift
//  iMoodi
//
//  Created by Shreyash Pattewar on 30/12/23.
//

import Foundation


struct PhotoListData: Codable {
    
    let id: String?
    let description: String?
    let urls: URLs?
    let user: Users?
}

struct URLs: Codable{
    let raw: String
    let small: String
}
struct Users: Codable{
    let username: String
    let id: String
}
