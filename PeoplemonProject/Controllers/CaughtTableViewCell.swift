//
//  CaughtTableViewCell.swift
//  PeoplemonProject
//
//  Created by Melissa Anderson on 11/10/16.
//  Copyright © 2016 Melissa Anderson. All rights reserved.
//

import UIKit

class CaughtTableViewCell: UITableViewCell {

    weak var caught: People!

    @IBOutlet weak var caughtLabel: UILabel!

    
    var people: People!
    
    func setUpCell(people: People){
        self.people = people
        caughtLabel.text = people.userName
    
    }

}
