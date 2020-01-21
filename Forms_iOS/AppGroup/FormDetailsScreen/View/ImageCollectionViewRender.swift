//
//  ImageCollectionViewRender.swift
//  Forms_iOS
//
//  Created by Soumya Jain on 22/01/20.
//  Copyright © 2020 Soumya. All rights reserved.
//

import UIKit

class ImageCollectionViewRender: NSObject {

    var imagesArray: [UIImage]
    var size: CGSize
    
    init(imagesArray: [UIImage], size: CGSize = .zero) {
        self.imagesArray = imagesArray
        self.size = size
    }
}

extension ImageCollectionViewRender: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imagesArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = ImageCollectionCell.getDequeuedCell(for: collectionView, indexPath: indexPath) as? ImageCollectionCell else { return UICollectionViewCell() }
        cell.configureCell(image: self.imagesArray[indexPath.item], size: self.size)
        return cell
    }
}

extension ImageCollectionViewRender: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return size
    }
}
