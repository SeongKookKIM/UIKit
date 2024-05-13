//
//  ViewController.swift
//  JRNL-Codeonly
//
//  Created by mac on 5/13/24.
//

import UIKit

class JournalListViewController: UIViewController {
        
    // tableView 초기화
    lazy var tableView: UITableView = {
       let tableView = UITableView()
        return tableView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.backgroundColor = .white
        
        let global = view.safeAreaLayoutGuide
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: global.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: global.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: global.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: global.leadingAnchor)
        ])

    }


}

