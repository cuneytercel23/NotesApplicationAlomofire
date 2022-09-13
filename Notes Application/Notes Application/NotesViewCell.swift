//
//  NotesViewCell.swift
//  Notes Application
//
//  Created by Cüneyt Erçel on 5.09.2022.
//

import UIKit

class NotesViewCell: UITableViewCell {
    @IBOutlet weak var lectureNameLabel: UILabel!
    
    @IBOutlet weak var firstNoteLabel: UILabel!
    @IBOutlet weak var secondNoteLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
