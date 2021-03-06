//
//  FeedTableVC.swift
//  User Interface iOS
//
//  Created by Pavel Otverchenko on 24.06.2021.
//

import UIKit

class NewsTableVC: UITableViewController {
    
    //MARK: - Variables
    
    private var newsList = ["news1", "news2", "news3", "news4", "news5", "news6", "news7", "news8"]
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(NewsCell.self, forCellReuseIdentifier: NewsCell.identifier)
        self.tableView.dataSource   = self
        self.tableView.delegate     = self
        self.tableView.rowHeight    = UIScreen.main.bounds.height * 0.5
    }
}

    //MARK: - Extensions
extension NewsTableVC {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return newsList.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.identifier, for: indexPath) as! NewsCell

        cell.configure(with: UIImage(named: newsList[indexPath.section])!)
        
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.black.cgColor
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let emptyHeader = UIView()
        emptyHeader.backgroundColor = .clear
        return emptyHeader
    } 
}
