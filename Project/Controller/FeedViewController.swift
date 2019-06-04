//
//  FeedViewController.swift
//  rss-parser-test
//
//  Created by Vladimir Vetrov on 05/04/2019.
//  Copyright © 2019 Vladimir Vetrov. All rights reserved.
//

import UIKit
import FeedKit

class FeedViewController: UICollectionViewController, CoreDataInstanceDelegate {
    
    private var sources = [RssSource]()
    private var rssFeeds = [RSSFeed]()
    private let coreDataRepository = Persistence()
    private let feedClient = FeedClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchSourcesFromCoreData()
        fetchRssFeeds()
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return rssFeeds.count
    }
    
    /// CoreDataInstanceDelegate callback: required to update data in the collection view based on the user actions
    ///
    /// - Parameter index: index of of item in array that was added or removed
    func coreDataContentsDidChange(with index: Int) {
        
        if sources.count - 1 >= index { // If index variable is smaller than index of the last element in the rssFeeds array, we should remove one RSSFeed from the array
            sources.remove(at: index)
            rssFeeds.remove(at: index)
            
            collectionView.deleteItems(at: [IndexPath.init(indexes: [index])])
            collectionView.reloadData()
            
        } else {    // User added more sources, update RssSource array from CoreData and then fetch new RSS Feeds from the Internet
            fetchSourcesFromCoreData()
            fetchRssFeeds()
            
        }
    }
    
    func fetchSourcesFromCoreData() {
        self.sources = coreDataRepository.fetchSourcesFromCoreData()
    }
    
    func fetchRssFeeds() {
        self.sources.forEach({ source in
            feedClient.fetchNewsItemsAsync(from: source.sourceLink!, completionHandler: { result in
                DispatchQueue.main.async {
                    self.rssFeeds.append((result.rssFeed)!)
                    self.collectionView.reloadData()
                }
            })
        })
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if rssFeeds.count == 0 {
            return 0
        }
        
        return rssFeeds[section].items!.count
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
        
        switch segue.identifier {
        case "newsItemCellToNewsItemViewController":
            let controller = segue.destination as! NewsItemViewController
            
            if let indexPath = self.collectionView.indexPathsForSelectedItems {
                let newsItem = rssFeeds[indexPath[0].section].items![indexPath[0].item]
                let selectedNewsItem = newsItem
                controller.newsItem = selectedNewsItem
            }
            break
        case "feedViewControllerToRssSourcesViewController":
            let controller = segue.destination as! RssSourcesViewController
            controller.coreDataDelegate = self
            break
        default:
            print("Unhandled segue")
        }
        
    }
    
}
