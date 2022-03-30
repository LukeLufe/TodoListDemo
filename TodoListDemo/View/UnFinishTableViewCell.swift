//
//  UnFinishTableViewCell.swift
//  TodoListDemo
//
//  Created by Luke on 2022/3/29.
//

import UIKit

protocol UnFinishTableViewCellDelegate: AnyObject {
    
    func removeBtnPressed(_ sender: UIButton)
    func finishBtnPressed(_ sender: UIButton)
    
}

class UnFinishTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var removeBtn: UIButton!
    @IBOutlet weak var finishBtn: UIButton!
    weak var delegate: UnFinishTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        titleLabel.adjustsFontSizeToFitWidth = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    @IBAction func removeBtnPressed(_ sender: UIButton) {
        delegate?.removeBtnPressed(sender)
    }
    
    @IBAction func finishBtnPressed(_ sender: UIButton) {
        delegate?.finishBtnPressed(sender)
    }
    
}
