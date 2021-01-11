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
        let alert = UIAlertController(title: "Add Note", message: nil, preferredStyle: .alert)
        alert.addTextField()
        let saveAction = UIAlertAction(title: "Save", style: .default) { (_) in
            guard
                let noteBody = alert.textFields?.first?.text,
                let appDelegate = UIApplication.shared.delegate as? AppDelegate
                else { return }
            
            let context = appDelegate.persistentContainer.viewContext
            let newNote = Note(context: context)
            newNote.body = noteBody
            appDelegate.saveContext()
            
            self.notes.append(newNote)
            self.tableView.reloadData()
        }
        alert.addAction(saveAction)
        present(alert, animated: true)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = notes[indexPath.row].body
        cell.textLabel?.numberOfLines = 0
        return cell
    }
}

