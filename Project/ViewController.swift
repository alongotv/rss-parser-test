//
//  ViewController.swift
//  rss-parser-test
//
//  Created by Vladimir Vetrov on 04/04/2019.
//  Copyright © 2019 Vladimir Vetrov. All rights reserved.
//

import UIKit
import FeedKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let feedURL = URL(string: "http://images.apple.com/main/rss/hotnews/hotnews.rss")!

        let parser = FeedParser(URL: feedURL)
        
        parser.parse()
    }


}

