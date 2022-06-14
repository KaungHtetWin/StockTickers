//
//  UIViewControllerAppExt.swift
//  StockTickers
//
//  Created by MgKaung on 14/06/2022.
//

import UIKit

extension UIViewController {
    // MARK: - Methods
    func showLoading() {
        self.view.endEditing(true)
        guard let safeFrame = UIApplication.shared.windows.filter({$0.isKeyWindow}).first?.frame else { return }
        let darkBGView = getLoaderDarkBG()
        darkBGView.frame = safeFrame
        
        let loaderViewWidth = safeFrame.width - 80
        let loaderMsg = getLoaderMsg(with: "Please Wait")
        let loaderMsgWidth = loaderViewWidth - 70 - 10
        loaderMsg.frame = CGRect(x: 70, y: 5, width: loaderMsgWidth, height: 50)
        loaderMsg.sizeToFit()
        loaderMsg.frame.size.height = loaderMsg.frame.height < 50 ? 50 : loaderMsg.frame.height
        loaderMsg.frame = CGRect(x: 70, y: 5, width: loaderMsgWidth, height: loaderMsg.frame.height)
        
        let loader = getLoader()
        let loaderYPos = ((loaderMsg.frame.height - 50) / 2) + 5
        loader.frame = CGRect(x: 10, y: loaderYPos, width: 50, height: 50)
        
        let loaderViewHeight = loaderMsg.frame.height + 10
        let loaderViewYPos = (safeFrame.height - loaderViewHeight) / 2
        let loaderView = getLoaderView()
        loaderView.frame = CGRect(x: 40, y: loaderViewYPos, width: loaderViewWidth, height: loaderViewHeight)
        loaderView.layer.cornerRadius = 8
        loaderView.layer.masksToBounds = true
        
        loaderView.addSubview(loader)
        loaderView.addSubview(loaderMsg)
        
        UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.addSubview(darkBGView)
        UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.addSubview(loaderView)
    }
    
    func hideLoading(completion: (() -> Void)? = nil) {
        UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.viewWithTag(9999)?.removeFromSuperview()
        UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.viewWithTag(9998)?.removeFromSuperview()
        if completion != nil {
            completion!()
        }
    }
    
    // MARK: Helper methods for alert view
    private func getLoaderDarkBG() -> UIView {
        let bgView = UIView()
        bgView.tag = 9999
        bgView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        return bgView
    }
    
    private func getLoaderView() -> UIView {
        let loaderView = UIView()
        loaderView.tag = 9998
        loaderView.backgroundColor = UIColor.white
        return loaderView
    }
    
    private func getLoader() -> UIActivityIndicatorView {
        let loader = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loader.hidesWhenStopped = true
        loader.style = UIActivityIndicatorView.Style.medium
        loader.startAnimating()
        return loader
    }
    
    private func getLoaderMsg(with title: String) -> UILabel {
        let msgLabel = UILabel()
        msgLabel.font = UIFont.boldSystemFont(ofSize: 13)
        msgLabel.text = title
        msgLabel.numberOfLines = 0
        msgLabel.lineBreakMode = .byWordWrapping
        msgLabel.textColor = UIColor.black
        return msgLabel
    }
}
