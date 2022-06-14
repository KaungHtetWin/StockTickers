//
//  NewsCell.swift
//  StockTickers
//
//  Created by MgKaung on 13/06/2022.
//

import UIKit
class NewsCell: UICollectionViewCell {
    @IBOutlet weak var imgNews: UIImageView!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsDesc: UILabel!
    @IBOutlet weak var newsPublishAt: UILabel!
    var article: Article? {
        didSet {
            let url = URL(string: article?.urlToImage ?? "")
            imgNews.kf.indicatorType = .activity
            imgNews.kf.setImage(with: url)
            newsTitle.text = article?.title
            newsDesc.text = article?.articleDescription
            newsPublishAt.text = article?.publishedAt?.toString()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
