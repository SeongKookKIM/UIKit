//
//  ViewController.swift
//  JRNL
//
//  Created by mac on 5/7/24.
//

import UIKit

class JournalListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating {
    
    
    
    // MARK: - Properties
    
    @IBOutlet var tableView: UITableView!
    
    // 검색
    let search = UISearchController(searchResultsController: nil)
    var filteredTableData: [JournalEntry] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SharedData.shared.loadJournalEntriesData()
        
        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Search titles"
        navigationItem.searchController = search
    }
    
    // MARK: - UITableViewDataSource
    
    // 실제 데이터는 엄청 많지만 테이블에게는 몇번쨰 인지 알려줘야함
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if search.isActive {
            return self.filteredTableData.count
        } else {
            return SharedData.shared.numberOfJournalEntries()
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let journalCell = tableView.dequeueReusableCell(withIdentifier: "journalCell", for: indexPath) as! JournalListTableViewCell
        let journalEntry: JournalEntry
        if self.search.isActive {
            journalEntry = filteredTableData[indexPath.row]
        } else {
            journalEntry = SharedData.shared.getJournalEntry(index: indexPath.row)
        }

        // 디코딩
        if let photoData = journalEntry.photoData {
            journalCell.photoImageView.image = UIImage(data: photoData)
        }
        
        journalCell.dateLabel.text = journalEntry.dateString
        journalCell.titleLabel.text = journalEntry.entryTitle
        return journalCell
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            SharedData.shared.removeJournalEntry(index: indexPath.row)
            SharedData.shared.saveJournalEntriesData()
            tableView.reloadData()
        }
    }
    
    // MARK: - UISearchResultUpdating
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchBarText = searchController.searchBar.text else {
            return
        }
        filteredTableData.removeAll()
//        for journalEntry in SharedData.shared.getAllJournalEntries() {
//            if journalEntry.entryTitle.lowercased().contains(searchBarText.lowercased()) {
//                filteredTableData.append(journalEntry)
//            }
//        }
        
        filteredTableData = SharedData.shared.getAllJournalEntries().filter {
            $0.entryTitle.lowercased().contains(searchBarText.lowercased())
        }
        
        self.tableView.reloadData()
    }
    
    // MARK: - Methods
    // cancle action
    @IBAction func unwindNewEntryCancle(segue: UIStoryboardSegue) {
        
    }
    
    // Save action
    @IBAction func unwindNewEntrySave(segue: UIStoryboardSegue) {
        if let sourceViewController = segue.source as? AddJournalEntryViewController,
           let newJournalEntry = sourceViewController.newJournalEntry {
            SharedData.shared.addJournalEntry(newJournalEntry: newJournalEntry)
            SharedData.shared.saveJournalEntriesData()
            tableView.reloadData()
        }
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "entryDetail" else {
            return
        }
        
        guard let journalEntryDetailViewController = segue.destination as? JournalEntryDetailViewController,
              let selectedJournalEntryCell = sender as? JournalListTableViewCell,
              let indexPath = tableView.indexPath(for: selectedJournalEntryCell) else {
            fatalError("Could not get indexPath")
        }
        let selectedJournalEntry: JournalEntry
        if self.search.isActive {
            selectedJournalEntry = filteredTableData[indexPath.row]
        } else {
            selectedJournalEntry = SharedData.shared.getJournalEntry(index: indexPath.row)
        }
        journalEntryDetailViewController.selectedJournalEntry = selectedJournalEntry
    }
    
    
}

