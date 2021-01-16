//
//  ViewController.swift
//  Tasks
//
//  Created by Ciprian Cucu-Ciuhan on 16.01.2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var tasks = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Tasks"
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //setup
        //aici facem default pentru cand aplicatia porneste si nu avem nimic in ea
        if !UserDefaults().bool(forKey: "setup"){
            
            UserDefaults().set(true, forKey: "setup")
            UserDefaults().set(0, forKey: "count")
            
        }
        
        //get all current saved tasks
        updateTasks()
        
    }
    
    func updateTasks(){
        
        tasks.removeAll()
        
        guard let count = UserDefaults().value(forKey: "count") as? Int else {
            return
        }
        
        for x in 0..<count {
            
            if let task = UserDefaults().value(forKey: "tast_\(x+1)") as? String{
                tasks.append(task)
            }
            
        }
        
        tableView.reloadData()
        
    }
    
    @IBAction func didTapAdd() {
        
        let vc = storyboard?.instantiateViewController(identifier: "entry") as! EntryViewController
        vc.title = "New Task"
        vc.update = {
            DispatchQueue.main.async {
                self.updateTasks()//we want to make sure that we prioritize updating the tasks
            }
        }
        navigationController?.pushViewController(vc, animated: true)
        
    }


}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { //functia asta handle-uieste cand utilizatorul apasa pe o celula
        tableView.deselectRow(at: indexPath, animated: true)//deselecteaza (se duce culoarea de la apasare)
        
        let vc = storyboard?.instantiateViewController(identifier: "task") as! TaskViewController
        vc.title = "New Task"
        vc.task = tasks[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {//return the number of things in the task array
        return tasks.count
    }
    
    //return the cell for the given row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = tasks[indexPath.row]
        
        return cell
    }
    
}

