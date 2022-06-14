//
//  HomeVC.swift
//  StockTickers
//
//  Created by MgKaung on 13/06/2022.
//

import Foundation
import UIKit
import Combine

class HomeVC:  UIViewController {
    @IBOutlet weak var homeCollectionView: UICollectionView!
    private var subscriptions = Set<AnyCancellable>()
    let timer = Timer.publish(every: 1, on: .main, in: .common)
    private let refreshControl = UIRefreshControl()
    var homeVM = HomeVM()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        homeVM.getAllData()
        setupBinding()
        runTimer()
    }
    
    func setupBinding() {
        homeVM
            .$isLoading
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] isLoading in
                if isLoading {
                    self?.showLoading()
                } else {
                    self?.hideLoading(completion: { [weak self] in
                        self?.homeCollectionView.reloadData()
                        self?.refreshControl.endRefreshing()
                    })
                }
            }).store(in: &subscriptions)
        
        homeVM.$stocks
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] stocks in
                self?.homeCollectionView.reloadData()
            }).store(in: &subscriptions)
    }
    
    func runTimer() {
        timer
            .autoconnect()
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] time in
                print(time)
                self?.homeVM.getStock()
            }).store(in: &subscriptions)
    }
    
    private func setupCollectionView() {
        homeCollectionView.delegate = self
        homeCollectionView.dataSource = self
        homeCollectionView.collectionViewLayout = createCollectionViewLayout()
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        homeCollectionView.refreshControl = refreshControl
        homeCollectionView.register(UINib(nibName: "StockCell", bundle: nil), forCellWithReuseIdentifier: "StockCell")
        homeCollectionView.register(UINib(nibName: "HeadLineNewsCell", bundle: nil), forCellWithReuseIdentifier: "HeadLineNewsCell")
        homeCollectionView.register(UINib(nibName: "NewsCell", bundle: nil), forCellWithReuseIdentifier: "NewsCell")
        
    }
}
extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource {
    @objc private func refresh(_ sender: AnyObject) {
        homeVM.getAllData()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return (homeVM.stocks ?? []).count
        } else if section == 1 {
            return  (homeVM.headLineArticles ?? []).count
        } else {
            return (homeVM.articles ?? []).count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StockCell", for: indexPath) as? StockCell
            cell?.stock = homeVM.stocks?[indexPath.row]
            return cell ?? UICollectionViewCell()
        } else if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeadLineNewsCell", for: indexPath) as? HeadLineNewsCell
            cell?.article = homeVM.headLineArticles?[indexPath.row]
            return cell ?? UICollectionViewCell()
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsCell", for: indexPath) as? NewsCell
            cell?.article = homeVM.articles?[indexPath.row]
            return cell ?? UICollectionViewCell()
        }
    }
}
extension HomeVC: UICollectionViewDelegateFlowLayout {
    private func createCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (section, _) -> NSCollectionLayoutSection? in
            if section == 0 {
                let item = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1/3),
                        heightDimension: .fractionalHeight(1)
                    )
                )
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 8)
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .absolute(140)
                    ),
                    subitem: item,
                    count: 3
                )
                group.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0)
                
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
                return section
            } else if section == 1 {
                let item = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1/5),
                        heightDimension: .fractionalHeight(1)
                    )
                )
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 8)
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .absolute(300)
                    ),
                    subitem: item,
                    count: 1
                )
                group.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0)
                
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
                return section
            } else if section == 2 {
                let item = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .estimated(140)
                    )
                )
                
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .estimated(140)
                    ),
                    subitem: item,
                    count: 1
                )
                group.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0)
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
                
                return section
                
            }
            return nil
        }
    }
}
