//
//  ViewController.swift
//  JRNL
//
//  Created by mac on 5/7/24.
//

import UIKit

class JournalListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Properties
    
    @IBOutlet var tableView: UITableView!
    var sampleJournalEntryData = SampleJournalEntryData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        sampleJournalEntryData.createSampleJournalEntryData()
    }
    
    // MARK: - UITableViewDataSource
    
    // 실제 데이터는 엄청 많지만 테이블에게는 몇번쨰 인지 알려줘야함
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sampleJournalEntryData.journalEntries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let journalCell = tableView.dequeueReusableCell(withIdentifier: "journalCell", for: indexPath) as! JournalListTableViewCell
        let journalEntry = sampleJournalEntryData.journalEntries[indexPath.row]
        journalCell.photoImageView.image = journalEntry.photo
        journalCell.dateLabel.text = journalEntry.date.formatted(.dateTime.month().day().year())
        journalCell.titleLabel.text = journalEntry.entryTitle
        return journalCell
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            sampleJournalEntryData.journalEntries.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
    
    // MARK: - Methods
    
    // cancle action
    @IBAction func unwindNewEntryCancle(segue: UIStoryboardSegue) {
        
    }
    
    // Save action
    @IBAction func unwindNewEntrySave(segue: UIStoryboardSegue) {
        if let sourceViewController = segue.source as? AddJournalEntryViewController,
           let newJournalEntry = sourceViewController.newJournalEntry {
            sampleJournalEntryData.journalEntries.append(newJournalEntry)
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
        let selectedJournalEntry = sampleJournalEntryData.journalEntries[indexPath.row]
        journalEntryDetailViewController.selectedJournalEntry = selectedJournalEntry
    }
    
    
}

