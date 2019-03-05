//
//  HeroArtifactsViewController+CollectionView.swift
//  MyMarvelHeroes
//
//  Created by Matheus Lima on 01/03/19.
//  Copyright © 2019 Matheus Lima. All rights reserved.
//

import Foundation
import UIKit

extension HeroArtifactsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        collectionView.backgroundView = artifacts.count == 0 ? noResultsLabel : nil
        return artifacts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ArtifactCollectionViewCell.identifier, for: indexPath) as! ArtifactCollectionViewCell
        cell.prepareCell(with: artifacts[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: FooterActivityIndicatorView.identifier, for: indexPath) as! FooterActivityIndicatorView
        footerView.activityIndicator.startAnimating()
        return footerView
    }
    
    // MARK: - Infinite Scroll
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == artifacts.count - MarvelAPI.Constants.InfiniteScrollLimiar &&
            !loadingArtifacts &&
            artifacts.count < total
        {
            currentPage += 1
            loadArtifacts(withIndicator: false)
        }
    }
}

extension HeroArtifactsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 8
        let height = view.frame.height / 2
        let collectionViewSize = collectionView.frame.size.width - padding
        
        return CGSize(width: collectionViewSize / 2, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return total > artifacts.count ? CGSize(width: collectionView.frame.size.width, height: 50) : CGSize(width: 0, height: 0)
    }
}
