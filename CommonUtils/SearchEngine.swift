//
//  SearchEngine.swift
//  CommonUtils
//
//  Created by Nam Doan on 2018/01/13.
//  Copyright © 2018 NamDH. All rights reserved.
//

import Foundation

public enum SearchEngine: Int {
    case google = 0
    case yahoo = 1
    case yahooJP = 2
    case bing = 3
    case duckDuckGo = 4
    case baidu = 5

    public static let list = [SearchEngine.google,
                       SearchEngine.yahoo,
                       SearchEngine.yahooJP,
                       SearchEngine.bing,
                       SearchEngine.baidu,
                       SearchEngine.duckDuckGo]

    public var prefix: String {
        switch self {
        case .google:
            return "http://www.google.com/search?q="
        case .yahoo:
            return "https://search.yahoo.com/search?p="
        case .yahooJP:
            return "https://search.yahoo.co.jp/search?p="
        case .bing:
            return "https://www.bing.com/search?q="
        case .duckDuckGo:
            return "https://duckduckgo.com/?q="
        case .baidu:
            return "https://www.baidu.com/s?wd="
        }
    }

    public var name: String {
        switch self {
        case .google:
            return "Google"
        case .yahoo:
            return "Yahoo!"
        case .yahooJP:
            return "Yahoo! JAPAN"
        case .bing:
            return "Bing"
        case .duckDuckGo:
            return "Duck Duck Go"
        case .baidu:
            return "Baidu"
        }
    }

    public func searchURL(keyword: String) -> URL? {
        let query: String = {
            switch self {
            case .baidu:
                return keyword
            default:
                return keyword.replacingOccurrences(of: " ", with: "+")
            }
        }()
        if let urlString = "\(prefix)\(query)".addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) {
            return URL(string: urlString)
        } else {
            return nil
        }
    }
}
