//
//  TableViewCell.swift
//  SimpliSave
//
//  Created by DA MAC M1 126 on 2023/07/31.
//

import UIKit

class BudgetTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblExpCategory: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblProgress: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Add a bottom border layer to the cell, 31/07/23, Shahiel
        layer.sublayers?.filter { $0.name == "borderLayer" }.forEach { $0.removeFromSuperlayer() }
        let borderLayer = CALayer()
        borderLayer.backgroundColor = (UIColor(red: 0.88, green: 0.87, blue: 0.87, alpha: 1.00)).cgColor
        borderLayer.name = "borderLayer"
        borderLayer.frame = CGRect(x: 0, y: bounds.height - 1, width: bounds.width, height: 1)
        layer.addSublayer(borderLayer)
        layer.cornerRadius = 15
        clipsToBounds = true
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
