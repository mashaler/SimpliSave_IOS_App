//
//  LearnMorePageVC.swift
//  SimpliSave
//
//  Created by DA MAC M1 126 on 2023/07/21.
//

import UIKit

class LearnMorePageVC: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource  {
    
    //Adds view controllers to array for the page view diplay and functionality, 01/08/23, Shahiel
    lazy var orderedViewControllers: [UIViewController] = {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        
        let vc1 = sb.instantiateViewController(withIdentifier: "services")
        let vc2 = sb.instantiateViewController(withIdentifier: "WantsVsNeeds")
        let vc3 = sb.instantiateViewController(withIdentifier: "WhySave")
        let vc4 = sb.instantiateViewController(withIdentifier: "Benefits")
        
        return [vc1,vc2,vc3,vc4]
       }()


    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = self
        delegate = self
        
        view.backgroundColor = .white
        
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
                   
        let pageControl = UIPageControl.appearance(whenContainedInInstancesOf: [LearnMorePageVC.self])
        pageControl.pageIndicatorTintColor = .black
        pageControl.currentPageIndicatorTintColor = .purple
     
    }
    
    //sets the view controller of the previous page, 01/08/23, Shahiel
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let vcIndex = orderedViewControllers.firstIndex(of: viewController) else {return nil}
        
        let previousIndex = vcIndex - 1
        
        guard previousIndex >= 0 else {return nil}
        
        guard orderedViewControllers.count > previousIndex else {return nil}
        
        return orderedViewControllers[previousIndex]
    }
    
    //sets the view controller of the next page, 01/08/23, Shahiel
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let vcIndex = orderedViewControllers.firstIndex(of: viewController) else {return nil}
        
        let nextIndex = vcIndex + 1
        
        guard nextIndex != 0 else {return nil}
        
        guard orderedViewControllers.count > nextIndex else {return nil}
        
        return orderedViewControllers[nextIndex]
    }
    
    //gets total number of pages in page view, 01/08/23, Shahiel
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
            return orderedViewControllers.count
        }
    
    //Sets pageviews current index, 01/08/23 Shahiel
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let firstViewController = viewControllers?.first,
              let firstViewControllerIndex = orderedViewControllers.firstIndex(of: firstViewController) else {
            return 0
        }
        
        return firstViewControllerIndex
    }

}
