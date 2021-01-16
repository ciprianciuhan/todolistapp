//
//  EntryViewController.swift
//  Tasks
//
//  Created by Ciprian Cucu-Ciuhan on 16.01.2021.
//

import UIKit

class EntryViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var field: UITextField!
    
    var update: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        field.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveTask))
        //prin selector referentiem functia atunci cand butonul este apasat

        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        saveTask()
        return true
    }
    
    @objc func saveTask(){
        
        guard let text = field.text, !text.isEmpty else {
            
            return
            
        }
        
        guard let count = UserDefaults().value(forKey: "count") as? Int else {
            return
        }
        
        
        
        let newCount = count + 1
        
        UserDefaults().set(newCount, forKey: "count")
        
        UserDefaults().set(text, forKey: "tast_\(newCount)")
        
        update?()//if this update function exists we will call
        
        navigationController?.popViewController(animated: true) //we will dismiss this view controller
        
        
    }
    

  

}
