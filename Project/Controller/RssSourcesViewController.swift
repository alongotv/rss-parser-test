//
//  RssSourcesViewController.swift
//  rss-parser-test
//
//  Created by Vladimir Vetrov on 05/04/2019.
//  Copyright © 2019 Vladimir Vetrov. All rights reserved.
//

import UIKit
import CoreData


class RssSourcesViewController: UITableViewController {
    
    var sources = [RssSource]()
    let coreDataRepository = Persistence()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonClicked(sender:)))
        navigationItem.rightBarButtonItem = addButton
        self.sources = self.coreDataRepository.fetchSourcesFromCoreData()

        // Do any additional setup after loading the view.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sources.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RssFavouriteCell", for: indexPath)
        
        let source = sources[indexPath.row]
        cell.textLabel!.text = source.sourceName
        return cell
    }
    
    
    @objc func addButtonClicked(sender : AnyObject){
        let alertController = UIAlertController(title: "Add New Rss Source", message: "", preferredStyle: UIAlertController.Style.alert)
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter Resource Name"
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: {
            (action : UIAlertAction!) -> Void in })
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter Resource Rss Link"
        }
        
        let saveAction = UIAlertAction(title: "Save", style: UIAlertAction.Style.default, handler: { alert -> Void in
            let nameTextField = alertController.textFields![0] as UITextField
            let linkTextField = alertController.textFields![1] as UITextField
            
            if let urlSource = linkTextField.text {
                if !urlSource.isValidURL {
                    self.showAlert(with: "Provided URL is invalid.")
                    return
                }
            }
            
            self.coreDataRepository.saveSourceToCoreData(name: nameTextField.text ?? "", link: linkTextField.text ?? "")
            
            self.sources = self.coreDataRepository.fetchSourcesFromCoreData()
            
            self.tableView.beginUpdates()
            self.tableView.insertRows(at: [IndexPath.init(row: self.sources.count - 1, section: 0)], with: .bottom)
            self.tableView.endUpdates()

        })
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc
    func insertNewObject(_ sender: Any) {
        
        tableView.reloadData()
    }
    
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.coreDataRepository.removeObjectFromCoreData(source: sources[indexPath.row])
            sources.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
 
    func showAlert(with message:String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
