//
//  ImageCollectionCell.swift
//  Forms_iOS
//
//  Created by Soumya Jain on 22/01/20.
//  Copyright © 2020 Soumya. All rights reserved.
//

import UIKit

class ImageCollectionCell: ReusableCollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
//    @IBOutlet weak var widthOfImageView: NSLayoutConstraint!
//    @IBOutlet weak var heightOfImageView: NSLayoutConstraint!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(image: UIImage, size: CGSize)  {
        self.imageView.image = image //kf.setImage(with: URL(string: imageURL), placeholder: Image.placeholder)
//        self.widthOfImageView.constant = size.width
//        self.heightOfImageView.constant = size.height
    }
}
