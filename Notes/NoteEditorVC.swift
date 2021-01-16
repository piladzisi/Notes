//
//  NoteEditorVC.swift
//  Notes
//
//  Created by Anna Sibirtseva on 16/01/2021.
//

import UIKit

class NoteEditorVC: UIViewController {
    
    @IBOutlet weak var noteTextView: UITextView!
    
    var note: Note?
    var userDidSave: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeNavBar()
        if let note = note {
            noteTextView.text = note.body
            navigationItem.title = "Edit Note"
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        noteTextView.becomeFirstResponder()
    }
    
    func customizeNavBar() {
        navigationController?.navigationBar.tintColor = .white
        let barButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(didTapDone))
        navigationItem.rightBarButtonItem = barButtonItem
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if userDidSave == false{
            saveNote()
        }
    }
    
    @objc func didTapDone() {
        saveNote()
        userDidSave = true
        navigationController?.popViewController(animated: true)
    }
    
    func saveNote() {
        guard
            let appDelegate = UIApplication.shared.delegate as? AppDelegate,
            noteTextView.text.isEmpty == false
            else { return }
        let context = appDelegate.persistentContainer.viewContext
        
        if let note = note {
            note.body = noteTextView.text
        } else {
            let newNote = Note(context: context)
            newNote.body = noteTextView.text
        }
        appDelegate.saveContext()
    }
}
