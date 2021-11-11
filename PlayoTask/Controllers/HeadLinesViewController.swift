//
//  HeadLinesViewController.swift
//  PlayoTask
//
//  Created by pampana ajay on 11/11/21.
//

import UIKit
import Alamofire

class HeadLinesViewController: UIViewController {
    
    let refreshControl = UIRefreshControl()
    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var spinner:UIActivityIndicatorView!
    
    var headLinesData:HeadLinesModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        spinner.startAnimating()
        spinner.hidesWhenStopped = true
        setupUI()
        getHeadLinesData()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
           refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
           tableView.addSubview(refreshControl)
        
    }
    
    @objc func refresh(_ sender: AnyObject) {
        tableView.reloadData()
        self.refreshControl.endRefreshing()
    }
    
    func setupUI(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "HeadlinesTableViewCell", bundle: nil), forCellReuseIdentifier: "HeadlinesTableViewCell")
    }
    
}

extension HeadLinesViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier:"HeadLinesWebViewViewController") as? HeadLinesWebViewViewController{
            
            if let headLinesData = headLinesData{
                vc.webUrl = headLinesData.articles?[indexPath.row].url ?? ""
                
            }
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
}


extension HeadLinesViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let headLinesData = headLinesData{
            return headLinesData.articles?.count ?? 0
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "HeadlinesTableViewCell", for: indexPath) as? HeadlinesTableViewCell{
            
            if let headLinesData = headLinesData{
                cell.configUI(strImage: headLinesData.articles?[indexPath.row].urlToImage ?? "", lblAuthor: headLinesData.articles?[indexPath.row].author ?? "", lblTitle: headLinesData.articles?[indexPath.row].title ?? "", lblDescription: headLinesData.articles?[indexPath.row].articleDescription ?? "")
                
            }
            
            return cell
        }
        return UITableViewCell()
    }
}

extension HeadLinesViewController{
    
    func getHeadLinesData(){
        
        var parameters : [String:String] = [:]
        parameters["sources"] = "techcrunch"
        parameters["apiKey"] = "fa64bc00194e4c95835095a7be792b11"
        
        NetworkAdaptor.request(url: "https://newsapi.org/v2/top-headlines", method: .get, headers:  nil, urlParameters: parameters, encoding: JSONEncoding.default) { data, response, error in
            
            if let error = error{
                print(error.localizedDescription)
            }
            
            else if let data = data {
                do {
                    
                    let decodedData = try JSONDecoder().decode(HeadLinesModel.self, from: data)
                    self.headLinesData = decodedData
                    self.spinner.stopAnimating()
                    self.tableView.reloadData()
                }catch {
                    print(error.localizedDescription)
                }
                
            }
        }
        
        
    }

}

