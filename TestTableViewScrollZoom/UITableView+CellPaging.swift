//
//  UITableView+CellPaging.swift
//  TestTableViewScrollZoom
//
//  Created by Paul Von Schrottky on 4/8/15.
//  Copyright (c) 2015 Paul Von Schrottky. All rights reserved.
//

import UIKit

extension UITableView {
    func pvs_cellPagingScrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>, cellHeight: CGFloat, contentInsetY: CGFloat = 0) {

        var targetContentOffsetCorrected: CGPoint = targetContentOffset.memory
        targetContentOffsetCorrected.y += contentInsetY
        
        let targetCellIndexPath = self.indexPathForRowAtPoint(targetContentOffsetCorrected)
        
        let targetCellRect = self.rectForRowAtIndexPath(targetCellIndexPath!)
        
        var targetCellYCenter = targetCellRect.origin.y
        
        let isJumpingDown = (targetContentOffsetCorrected.y % cellHeight) > (cellHeight / 2)
        
        if isJumpingDown == true {
            let nextPlace = Int(targetContentOffsetCorrected.y) / Int(cellHeight)
            targetCellYCenter = (CGFloat(nextPlace) * cellHeight) + cellHeight
        }
        
        targetContentOffset.memory.y = targetCellYCenter - contentInsetY
    }
}
