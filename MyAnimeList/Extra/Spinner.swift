//
//  Spinner.swift
//  MyAnimeList
//
//  Created by William Wang on 2020-01-08.
//  Copyright © 2020 William Wang. All rights reserved.
//

import UIKit

var vSpinner : UIView?

extension UIViewController {
    func showSpinner(onView : UIView) {
        self.view.isUserInteractionEnabled = false
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: UIActivityIndicatorView.Style.large)
        ai.startAnimating()
        ai.center = spinnerView.center

        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }

        vSpinner = spinnerView
    }

    func removeSpinner() {
        DispatchQueue.main.async {
            self.view.isUserInteractionEnabled = true
            vSpinner?.removeFromSuperview()
            vSpinner = nil
        }
    }
}
