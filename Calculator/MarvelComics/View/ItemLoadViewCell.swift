//
//  ItemLoadViewCell.swift
//  Calculator
//
//  Created by Diego Fernando Cuesta Arevalo on 1/12/19.
//  Copyright © 2019 Diego Fernando Cuesta Arevalo. All rights reserved.
//

import UIKit
import Lottie

class ItemLoadViewCell: UITableViewCell {
    
    @IBOutlet var lottieLoad: LOTAnimationView!

    override func awakeFromNib() {
        super.awakeFromNib()
        lottieLoad.loopAnimation = true
        lottieLoad.setAnimation(named: "loader.json")
        lottieLoad.play()
    }

    

}
