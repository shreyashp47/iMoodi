//
//  ViewController.swift
//  iMoodi
//
//  Created by Shreyash Pattewar on 25/12/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    var apiManager = ApiManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        apiManager.delegate = self
        apiManager.fetchPhotoList()
      
    }


}

extension HomeViewController: APIManagerDelegate {
    
    func didUpdateAPIList(_ apimanager: ApiManager, photoListData: [PhotoListData]) {
        print("didUpdateAPIList")
        if !photoListData.isEmpty {
            print(photoListData[0].id!)
        }
    }
    
  
    
    func didFailWithError(error: Error) {
        print("didFailWithError")
    }
    
    
    
}

