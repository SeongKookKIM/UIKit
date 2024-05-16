//
//  JournalDetailViewController.swift
//  JRNL-Codeonly
//
//  Created by mac on 5/13/24.
//

import UIKit
import MapKit

class CustomTableViewCell: UITableViewCell {
    var stackView: UIStackView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.backgroundColor = .systemCyan
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stackView.widthAnchor.constraint(equalToConstant: 252),
            stackView.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}

class JournalDetailViewController: UITableViewController {
    
    let journalEntry: JournalEntry
    
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "Label"
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var bodyTextView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.isSelectable = false
        textView.backgroundColor = .systemBackground
        textView.textColor = .label
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        return textView
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "face.smiling")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var mapView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "map.smiling")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    
    
    init(journalEntry: JournalEntry) {
        self.journalEntry = journalEntry
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "customCell")
        navigationItem.title = "Journal Detail"
        
        getMapSnapshot()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 7
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.contentView.addSubview(dateLabel)
            dateLabel.text = journalEntry.dateString
            
            let marginGuide = cell.contentView.layoutMarginsGuide
            NSLayoutConstraint.activate([
                dateLabel.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor),
                dateLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor),
                dateLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor)
            ])
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomTableViewCell
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.contentView.addSubview(titleLabel)
            titleLabel.text = journalEntry.entryTitle
            
            let marginGuide = cell.contentView.layoutMarginsGuide
            NSLayoutConstraint.activate([
                titleLabel.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor),
                titleLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor),
                titleLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor)
            ])
            return cell
            
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.contentView.addSubview(bodyTextView)
            bodyTextView.text = journalEntry.entryBody
            
            let marginGuide = cell.contentView.layoutMarginsGuide
            NSLayoutConstraint.activate([
                bodyTextView.topAnchor.constraint(equalTo: marginGuide.topAnchor ),
                bodyTextView.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor),
                bodyTextView.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor),
                bodyTextView.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor)
            ])
            return cell
            
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.contentView.addSubview(imageView)
            imageView.image = journalEntry.photo
            
            NSLayoutConstraint.activate([
                imageView.centerXAnchor.constraint(equalTo: cell.contentView.centerXAnchor),
                imageView.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor),
                imageView.widthAnchor.constraint(equalToConstant: 300),
                imageView.heightAnchor.constraint(equalToConstant: 300)
            ])
            return cell
            
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.contentView.addSubview(mapView)
            mapView.image = UIImage(systemName: "map")
            
            NSLayoutConstraint.activate([
                mapView.centerXAnchor.constraint(equalTo: cell.contentView.centerXAnchor),
                mapView.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor),
                mapView.widthAnchor.constraint(equalToConstant: 300),
                mapView.heightAnchor.constraint(equalToConstant: 300)
            ])
            return cell
            
        default:
            return tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.row {
        case 1: return 60
        case 3: return 150
        case 4: return 316
        case 5: return 316
        default: return 44.5
        }
    }
    
    // MARK: - Methods
    private func getMapSnapshot() {
        if let lat = journalEntry.latitude,
           let long = journalEntry.longitude {
            let options = MKMapSnapshotter.Options()
            options.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: lat, longitude: long), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            options.size = CGSize(width: 300, height: 300)
            options.preferredConfiguration = MKStandardMapConfiguration()
            let snapShotter = MKMapSnapshotter(options: options)
            snapShotter.start { snapShot, error in
                if let snapshot = snapShot {
                    self.mapView.image = snapshot.image
                } else if let error = error {
                    print("snapShot error: \(error.localizedDescription)")
                }
            }
        } else {
            self.mapView.image = UIImage(systemName: "map")
        }
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
