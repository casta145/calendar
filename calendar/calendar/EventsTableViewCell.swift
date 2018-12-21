//
//  EventsTableViewCell.swift
//  calendar
//
//  Created by Alfonso Castanos on 12/20/18.
//  Copyright © 2018 Alfonso Castanos. All rights reserved.
//

import UIKit

protocol TableViewNew {
    func onClickCell(index: Int)
}

class EventsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var EventDate: UILabel!
    var cellDelgate: TableViewNew?
    var index: IndexPath?
    
    
    
    @IBAction func EventPage(_ sender: Any) {
        cellDelgate?.onClickCell(index: (index?.row)!)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
