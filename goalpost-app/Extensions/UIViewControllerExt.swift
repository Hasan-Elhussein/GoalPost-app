//
//  UIViewControllerExt.swift
//  goalpost-app
//
//  Created by Hasan Elhussein on 20.08.2021.
//

import UIKit

// This Extension will be used to modify the default animation that happens when presenting a ViewController.

extension UIViewController {
    // Show the ViewController using the (Push from right to left) animation.
    func presentDetail(_ viewControllerToPresent: UIViewController) {
        let transition = CATransition()
        // Setting the data of the transition.
        transition.duration = 0.3
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        // Apply the animation to the layer of the given ViewController.
        self.view.window?.layer.add(transition, forKey: kCATransition)
        present(viewControllerToPresent, animated: false, completion: nil)
    }
    
    func presentSecondaryDetail(_ viewControllerToPresent: UIViewController) {
        let transition = CATransition()
        // Setting the data of the transition.
        transition.duration = 0.3
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        // Dismiss the current ViewController while transitioning to the next one.
        guard let presentedViewController = presentedViewController else { return }
        presentedViewController.dismiss(animated: false) {
            self.view.window?.layer.add(transition, forKey: kCATransition)
            self.present(viewControllerToPresent, animated: false, completion: nil)
        }
    }
    
    // Dismiss the ViewController using the (Push from left to right) animation.
    func dismissDetail() {
        let transition = CATransition()
        // Setting the data of the transition.
        transition.duration = 0.3
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        // Apply the animation to the layer of the given ViewController.
        self.view.window?.layer.add(transition, forKey: kCATransition)
        dismiss(animated: false, completion: nil)
        
    }
}
