//
//  UICollectionView+Ext.swift
//  InstaDemo
//
//  Created by Rəşad Əliyev on 10/28/25.
//

import UIKit

extension UICollectionView {
    func dequeueCell<T: UICollectionViewCell>(with indexPath: IndexPath) -> T {
        let bareCell = self.dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath)
        
        guard let cell = bareCell as? T else { fatalError("Couldn't dequeue cell") }
        return cell
    }
}
