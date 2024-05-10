import UIKit
import PlaygroundSupport //UIKit을 플레이그라운드에서 확인 가능하게함

class TableViewExampleController: UIViewController {
    var tableView: UITableView?
    var journalEntries: [[String]] = [
        ["sun.max", "9 Apr 2023", "Nice weather today"],
        ["cloud.rain", "10 Apr 2023", "Heavy rain today"],
        ["cloud.sun", "11 APr 2023", "It's cloudy out"]
    ]
}
