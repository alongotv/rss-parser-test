//
//  FeedViewController.swift
//  rss-parser-test
//
//  Created by Vladimir Vetrov on 05/04/2019.
//  Copyright © 2019 Vladimir Vetrov. All rights reserved.
//

import UIKit
import CoreData
import FeedKit

class FeedViewController: UICollectionViewController {
    
    var sources = [RssSource]()
    var newsItems = [RSSFeedItem]()
    let coreDataRepository = Persistence()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sources = coreDataRepository.fetchSourcesFromCoreData()
        
        let parser = FeedParser.init(URL: URL(string: "https://images.apple.com/main/rss/hotnews/hotnews.rss")!)
        let result = parser.parse()
        newsItems = result.rssFeed!.items!
        print("NewsItems = \(newsItems.count)")
        
        collectionView.reloadData()
        
        for source in newsItems {
            print(source.title)
        }
        // Do any additional setup after loading the view.
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sources.count
    }
    
    //    func numberOfItems(inSection section: Int) -> Int {
    //        return newsItems.count
    //    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newsItems.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionHeader", for: indexPath) as? SectionHeader {
            sectionHeader.sectionHeaderLabel.text = "Section \(indexPath.row)"
            return sectionHeader
        }
        return UICollectionReusableView()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RssCollectionViewCellIdentifier", for: indexPath) as! RssCollectionViewCell
        
        cell.cellTitle.text = newsItems[indexPath.item].title
        
        return cell
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "newsItemCellToNewsItemViewController" {
            let controller = segue.destination as! NewsItemViewController

            if let indexPath = self.collectionView.indexPathsForSelectedItems {
                let selectedNewsItem = newsItems[indexPath[0].item]
                controller.newsItem = selectedNewsItem
            }
        }
    }
}
