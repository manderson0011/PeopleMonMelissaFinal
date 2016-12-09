//
//  CircleImage.swift
//  PeoplemonProject
//
//  Created by Melissa Anderson on 11/5/16.
//  Copyright © 2016 Melissa Anderson. All rights reserved.
//


import UIKit

class CircleImage: UIImageView {
    func setupView(size: CGFloat) {
        let height = size / 2.0
        let width = size / 2.0
        self.layer.cornerRadius = min(height,width)
        self.clipsToBounds = true
    }
}
