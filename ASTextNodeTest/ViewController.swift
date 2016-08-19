//
//  ViewController.swift
//  ASTextNodeTest
//
//  Created by Jason Yu on 1/4/16.
//  Copyright © 2016 Ruguo. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class ViewController: UIViewController {
    let tableView = ASTableView()
    var rowCount = 100

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.addSubview(tableView)
        tableView.frame = self.view.bounds
        
        tableView.asyncDataSource = self
    }
}

extension ViewController: ASTableDataSource {
    func tableView(tableView: ASTableView, nodeForRowAtIndexPath indexPath: NSIndexPath) -> ASCellNode {
        return TestNode()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowCount
    }
}

class TestNode: ASCellNode {
    let topicTextNode: ASTextNode

    override init() {
        topicTextNode = ASTextNode()

        let messageFont = UIFont.systemFontOfSize(16, weight: UIFontWeightLight)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 1
        
        let messageAttr: [String: AnyObject] = [NSFontAttributeName: messageFont, NSParagraphStyleAttributeName: paragraphStyle]
        let testString = "This is a long message. This is a long message. This is a long message. This is a long message. This is a long message. This is a long message. This is a long message. This is a long message. This is a long message. This is a long message. This is a long message. This is a long message. This is a long message. This is a long message. This is a long message. "
        
        topicTextNode.truncationAttributedString = NSAttributedString(string: "...", attributes: messageAttr)
        topicTextNode.attributedString = NSAttributedString(string: testString, attributes: messageAttr)
        topicTextNode.maximumNumberOfLines = 3
        topicTextNode.flexShrink = true

        super.init()

        self.addSubnode(topicTextNode)
    }
    
    override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let topicStack = ASStackLayoutSpec(direction: .Horizontal, spacing: 10, justifyContent: .Center, alignItems: .Center, children: [topicTextNode])
        let inset = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 30), child: topicStack)
        return inset
    }
}