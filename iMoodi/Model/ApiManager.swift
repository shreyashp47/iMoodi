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
    func didUpdateAPIList(_ apimanager: ApiManager, photoListData: PhotoListModel)
    func didFailWithError(error: Error)
}
struct ApiManager {
    
    
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?&appid=6b615da85e89041952546345f8e70af5&units=metric"
    
   // let baseUrl = "https://api.unsplash.com/photos/?client_id=Dx_grdVGRp78LARMCayxgtrbgM8eoLMSA_SaJ0g0qbw"
       let baseUrl = "https://api.unsplash.com"
    
    let clientId = "Dx_grdVGRp78LARMCayxgtrbgM8eoLMSA_SaJ0g0qbw"
    
    var delegate: APIManagerDelegate?
    
    func fetchPhotoList(){
        let urlString = "\(baseUrl)/photos/?client_id=\(clientId)"
        performRequest(urlString: urlString)
    }
    
    func fetchWeather(cityName: String){
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(urlString: urlString)
    }
    
    func fetchWeatherWithLatLang(lat: CLLocationDegrees,lang: CLLocationDegrees){
        let urlString = "\(weatherURL)&lat=\(lat)&lon=\(lang)"
        performRequest(urlString: urlString)
    }
    
    func performPhotoListRequest(urlString: String){
        if  let url = URL(string: urlString){
            
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, respose, error) in
                if error != nil
                {    print(error!)
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    let dataString = String(data: safeData,encoding: .utf8)
                    print(dataString!)
                    if  let weather = self.parsePhotoListJSON(weatherData: safeData){
                        self.delegate?.didUpdateAPIList(self,photoListData: weather)
                    }
                    
                }
                
                
            }
            task.resume()
        }
        
    }
    
    func performRequest (urlString: String){
        if  let url = URL(string: urlString){
            
            let session = URLSession(configuration: .default)
            
            //let task1 = session.dataTask(with: url, completionHandler:   handle(data:response:error:)   )
            //task1.resume()
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
                    if  let weather = self.parseJSON(weatherData: safeData){
                        self.delegate?.didUpdateAPIList(self,photoListData: weather)
                    }
                    
                    
                }
            }
            task.resume()
        }}
    
    
    func parsePhotoListJSON(weatherData: Data) -> PhotoListModel? {
        let decoder = JSONDecoder()
        do{
            let decoderData = try decoder.decode(PhotoListData.self, from: weatherData)
            print(decoderData)
        }
        catch {
            print(error)
        }
        
        return nil
    }
    func parseJSON(weatherData: Data) -> PhotoListModel? {
        
        let decoder = JSONDecoder()
        do{
            let decoderData = try decoder.decode(PhotoListData.self, from: weatherData)
            print("TEMP" + String(decoderData.main.temp))
            let  id = decoderData.weather[0].id
            let  description = decoderData.weather[0].id
            let  name = decoderData.name
            let  temp = decoderData.main.temp
            
            
            
            let weather = PhotoListModel(conditionId: id, cityName: name, temperature: temp)
            
            //print(weather.conditionName)
            print(" temperatureString" + weather.temperatureString)
            return weather
            
        }catch {
            print(error)
            self.delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    
    //    func handle(data: Data?, response: URLResponse?, error: Error?)
    //    {
    //        if error != nil
    //        {    print(error!)
    //
    //            return
    //        }
    //        if let safeData = data {
    //            let dataString = String(data: safeData,encoding: .utf8)
    //            print(dataString!)
    //
    //        }
    //    }
}
