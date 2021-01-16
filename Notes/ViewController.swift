//
//  ViewController.swift
//  Notes
//
//  Created by Anna Sibirtseva on 10/01/2021.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var notes = [Note]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barTintColor  = .systemOrange // for small titles
        navigationController?.view.backgroundColor = .systemOrange // for large titles
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadNotes()
    }
    
    func loadNotes() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        
        do {
            let fetchedObjects = try context.fetch(fetchRequest)
            guard let notes = fetchedObjects as? [Note] else { return }
            self.notes = notes
            tableView.reloadData()
        } catch {
            print(error)
        }
    }
    
    @IBAction func didTapAdd() {
       performSegue(withIdentifier: "segue.Main.notesListToNoteEditor", sender: nil)
    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.selectionStyle = .none
        let note = notes[indexPath.row]
        cell.textLabel?.text = note.body
        cell.textLabel?.numberOfLines = 0
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let note = notes[indexPath.row]
        
        let alert = UIAlertController(title: "Edit Note", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.text = note.body
        }
        
        let updateAction = UIAlertAction(title: "Save", style: .default) { (_) in
            guard
                let updatedNoteBody = alert.textFields?.first?.text,
                let appDelegate = UIApplication.shared.delegate as? AppDelegate
            else { return }
          
            note.body = updatedNoteBody
            appDelegate.saveContext()
            
            self.loadNotes()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(cancelAction)
        alert.addAction(updateAction)
        present(alert, animated: true)
    }
}

