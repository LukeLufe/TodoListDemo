//
//  UnFinishTableViewController.swift
//  TodoListDemo
//
//  Created by Luke on 2022/3/29.
//

import UIKit

class UnFinishTableViewController: UITableViewController {
    
    var unFinishData = [Work]()
    weak var delegate: MainViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.keyboardDismissMode = .onDrag
    }
    
    func updateUI() {
        tableView.reloadData()
        if !unFinishData.isEmpty {
            let indexPath = IndexPath(row: unFinishData.count - 1, section: 0)
            tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }

    // MARK: - Table view data source
    
    private let cellId = "customCell"

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return unFinishData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        guard let cell = cell as? UnFinishTableViewCell else {
            print("As UnFinishTableViewCell Error")
            return cell
        }
        cell.delegate = self
        cell.removeBtn.tag = indexPath.row
        cell.finishBtn.tag = indexPath.row
        cell.titleLabel.text = unFinishData[indexPath.row].text
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

extension UnFinishTableViewController: UnFinishTableViewCellDelegate {
    
    func removeBtnPressed(_ sender: UIButton) {
        let index = sender.tag
        let workText = unFinishData[index].text
        presentAlert(title: "提示", message: "是否要移除: \(workText)", isDestructive: true) {
            let work = self.unFinishData[index]
            let manager = WorkManager()
            manager.deleteWork(work) { [weak self] error in
                if let error = error {
                    print("deleteWork \(error)")
                    return
                }
                self?.unFinishData.remove(at: index)
                self?.updateUI()
            }
        }
    }
    
    func finishBtnPressed(_ sender: UIButton) {
        let index = sender.tag
        let workText = unFinishData[index].text
        presentAlert(title: "提示", message: "是否要完成: \(workText)", isDestructive: false) {
            let work = self.unFinishData[index]
            let manager = WorkManager()
            manager.updateWork(work) { [weak self] resultWork, error in
                guard let resultWork = resultWork, error == nil else {
                    print("updateWork \(String(describing: error))")
                    return
                }
                self?.unFinishData.remove(at: index)
                self?.updateUI()
                self?.delegate?.finishWork(resultWork)
            }
        }
    }
    
    private func presentAlert(title: String?, message: String?, isDestructive: Bool, handler: @escaping () -> ()) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "取消", style: .cancel)
        alert.addAction(cancel)
        let okStr = isDestructive ? "移除" : "確定"
        let okStyle: UIAlertAction.Style = isDestructive ? .destructive : .default
        let ok = UIAlertAction(title: okStr, style: okStyle) { _ in
            handler()
        }
        alert.addAction(ok)
        present(alert, animated: true)
    }

}
