//
//  MainTableViewController.swift
//  Piita
//
//  Created by 中嶋裕也 on 2018/11/21.
//  Copyright © 2018 中嶋裕也. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class MainTableViewController: UITableViewController, UISearchBarDelegate{
    
    var json:JSON = []
    var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar = UISearchBar()
        searchBar.placeholder = "検索キーワードを入力してください"
        searchBar.delegate = self
        searchBar.barTintColor = UIColor(red: 0.439, green: 0.30, blue: 0.58, alpha: 1)
        
        self.tableView.refreshControl = UIRefreshControl()
        self.tableView.refreshControl?.addTarget(self, action: #selector(self.refresh), for: UIControl.Event.valueChanged)
        self.tableView.separatorColor = UIColor.purple
        self.tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0);
        
        getdata()
    }
    
    
    func getdata(){
        
        var appendURL:String! = ""
        if searchBar.text != ""{
            appendURL = "?query=" + searchBar.text!
        }
        
        Alamofire.request("https://qiita.com/api/v2/items" + appendURL)
            .responseJSON{ response in
                guard let object = response.result.value else {
                    print("load faild")
                    return
                }
                
                self.json = JSON(object)
                self.tableView.reloadData()
                self.tableView.refreshControl?.endRefreshing()
        }
    }
    
    
    // MARK: - Refresh
    @objc func refresh(){
        getdata()
    }


    // MARK: - Table view
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.json.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        
        cell.titleLabel.text = self.json[indexPath.row]["title"].description
        cell.autherLabel.text = "@" + self.json[indexPath.row]["user"]["id"].description
        
        var image = UIImage(named: "icon.png")
        cell.iconImageView.image = image
        
        let dispatchGroup = DispatchGroup()
        let dispatchQueue = DispatchQueue(label: "queue", attributes: .concurrent)
        
        dispatchGroup.enter()
        dispatchQueue.async(group: dispatchGroup){
            let url = URL(string: self.json[indexPath.row]["user"]["profile_image_url"].description)!
            if let imageData = try? Data(contentsOf: url) {
                image = UIImage(data:imageData)
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main){
            cell.iconImageView.image = image
        }
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "ToWebView", sender: self.json[indexPath.row]["url"].description)
    }
    

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return searchBar
    }
    
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    
    
    
    // MARK: - SearchBar
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        searchBar.showsCancelButton = false
        getdata()
    }
    
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
        searchBar.showsCancelButton = false
        searchBar.text = ""
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToWebView"{
            let nextViewController = segue.destination as! WebViewController
            nextViewController.myURL = URL(string: sender as! String)
        }
    }
    
    
}
