//
//  CaughtTableViewCell.swift
//  PeoplemonProject
//
//  Created by Melissa Anderson on 11/10/16.
//  Copyright © 2016 Melissa Anderson. All rights reserved.
//

import UIKit

class CaughtTableViewCell: UITableViewCell {

    @IBOutlet weak var avatar: CircleImage!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var person: Person!
    
    func setupCell(person: Person) {
        self.person = person
        
        nameLabel.text = person.username
        if let createdDate = person.created {
            let date = Date(fromString: createdDate, format: .iso8601(nil))
            dateLabel.text = date.toString(.custom("M/d/yyyy h:m:s a"))
        }
        if let image = Utils.imageFromString(imageString: person.avatar) {
            avatar.image = image
        } else {
            avatar.image = Images.Avatar.image()
        }
        avatar.setupView(size: 60)
    }
}
