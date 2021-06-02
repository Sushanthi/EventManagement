//
//  EventsTableViewCell.swift
//  EventManagement
//
//  Created by ur268042 on 5/30/21.
//

import UIKit

class EventsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabelText: UILabel!
    @IBOutlet weak var locationLabelText: UILabel!
    @IBOutlet weak var timeLabelText: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var favIcon: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        favIcon.isHidden = true
        
    }
}
