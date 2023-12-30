//
//  WeatherManager.swift
//  Clima
//
//  Created by Shreyash Pattewar on 23/12/23.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

protocol APIManagerDelegate{
    func didUpdateAPIList(_ apimanager: ApiManager, photoListData: [PhotoListData])
    func didFailWithError(error: Error)
}
struct ApiManager {
    
    

   // let baseUrl = "https://api.unsplash.com/photos/?client_id=Dx_grdVGRp78LARMCayxgtrbgM8eoLMSA_SaJ0g0qbw"
       let baseUrl = "https://api.unsplash.com"
    let clientId2 = "trbgM8eoLMSA_SaJ0g0qbw"
    
    let clientId1 = "Dx_grdVGRp78LARMCayxg"
    //let clientId = "\(clientId1+clientId2)"
    
    var delegate: APIManagerDelegate?
    
    func fetchPhotoList(){
        let urlString = "\(baseUrl)/photos/?client_id=\(clientId1)\(clientId2)"
        performPhotoListRequest(urlString: urlString)
    }

    func performPhotoListRequest(urlString: String){
        if  let url = URL(string: urlString){
            
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, respose, error) in
                if error != nil
                {   
                    print(error!)
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    let dataString = String(data: safeData,encoding: .utf8)
                    print(dataString!)
                    if  let list = self.parsePhotoListJSON(photoData: safeData){
                        self.delegate?.didUpdateAPIList(self,photoListData: list)
                    }
                
                }
                
            }
            task.resume()
        }
        
    }

    func parsePhotoListJSON(photoData: Data) -> [PhotoListData]? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode([PhotoListData].self, from: photoData)
            return decodedData
        } catch {
            print(error)
            return nil
        }
    }

    
    
}
