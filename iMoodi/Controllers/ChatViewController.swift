//
//  ChatViewController.swift
//  iMoodi
//
//  Created by Shreyash Pattewar on 29/12/23.
//

import UIKit

class ChatViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var apiManager = ApiManager()

    var feeds : [PhotoListData] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        apiManager.delegate = self
        //apiManager.fetchPhotoList()
        
        feeds.append(PhotoListData(id: "131", description: "sdcdj  sdcdjsdcd sdcdjsdcd sdcdjsdcd sdcd  sdcdjsdcd  sdcdjsdcd  sdcdjsdcd jsdcdj", urls: nil, user: nil))
        feeds.append(PhotoListData(id: "131", description: "sdcdj  sdcdjsdcd sdcdjsdcd sdcdjsdcd sdcd  sdcdjsdcd  sdcdjsdcd  sdcdjsdcd jsdcdj", urls: nil, user: nil))
        feeds.append(PhotoListData(id: "131", description: "sdcdj  sdcdjsdcd sdcdjsdcd sdcdjsdcd sdcd  sdcdjsdcd  sdcdjsdcd  sdcdjsdcd jsdcdj", urls: nil, user: nil))
        feeds.append(PhotoListData(id: "131", description: "sdcdj  sdcdjsdcd sdcdjsdcd sdcdjsdcd sdcd  sdcdjsdcd  sdcdjsdcd  sdcdjsdcd jsdcdj", urls: nil, user: nil))
        feeds.append(PhotoListData(id: "131", description: "sdcdj  sdcdjsdcd sdcdjsdcd sdcdjsdcd sdcd  sdcdjsdcd  sdcdjsdcd  sdcdjsdcd jsdcdj", urls: nil, user: nil))
        feeds.append(PhotoListData(id: "1e31", description: "sdcdj", urls: nil, user: nil))
        
        tableView.dataSource = self
    
        
        tableView.register(UINib(nibName: Constants.messageSellNibName, bundle: nil), forCellReuseIdentifier: Constants.cellIdentifier)
        
    
    }


}

extension ChatViewController: APIManagerDelegate {
    
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

extension ChatViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("count = \(feeds.count)")
       return feeds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath)
        as! MessageCell
        //cell.feedUserName?.text = feeds[indexPath.row].user?.username
        //cell.label?.text = feeds[indexPath.row].description
        
        
        return cell
    }
    
    
}
