//
//  FinishTableViewController.swift
//  TodoListDemo
//
//  Created by Luke on 2022/3/29.
//

import UIKit

class FinishTableViewController: UITableViewController {
    
    var finishData = [Work]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.keyboardDismissMode = .onDrag
    }
    
    func updateUI() {
        tableView.reloadData()
        if !finishData.isEmpty {
            let indexPath = IndexPath(row: finishData.count - 1, section: 0)
            tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
    
    // MARK: - Table view data source
    
    private let cellId = "defaultCell"

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return finishData.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let work = finishData[indexPath.row]
        cell.textLabel?.text = work.text
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        cell.detailTextLabel?.text = work.date.formatOfOneDay()
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
