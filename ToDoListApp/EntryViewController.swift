//
//  EntryViewController.swift
//  ToDoListApp
//
//  Created by Юлия Караневская on 4.06.21.
//

import UIKit

class EntryViewController: UIViewController, UITextFieldDelegate {
    
    var update: (() -> Void)?
    
    var textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Add new task"
        textField.textColor = UIColor.black
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.clipsToBounds = true
        textField.layer.cornerRadius = 25
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(textField)
        view.backgroundColor = .white
        textField.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveTask))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setTextField()
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        saveTask()
        return true
    }
    
    @objc func saveTask() {
        
        guard let text = textField.text, !text.isEmpty else {
            return
        }
        guard let count = UserDefaults().value(forKey: "count") as? Int else {
            return
        }
        let newCount = count + 1
        UserDefaults().set(newCount, forKey: "count")
        UserDefaults().set(text, forKey: "text_\(newCount)")
        update?()
        navigationController?.popViewController(animated: true)
         
    }
    
    func setTextField() {
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            textField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            textField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            textField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }


}
