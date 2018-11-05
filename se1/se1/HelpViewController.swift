//
//  HelpViewController.swift
//  r2
//
//  Created by Benny Pollak on 6/7/18.
//  Copyright © 2018 Alben Software. All rights reserved.
//
// http://www.seemuapps.com/page-view-controller-tutorial-with-page-dots
import UIKit

class HelpViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    var pageControl = UIPageControl()
    let pageCount = HelpContentViewController.pageCount
    var orderedViewControllers:[UIViewController] = []
    let mainViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HelpContentViewController") as! HelpContentViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.dataSource = self
        self.delegate = self
        
//        mainViewController.itemIndex = 1
        // This sets up the first view that will show up on our page control
//        setViewControllers([mainViewController],
//                           direction: .forward,
//                           animated: true,
//                           completion: nil)
        configurePageControl()
        for i in 0..<pageCount {
            let vc = newVc(viewController: "HelpContentViewController") as!HelpContentViewController
            vc.itemIndex = i
            vc.pageController = self
            orderedViewControllers.append(vc)
        }
        setViewControllers([orderedViewControllers[0]],
                           direction: .forward,
                           animated: true,
                           completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func flip(direction:Int) {
        guard let currentViewController = self.viewControllers?.first else { return }
        if direction ==  1 {
            guard let nextViewController = dataSource?.pageViewController( self, viewControllerAfter: currentViewController ) else { return }
            setViewControllers([nextViewController], direction: .forward, animated: false, completion: nil)
        } else {
            guard let previousViewController = dataSource?.pageViewController( self, viewControllerBefore: currentViewController ) else { return }
            setViewControllers([previousViewController], direction: .reverse, animated: false, completion: nil)
        }
    }
    func newVc(viewController: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: viewController)
    }
    // MARK: Delegate methords
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let pageContentViewController = pageViewController.viewControllers![0]
        self.pageControl.currentPage = orderedViewControllers.index(of: pageContentViewController)!
    }
    
    
    // MARK: - Data source functions.
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
//        let viewControllerIndex = mainViewController.itemIndex
//        let previousIndex = viewControllerIndex - 1
//        return pageTo(index: previousIndex)
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        // User is on the first view controller and swiped left to loop to
        // the last view controller.
        guard previousIndex >= 0 else {
            //            return orderedViewControllers.last
            // Uncommment the line below, remove the line above if you don't want the page control to loop.
            return nil
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
//        let viewControllerIndex = mainViewController.itemIndex
//        let nextIndex = viewControllerIndex + 1
//        return pageTo(index: nextIndex)
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        // User is on the last view controller and swiped right to loop to
        // the first view controller.
        guard orderedViewControllersCount != nextIndex else {
//            return orderedViewControllers.first
             return nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        self.pageControl.currentPage = nextIndex
        return orderedViewControllers[nextIndex]
    }
//    func pageTo(index:Int) -> UIViewController? {
//        if index < 0 || index > pageCount {
//            return nil
//        }
//        mainViewController.itemIndex = index
//        return viewControllers[index]
//    }
    
    func configurePageControl() {
        // The total number of pages that are available is based on how many available colors we have.
        pageControl = UIPageControl(frame: CGRect(x: 0,y: UIScreen.main.bounds.maxY - 50,width: UIScreen.main.bounds.width,height: 50))
        self.pageControl.numberOfPages = pageCount
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = .blue
        self.pageControl.pageIndicatorTintColor = .lightGray
        self.pageControl.currentPageIndicatorTintColor = .black
        self.view.addSubview(pageControl)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
