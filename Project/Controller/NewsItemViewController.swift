//
//  NewsItemViewController.swift
//  rss-parser-test
//
//  Created by Vladimir Vetrov on 22/05/2019.
//  Copyright © 2019 Vladimir Vetrov. All rights reserved.
//

import UIKit
import FeedKit

class NewsItemViewController: UIViewController {

    
    @IBOutlet weak var textItemLabel: UILabel!
    
    @IBOutlet weak var textItemDescription: UITextView!
    
    var newsItem: RSSFeedItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textItemLabel.text = newsItem.title
        textItemDescription.text = newsItem.description        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
