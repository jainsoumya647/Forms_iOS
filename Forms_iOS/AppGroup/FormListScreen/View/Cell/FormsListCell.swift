//
//  FormsListCell.swift
//  Forms_iOS
//
//  Created by Soumya Jain on 20/01/20.
//  Copyright © 2020 Soumya. All rights reserved.
//

import UIKit

class FormsListCell: ReusableTableViewCell {

    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var numberOfViewsLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var jobTermLabel: UILabel!
    @IBOutlet weak var inviteButton: UIButton!
    @IBOutlet weak var inboxButton: UIButton!
    
    var moreOptionAction: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupCell()
    }
    
    func setupCell() {
        self.contentView.backgroundColor = .clear
        self.backgroundColor = .clear
        self.setupLabels()
        self.setupButtons()
    }
    
    func setupLabels() {
        self.titleLabel.configureLabel(fontSize: FontSize.medium)
        self.startDateLabel.configurePlaceholderLabel(fontSize: FontSize.regular)
        self.numberOfViewsLabel.configurePlaceholderLabel(fontSize: FontSize.regular)
        self.rateLabel.configurePlaceholderLabel(fontSize: FontSize.regular)
        self.jobTermLabel.configurePlaceholderLabel(fontSize: FontSize.regular)
    }
    
    func setupButtons() {
        self.inviteButton.configureSolidBackgroundColor()
        self.inboxButton.configureBorderColor()
    }
    
    @IBAction func moreAction(_ sender: Any) {
        self.moreOptionAction?()
    }
    
}
