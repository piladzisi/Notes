//
//  NoteCell.swift
//  Notes
//
//  Created by Anna Sibirtseva on 18/01/2021.
//

import UIKit

class NoteCell: UITableViewCell {
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var noteBodyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    func populate(with note: Note) {
        if note.category != nil {
            categoryLabel.text = note.category
        } else {
        categoryLabel.text = ""
        }
        noteBodyLabel.text = note.body
    }
}
