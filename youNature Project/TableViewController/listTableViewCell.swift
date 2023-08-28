//
//  listTableViewCell.swift
//  youNature Project
//
//  Created by HARSHID PATEL on 28/08/23.
//

import UIKit

protocol AddListTableViewCellDelegate: AnyObject {
    func editlist(with index: IndexPath)
    func deleteList(with index: IndexPath)
}


class listTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var nameLb: UILabel!
    @IBOutlet weak var countryLb: UILabel!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var view: UIView!
    
    
    var indexPath: IndexPath!
    weak var delegate: AddListTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        view.layer.cornerRadius = 14
        view.layer.masksToBounds = true
        self.contentView.backgroundColor = .clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func menuButtonAction(_ sender: UIButton) {
        let editButton = UIAction(title: "Edit") { _ in
            self.delegate?.editlist(with: self.indexPath)
        }
        
        let deleteButton = UIAction(title: "Delete") { _ in
            self.delegate?.deleteList(with: self.indexPath)
        }
        
        let menu = UIMenu(children: [editButton, deleteButton])
        sender.showsMenuAsPrimaryAction = true
        sender.menu = menu
    }
}
