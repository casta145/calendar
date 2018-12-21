//
//  ViewController.swift
//  calendar
//
//  Created by Alfonso Castanos on 12/19/18.
//  Copyright © 2018 Alfonso Castanos. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBAction func enterButton(_ sender: UIButton) {
        performSegue(withIdentifier: "segueOne", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        //Dispose of any resources that can be recreated
    }
}

