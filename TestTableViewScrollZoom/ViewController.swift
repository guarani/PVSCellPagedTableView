//
//  ViewController.swift
//  TestTableViewScrollZoom
//
//  Created by Paul Von Schrottky on 4/6/15.
//  Copyright (c) 2015 Paul Von Schrottky. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {
    let cellHeight: CGFloat = 150.0
    var contentInsetY: CGFloat = 0
    @IBOutlet weak var constraint: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Make the top and bottom of the table view start and end in the middle of the screen (comment out these two lines to remove this).
        self.contentInsetY = ((self.view.frame.size.height) / 2) - (cellHeight / 2)
        self.tableView.contentInset = UIEdgeInsetsMake(self.contentInsetY, 0, self.contentInsetY, 0)
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
    
    //#pragma - mark UIScrollViewDelegate
    
    func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        self.tableView.pvs_cellPagingScrollViewWillEndDragging(scrollView, withVelocity: velocity, targetContentOffset: targetContentOffset, cellHeight: self.cellHeight, contentInsetY: self.contentInsetY)
    }
}

