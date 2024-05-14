//
//  ViewController.swift
//  JRNL-Codeonly
//
//  Created by mac on 5/13/24.
//

import UIKit

class JournalListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, AddJournalControllerDelegate {
    
    
    
    
    // tableView 초기화
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    var sampleJournalEntryData = SampleJournalEntryData()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sampleJournalEntryData.createSampleJournalEntryData()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(JournalListTableViewCell.self, forCellReuseIdentifier: "journalCell")
        
        view.backgroundColor = .white
        
        let safeArea = view.safeAreaLayoutGuide
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor)
        ])
        
        // 오른쪽 상단 아이템
        navigationItem.title = "Journal"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add, target: self, action: #selector(addJournal)
        )
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sampleJournalEntryData.journalEntries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "journalCell", for: indexPath) as! JournalListTableViewCell
        let journalEntry = sampleJournalEntryData.journalEntries[indexPath.row]
        cell.configureCell(journalEntry: journalEntry)
        return cell
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let journalEntries = sampleJournalEntryData.journalEntries[indexPath.row]
        
        let journalDetailViewController = JournalDetailViewController(journalEntry: journalEntries)
        show(journalDetailViewController, sender: self)
        print("Click")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        90
    }
    
    
    // MARK: - Methods
    @objc private func addJournal() {
        let addJournalViewController = AddJournalViewController()
        let navigationController = UINavigationController(rootViewController: addJournalViewController)
        
        addJournalViewController.delegate = self
        
        // popover
        present(navigationController, animated: true)
    }
    
    public func saveJournalEntry(_ journalEntry: JournalEntry) {
        print("TEST \(journalEntry.entryTitle)")
        sampleJournalEntryData.journalEntries.append(journalEntry)
        tableView.reloadData()
    }
    
}

