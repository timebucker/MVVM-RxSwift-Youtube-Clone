//
//  DataListView.swift
//  MVVM-RxSwift-Youtube-Clone
//
//  Created by Nguyen D.Nhan on 1/10/19.
//  Copyright © 2019 Nguyen D.Nhan. All rights reserved.
//

import UIKit

protocol DataListView: class {
    associatedtype ContentViewType: UIScrollView
    
    var contentView: ContentViewType { get }
    var refreshControl: UIRefreshControl { get }
    
    func reload()
    func loadNext()
    func scrollsToTop() -> Bool
}

extension DataListView where ContentViewType == UITableView {
    func scrollsToTop() -> Bool {
        if contentView.contentOffset.y > 0 && contentView.numberOfSections > 0 && contentView.numberOfRows(inSection: 0) > 0 {
            contentView.scrollToRow(at: IndexPath(row:0, section:0), at: .top, animated: true)
            return true
        }
        return false
    }
}

extension DataListView where ContentViewType == UICollectionView {
    func scrollsToTop() -> Bool {
        if contentView.numberOfSections > 0 && contentView.numberOfItems(inSection: 0) > 0 {
            contentView.scrollToItem(at: IndexPath(row:0, section:0), at: .top, animated: true)
            return true
        }
        return false
    }
}

extension DataListView {
    func beginRefreshing() {
        //        guard !refreshControl.isRefreshing else { return }
        
        refreshControl.beginRefreshing()
        
        if !scrollsToTop() {
            showRefreshControl()
        }
    }
    
    func endRefreshing() {
        guard refreshControl.isRefreshing else { return }
        refreshControl.endRefreshing()
        
        if !contentView.isDragging && contentView.contentOffset.y < 0 {
            UIView.animate(withDuration: 0.2, animations: { [weak self] in
                guard let me = self else { return }
                if #available(iOS 11.0, *) {
                    me.contentView.setContentOffset(CGPoint(x:0, y:-me.contentView.adjustedContentInset.top), animated: false)
                } else {
                    me.contentView.setContentOffset(CGPoint(x:0, y:-me.contentView.contentInset.top), animated: false)
                }
            })
        }
    }
    
    func dataListViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y + scrollView.frame.height * 1.3 >= scrollView.contentSize.height {
            loadNext()
        }
    }
    
    func dataListViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        if refreshControl.isRefreshing {
            if contentView.contentOffset.y > -contentView.contentInset.top {
                showRefreshControl()
            } else {
                reload()
            }
        }
    }
    
    private func showRefreshControl() {
        if #available(iOS 11.0, *) {
            let offset = -contentView.adjustedContentInset.top
            contentView.setContentOffset(CGPoint(x: 0, y: offset), animated: true)
        } else {
            let offset = -contentView.contentInset.top
            contentView.setContentOffset(CGPoint(x: 0, y: offset), animated: true)
        }
    }
}

