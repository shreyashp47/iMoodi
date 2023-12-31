//
//  ViewController.swift
//  iMoodi
//
//  Created by Shreyash Pattewar on 25/12/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    var apiManager = ApiManager()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var profileImageVIew: UIImageView!
    var feeds : [PhotoListData] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        apiManager.delegate = self
        apiManager.fetchPhotoList()
        tableView.dataSource = self
    
        tableView.register(UINib(nibName: Constants.messageSellNibName, bundle: nil), forCellReuseIdentifier: Constants.cellIdentifier)
        
    
    }


}

extension HomeViewController: APIManagerDelegate {
    
    func didUpdateAPIList(_ apimanager: ApiManager, photoListData: [PhotoListData]) {
        print("didUpdateAPIList")
        if !photoListData.isEmpty {
            print(photoListData[0].id!)
            for feed in photoListData {
                feeds.append(feed)
            }
            DispatchQueue.main.async{
                self.tableView.reloadData()
            }
        }
    }
    
  
    
    func didFailWithError(error: Error) {
        print("didFailWithError")
    }
    
    
    
}

extension HomeViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("count = \(feeds.count)")
       return feeds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath)
        as! MessageCell
        //cell.feedUserName?.text = feeds[indexPath.row].user?.username
        cell.label?.text = feeds[indexPath.row].description
        if let urlString = feeds[indexPath.row].urls?.raw,
           let url = URL(string: urlString) {
            cell.imageView?.setImage(url: url, placeholder: UIImage.brandLogo)
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // Return the desired height for your cells
        return 220 // Adjust this value to increase or decrease the cell height as needed
    }

    
    
}

extension UIImageView {
    func setImage(url: URL, placeholder: UIImage?) {
        self.image = placeholder

        Task { [weak self] in
            let (data, _) = try await URLSession.shared.data(from: url)
            self?.image = UIImage(data: data)
        }
    }
}
