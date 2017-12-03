//
//  VisitasViewCell.swift
//  PruebaPractica4
//
//  Created by Alberto Jimenez on 22/11/17.
//  Copyright © 2017 Alberto Jimenez. All rights reserved.
//

import UIKit

class VisitasViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBOutlet weak var notasLabel: UILabel!
    @IBOutlet weak var nombreLabel: UILabel!
    @IBOutlet weak var fechaLabel: UILabel!
    @IBOutlet weak var iconoView: UIImageView!
    
}
