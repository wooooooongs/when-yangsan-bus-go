//
//  HomeViewController+UICollectionViewDelegate.swift
//  whenMyBusGo
//
//  Created by Oscar on 2/4/24.
//

import UIKit

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        let cellItemForRow: CGFloat = 2
        let minimumSpacing: CGFloat = 20
        
        let width = (collectionViewWidth - (cellItemForRow - 1) * minimumSpacing) / cellItemForRow
        
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    // MARK: - Cell Tapped 화면 전환
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? MenuCollectionViewCell {
            let (isTimetable, isLocation, isNotice, isQna) = (
                cell.menuData?.title == .busTimetable,
                cell.menuData?.title == .location_yangsan,
                cell.menuData?.title == .notice_yangsan,
                cell.menuData?.title == .qna
            )
            
            if isTimetable {
                let busTimetableViewController = BusTimetableViewController()
                self.navigationController?.pushViewController(busTimetableViewController, animated: true)
            }
        }
        
    }
}
