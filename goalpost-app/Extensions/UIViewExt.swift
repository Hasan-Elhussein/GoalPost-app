//
//  UIViewExt.swift
//  goalpost-app
//
//  Created by Hasan Elhussein on 20.08.2021.
//

import UIKit

// This extension will be used to allow the buttons to always stay on top of the keyboard.

extension UIView {
    // Defining the function that we will call to bind an object to the keyboard.
    func bindToKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(_:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @objc func keyboardWillChange(_ notification: NSNotification) {
        // Getting all the data about the keyboard animation (duration, curve, beginning and ending frames).
        let duration = notification.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
        let curve = notification.userInfo![UIResponder.keyboardAnimationCurveUserInfoKey] as! UInt
        let beginningFrame = (notification.userInfo![UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        let endingFrame = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        // Calculating the difference between the height of the ending frame and the beginning frame.
        let deltaY = endingFrame.origin.y - beginningFrame.origin.y
        
        // Calling the animateKeyframes functions using the data we got.
        UIView.animateKeyframes(withDuration: duration, delay: 0.0, options: KeyframeAnimationOptions(rawValue: curve), animations: {
            // New Y value = origing Y value + deltaY
            self.frame.origin.y += deltaY
        }, completion: nil)
    }
}

