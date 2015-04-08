//
//  ViewController.swift
//  TestTableViewScrollZoom
//
//  Created by Paul Von Schrottky on 4/6/15.
//  Copyright (c) 2015 Paul Von Schrottky. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {
    let cellHeight: CGFloat = 50.0
    var contentInsetY: CGFloat = 0
    @IBOutlet weak var constraint: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        

    

        self.contentInsetY = ((self.view.frame.size.height) / 2) - (cellHeight / 2)
        self.tableView.contentInset = UIEdgeInsetsMake(self.contentInsetY, 0, self.contentInsetY, 0)
        // Do any additional setup after loading the view, typically from a nib.
//        self.tableView.pagingEnabled = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //#pragma - mark UITableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return cellHeight
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let tableViewCell = tableView.dequeueReusableCellWithIdentifier("CellID") as UITableViewCell
        tableViewCell.textLabel!.text = String(indexPath.row)
        return tableViewCell
    }
    
    //#pragma - mark UITableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        let cell = tableView.cellForRowAtIndexPath(indexPath)
//        let transform = CGAffineTransformScale(cell!.contentView.transform, 2, 2)
//        self.view.transform = transform
        println(self.tableView.bounds.size.height)
    }
    
    //#pragma - mark UIScrollViewDelegate
    
    
    func scrollViewDidScroll(scrollView: UIScrollView) {

    }
    
    func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        println("scrollViewWillEndDragging")
        println("targetContentOffset: \(targetContentOffset.memory.y)")
        
        var targetContentOffsetCorrected: CGPoint = targetContentOffset.memory
        targetContentOffsetCorrected.y += contentInsetY
        println("targetContentOffsetCorrected: \(targetContentOffsetCorrected.y)")
        
        let targetCellIndexPath = self.tableView.indexPathForRowAtPoint(targetContentOffsetCorrected)
        println("targetCellIndexPath row: \(targetCellIndexPath?.row)")
        
        let targetCellRect = self.tableView.rectForRowAtIndexPath(targetCellIndexPath!)
        println("targetCellRect: \(targetCellRect)")
        
        var targetCellYCenter = targetCellRect.origin.y
        println("targetCellYCenter: \(targetCellYCenter)")
        
        let isJumpingDown = (targetContentOffsetCorrected.y % cellHeight) > (cellHeight / 2)
        println("isJumpingDown: \(isJumpingDown)")
        
        if isJumpingDown == true {
            let nextPlace = Int(targetContentOffsetCorrected.y) / Int(cellHeight)
            println("nextPlace: \(nextPlace)")
            targetCellYCenter = (CGFloat(nextPlace) * cellHeight) + cellHeight
            println("targetCellYCenter corrected: \(targetCellYCenter)")
        }
        
        targetContentOffset.memory.y = targetCellYCenter - contentInsetY
    }

//    func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, inout targetContentOffset: CGPoint) {
//        let indexPath = self.tableView.indexPathForRowAtPoint(velocity)
//        println(indexPath!.row)
//        targetContentOffset = self.tableView.rectForRowAtIndexPath(indexPath!).origin
//    }
//    func scrollViewDidScroll(scrollView: UIScrollView) {
//        self.navigationController?.pvs_collapisbleBarScrollViewDidScroll(scrollView)
//    }
}

