//
//  EventViewController.swift
//  calendar
//
//  Created by Alfonso Castanos on 12/20/18.
//  Copyright © 2018 Alfonso Castanos. All rights reserved.
//

import UIKit

class EventViewController: UIViewController {

    @IBOutlet weak var DateLabel: UILabel!
    @IBOutlet weak var EventInfo: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DateLabel.text = savedDates[myindex]
        EventInfo.text = savedEvent[myindex]
    }
    
    //goes back to calendar
    @IBAction func OK(_ sender: UIButton) {
        performSegue(withIdentifier: "segueFive", sender: self)
    }
    
    //deletes event and goes back to calendar
    @IBAction func Delete(_ sender: UIButton) {
        
        //code to delete date
        performSegue(withIdentifier: "segueFive", sender: self)
    }
    
}
