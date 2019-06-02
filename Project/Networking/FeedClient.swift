//
//  FeedClient.swift
//  rss-parser-test
//
//  Created by Vladimir Vetrov on 01/05/2019.
//  Copyright © 2019 Vladimir Vetrov. All rights reserved.
//

import Foundation
import FeedKit

public class FeedClient {
    
    func fetchNewsItemsAsync(from URL: URL, completionHandler: @escaping (Result) -> ()){
        let parser = FeedParser.init(URL: URL)
        parser.parseAsync(queue: DispatchQueue.global(qos: .userInitiated),
                          result: {
                            result in
                            DispatchQueue.main.async {
                                completionHandler(result)
                                
                            }
        })
    }
    
    func fetchNewsItemsAsync(from stringUrl: String, completionHandler: @escaping (Result) -> ()){
        let parser = FeedParser.init(URL: URL(string: stringUrl)!)
        parser.parseAsync(queue: DispatchQueue.global(qos: .userInitiated),
                          result: {
                            result in
                            DispatchQueue.main.async {
                                completionHandler(result)
                                }
        })
    }
}
