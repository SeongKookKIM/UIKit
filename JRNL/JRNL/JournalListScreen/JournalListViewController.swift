//
//  ViewController.swift
//  JRNL
//
//  Created by mac on 5/7/24.
//

import UIKit

class JournalListViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UISearchResultsUpdating {
    
    // MARK: - Properties
    @IBOutlet var collectionView: UICollectionView!
    
    // 검색
    let search = UISearchController(searchResultsController: nil)
    var filteredTableData: [JournalEntry] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SharedData.shared.loadJournalEntriesData()
        
        setupCollectionView()
        
        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Search titles"
        navigationItem.searchController = search

    }
    
    // 화면 로테이션
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    func setupCollectionView() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 10
        collectionView.collectionViewLayout = flowLayout
    }
    
    // MARK: - UITableViewDataSource
    // 실제 데이터는 엄청 많지만 테이블에게는 몇번쨰 인지 알려줘야함
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if search.isActive {
            return self.filteredTableData.count
        } else {
            return SharedData.shared.numberOfJournalEntries()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let journalCell = collectionView.dequeueReusableCell(withReuseIdentifier: "journalCell", for: indexPath) as! JournalListCollectionViewCell
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
    
    // MARK: - UICollectionViewDelegate
    private func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemsAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let config = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { (elements) -> UIMenu? in
            let delete = UIAction(title: "Delete") { [weak self] (action) in
                if let search = self?.search, search.isActive, let selectedJournalEntry = self?.filteredTableData[indexPath.item] {
                    self?.filteredTableData.remove(at: indexPath.item)
                    SharedData.shared.removeSeletedJournalEntry(selectedJournalEntry)
                } else {
                    SharedData.shared.removeJournalEntry(index: indexPath.item)
                }
                SharedData.shared.saveJournalEntriesData()
                collectionView.reloadData()
            }
            return UIMenu(title: "", image: nil, identifier: nil, options: [], children: [delete])
        }
        return config
    }
    
    // MARK: -UICollectionDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var coloumns: CGFloat
        if (traitCollection.horizontalSizeClass == .compact) {
            coloumns = 1
        } else {
            coloumns = 2
        }
        let viewWidth = collectionView.frame.width
        let inset = 10.0
        let contentWidth = viewWidth - inset * (coloumns + 1)
        let cellWidth = contentWidth / coloumns
        let cellHeigth: CGFloat = 90
        
        return CGSize(width: cellWidth, height: cellHeigth)
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
        
        self.collectionView.reloadData()
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
            collectionView.reloadData()
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
              let selectedJournalEntryCell = sender as? JournalListCollectionViewCell,
              let indexPath = collectionView.indexPath(for: selectedJournalEntryCell) else {
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

