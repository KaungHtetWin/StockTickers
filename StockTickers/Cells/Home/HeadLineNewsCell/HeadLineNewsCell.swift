//
//  HeadLineNewsCell.swift
//  StockTickers
//
//  Created by MgKaung on 13/06/2022.
//

import UIKit
import Kingfisher

class HeadLineNewsCell: UICollectionViewCell {
    @IBOutlet weak var imgNews: UIImageView!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsTitleHolderView: UIView!
    var article: Article? {
        didSet {
            let url = URL(string: article?.urlToImage ?? "")
            imgNews.kf.indicatorType = .activity
            imgNews.kf.setImage(with: url)
            newsTitle.text = article?.title
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor =  UIColor(red: 249, green: 249, blue: 249, alpha: 1)
        shadowRoundCornerView()
        imgNews.layer.cornerRadius = 10
        newsTitleHolderView.layer.cornerRadius = 10
        newsTitleHolderView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
}
