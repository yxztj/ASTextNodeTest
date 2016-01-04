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
        return TestContainerNode()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowCount
    }
}

class TestContainerNode: ASCellNode {
    var subnode = TestSubnode()
    override init() {
        super.init()
        self.addSubnode(subnode)
    }
    
    override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let insetSpec = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 30, left: 100, bottom: 30, right: 100), child: subnode)
        return insetSpec
    }
}

class TestSubnode: ASDisplayNode {
    let topicTextNode: ASTextNode
    
    override init() {
        topicTextNode = ASTextNode()
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .Center
        let topicAttr: [String: AnyObject] = [NSParagraphStyleAttributeName: paragraphStyle]
        topicTextNode.attributedString = NSAttributedString(string: "TEST TEST TEST", attributes: topicAttr)
        
        // Remove the attributes, the issue goes away.
        // Looks like the attributes "thinks" the node has a bigger size, so the text is centered in a bigger frame rather than its actual frame.
        // Scroll down and up again(re-render the cell), the issue also goes away.
//        topicTextNode.attributedString = NSAttributedString(string: "TEST")

        super.init()

        self.addSubnode(topicTextNode)
    }
    
    override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let topicStack = ASStackLayoutSpec(direction: .Vertical, spacing: 10, justifyContent: .Center, alignItems: .Center, children: [topicTextNode])
        return topicStack
    }
}