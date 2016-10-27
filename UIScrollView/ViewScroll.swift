//
//  ViewScroll.swift
//  UIScrollView
//
//  Created by admin on 10/27/2016.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class ViewScroll: UIViewController, UIScrollViewDelegate, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var pageController: UIPageControl!
    @IBOutlet weak var scrollView: UIScrollView!
    var photo = UIImageView()
    var pageImages : [String] = []
    var first = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        
        pageImages = ["shop1-0","shop1-1","shop1-2"]
        pageController.currentPage = 0
        pageController.numberOfPages = pageImages.count
        scrollView.minimumZoomScale = 0.5
        scrollView.maximumZoomScale = 2
        
    }
    
    override func viewDidLayoutSubviews() {
        if (!first) {
            first = true
            let pagesScrollViewSize = scrollView.frame.size
            scrollView.contentSize = CGSize(width: pagesScrollViewSize.width * CGFloat(pageImages.count), height: 0)
        
            for i in 0..<pageImages.count {
                let imgView = UIImageView(image: UIImage(named: pageImages[i] + ".jpg"))
                imgView.frame = CGRect(x: CGFloat(i) * scrollView.frame.size.width, y: 0, width: scrollView.frame.size.width, height: scrollView.frame.size.height)
                imgView.contentMode = .scaleAspectFit
                if (i == 0) {
                    photo = imgView
                }
                
                self.scrollView.addSubview(imgView)
            }
        }

    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return photo
    }
    
    func tapImg(gesture : UITapGestureRecognizer) {
        let position = gesture.location(in: photo)
        zoomRectForScale(scale: scrollView.zoomScale * 1.5, center: position)
        
    }
    
    func doubleTapImg(gesture : UITapGestureRecognizer) {
        let position = gesture.location(in: photo)
        zoomRectForScale(scale: scrollView.zoomScale * 0.5, center: position)
    }
    
    func zoomRectForScale(scale : CGFloat, center : CGPoint) {
        var zoomRect = CGRect()
        let scrollViewSize = scrollView.bounds.size
        zoomRect.size.height = scrollViewSize.height / scale
        zoomRect.size.width = scrollViewSize.width / scale
        
        zoomRect.origin.x = center.x - (zoomRect.size.width / 2.0)
        zoomRect.origin.y = center.y - (zoomRect.size.height / 2.0)
        
        scrollView.zoom(to: zoomRect, animated: true)
    }
    
    @IBAction func onChange(_ sender: UIPageControl) {
        scrollView.contentOffset = CGPoint(x: CGFloat(pageController.currentPage) * scrollView.frame.size.width, y: 0)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageController.currentPage = Int(scrollView.contentOffset.x/scrollView.frame.size.width)
    }

}
