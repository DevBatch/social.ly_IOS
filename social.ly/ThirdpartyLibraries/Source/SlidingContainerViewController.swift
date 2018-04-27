
//
//  SlidingContainerViewController.swift
//  SlidingContainerViewController
//
//  Created by Cem Olcay on 10/04/15.
//  Copyright (c) 2015 Cem Olcay. All rights reserved.
//

import UIKit

public protocol SlidingContainerViewControllerDelegate: class {
  func slidingContainerViewControllerDidMoveToViewController(_ slidingContainerViewController: SlidingContainerViewController, viewController: UIViewController, atIndex: Int)
  func slidingContainerViewControllerDidHideSliderView(_ slidingContainerViewController: SlidingContainerViewController)
  func slidingContainerViewControllerDidShowSliderView(_ slidingContainerViewController: SlidingContainerViewController)
}

public class SlidingContainerViewController: UIViewController, UIScrollViewDelegate, SlidingContainerSliderViewDelegate {
  public var contentViewControllers: [UIViewController]!
  public var contentScrollView: UIScrollView!
  public var imageNames: [String]!
  public var sliderView: SlidingContainerSliderView!
  public var sliderViewShown: Bool = true
  public weak var delegate: SlidingContainerViewControllerDelegate?

  // MARK: Init

  public init (parent: UIViewController, contentViewControllers: [UIViewController], imageNames: [String]) {
    super.init(nibName: nil, bundle: nil)
    self.contentViewControllers = contentViewControllers
    self.imageNames = imageNames

    // Move to parent
    willMove(toParentViewController: parent)
    parent.addChildViewController(self)
    didMove(toParentViewController: parent)

    // Setup Views
    sliderView = SlidingContainerSliderView (width: view.frame.size.width, imagesNames: imageNames)
    sliderView.frame.origin.y = parent.topLayoutGuide.length
    sliderView.sliderDelegate = self

    var newFrame = view.frame
    newFrame.origin.y = sliderView.sliderHeight
    newFrame.size.height = view.frame.size.height - sliderView.sliderHeight - CGFloat(44.0) -  CGFloat(20.0)
    contentScrollView = UIScrollView (frame: newFrame)
    contentScrollView.showsHorizontalScrollIndicator = false
    contentScrollView.showsVerticalScrollIndicator = false
    contentScrollView.isPagingEnabled = true
    contentScrollView.scrollsToTop = false
    contentScrollView.delegate = self
    contentScrollView.contentSize.width = contentScrollView.frame.size.width * CGFloat(contentViewControllers.count)

    contentScrollView.backgroundColor = UIColor.clear
    view.addSubview(contentScrollView)
    view.addSubview(sliderView)

    // Add Child View Controllers
    var currentX: CGFloat = 0
    for vc in contentViewControllers {
      vc.view.frame = CGRect (
        x: currentX,
        y: parent.topLayoutGuide.length,
        width: view.frame.size.width,
        height: view.frame.size.height  - sliderView.sliderHeight - CGFloat(44.0) -  CGFloat(20.0)) 
      contentScrollView.addSubview(vc.view)

      currentX += contentScrollView.frame.size.width
    }

    // Move First Item
    setCurrentViewControllerAtIndex(0)
  }

  public required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)!
  }

  // MARK: Lifecycle

  public override func viewDidLoad() {
    super.viewDidLoad()
  }

  // MARK: ChildViewController Management

  public func setCurrentViewControllerAtIndex(_ index: Int) {
    for i in 0..<self.contentViewControllers.count {
      let vc = contentViewControllers[i]

      if i == index {
        vc.willMove(toParentViewController: self)
        addChildViewController(vc)
        vc.didMove(toParentViewController: self)
        delegate?.slidingContainerViewControllerDidMoveToViewController(self, viewController: vc, atIndex: index)
      } else {
        vc.willMove(toParentViewController: self)
        vc.removeFromParentViewController()
        vc.didMove(toParentViewController: self)
      }
    }

    sliderView.selectItemAtIndex(index)
    
    var offset = contentScrollView.contentOffset
    offset.x = contentScrollView.frame.size.width * CGFloat(index)
    contentScrollView.setContentOffset( offset,
                                        animated: true)

  // navigationController?.navigationItem.title = titles[index]
  }

  // MARK: SlidingContainerSliderViewDelegate

  public func slidingContainerSliderViewDidPressed(_ slidingContainerSliderView: SlidingContainerSliderView, atIndex: Int) {
    sliderView.shouldSlide = false
    setCurrentViewControllerAtIndex(atIndex)
  }

  // MARK: SliderView

  public func hideSlider() {
    guard !sliderViewShown else { return }

    UIView.animate(
      withDuration: 0.3,
      animations: { [weak self] in
        guard let this = self else { return }
        this.sliderView.frame.origin.y += this.parent!.topLayoutGuide.length + this.sliderView.frame.size.height
      }, completion: { [weak self] finished in
        guard let this = self else { return }
        this.sliderViewShown = false
        this.delegate?.slidingContainerViewControllerDidHideSliderView(this)
      })
  }

  public func showSlider() {
    guard sliderViewShown else { return }

    UIView.animate(
      withDuration: 0.3,
      animations: { [weak self] in
        guard let this = self else { return }
        this.sliderView.frame.origin.y -= this.parent!.topLayoutGuide.length + this.sliderView.frame.size.height
      }, completion: { [weak self] finished in
        guard let this = self else { return }
        this.sliderViewShown = true
        this.delegate?.slidingContainerViewControllerDidShowSliderView(this)
      })
  }

  // MARK: UIScrollViewDelegate

  public func scrollViewDidScroll(_ scrollView: UIScrollView) {
    if scrollView.panGestureRecognizer.state == .began {
      sliderView.shouldSlide = true
    }

    let contentW = contentScrollView.contentSize.width - contentScrollView.frame.size.width
    let sliderW = sliderView.contentSize.width - sliderView.frame.size.width

    let current = contentScrollView.contentOffset.x
    let ratio = current / contentW

    if sliderView.contentSize.width > sliderView.frame.size.width && sliderView.shouldSlide == true {
      sliderView.contentOffset = CGPoint (x: sliderW * ratio, y: 0)
    }
  }

  public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    let index = scrollView.contentOffset.x / contentScrollView.frame.size.width
    setCurrentViewControllerAtIndex(Int(index))
  }
}
