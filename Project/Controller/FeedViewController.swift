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
    
   private var sources = [RssSource]()
   private var rssFeeds = [RSSFeed]()
   private let coreDataRepository = Persistence()
   private let feedClient = FeedClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sources = coreDataRepository.fetchSourcesFromCoreData()
        fetchRssFeeds()
        
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return rssFeeds.count
    }
    
    func fetchRssFeeds() {
        sources.forEach({ source in
            feedClient.fetchNewsItemsAsync(from: source.sourceLink!, completionHandler: { result in
                DispatchQueue.main.async {
                        self.rssFeeds.append((result.rssFeed)!)
                        self.collectionView.reloadData()
                }
            })
        })
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newsItems.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionHeader", for: indexPath) as? SectionHeader {
            sectionHeader.sectionHeaderLabel.text = sources[indexPath.section].sourceName
            return sectionHeader
        }
        return UICollectionReusableView()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RssCollectionViewCellIdentifier", for: indexPath) as! RssCollectionViewCell
        let newsItem = rssFeeds[indexPath.section].items![indexPath.item]
        
        cell.cellTitle.text = newsItem.title
        
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
