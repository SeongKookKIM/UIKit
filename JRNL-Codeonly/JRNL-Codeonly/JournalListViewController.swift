//
//  ViewController.swift
//  JRNL-Codeonly
//
//  Created by mac on 5/13/24.
//

import UIKit

class JournalListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    

    
        
    // tableView 초기화
    lazy var tableView: UITableView = {
       let tableView = UITableView()
        return tableView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "journalCell")
        
        view.backgroundColor = .white
        
        let global = view.safeAreaLayoutGuide
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: global.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: global.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: global.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: global.leadingAnchor)
        ])

        // 오른쪽 상단 아이템
        navigationItem.title = "Journal"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
                barButtonSystemItem: .add, target: self, action: #selector(addJournal)
            )
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueReusableCell(withIdentifier: "journalCell", for: indexPath)
    }
    
    
    // MARK: - Methods
    @objc private func addJournal() {
        let addJournalViewController = AddJournalViewController()
        let navigationController = UINavigationController(rootViewController: addJournalViewController)
        
        // popover
        present(navigationController, animated: true)
    }

}

