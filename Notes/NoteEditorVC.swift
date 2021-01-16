//
//  NoteEditorVC.swift
//  Notes
//
//  Created by Anna Sibirtseva on 16/01/2021.
//

import UIKit

class NoteEditorVC: UIViewController {

    @IBOutlet weak var noteTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = .white
        
        let barButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(didTapDone))
        navigationItem.rightBarButtonItem = barButtonItem
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        noteTextView.becomeFirstResponder()
    }
    
    @objc func didTapDone() {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let newNote = Note(context: context)
        newNote.body = noteTextView.text
        appDelegate.saveContext()

        navigationController?.popViewController(animated: true)
    }
}
