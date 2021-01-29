//
//  ViewController.swift
//  SmartBP
//
//  Created by Sarayu Dandamudi on 9/13/20.
//  Copyright © 2020 Sarayu Dandamudi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var table: UITableView!
    
    var models = [MyReminder]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
    }
    
    @IBAction func didTapAdd() {
        //show add vc
        
        guard let vc = storyboard?.instantiateViewController(identifier: "add") as? AddViewController else {
            return
        }
        vc.title = "New Reminder"
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.completion = { title, body, date in
            DispatchQueue.main.async {
                self.navigationController?.popToRootViewController(animated: true)
                let new = MyReminder(title: title, date: date, identifier: "id_\(title)")
                self.models.append(new)
                self.table.reloadData()
                
            }
            
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
}


extension ViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        }
}


extension ViewController: UITableViewDataSource {
        
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = models[indexPath.row].title
        let date = models[indexPath.row].date
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM, dd, YYYY at hh:mm a"
        cell.detailTextLabel?.text = formatter.string(from: date)
        return cell
        }
}


struct MyReminder {
    let title: String
    let date: Date
    let identifier: String
}
