//
//  FavoriteTallDelegate.swift
//  YeonBa
//
//  Created by jin on 4/15/24.
//

import Foundation
import Foundation
import UIKit

final class FavoriteTallDelegate: NSObject, UIViewControllerTransitioningDelegate {
    
    func presentationController(forPresented presented: UIViewController,
                                presenting: UIViewController?,
                                source: UIViewController) -> UIPresentationController? {
        return FavoriteTallPresentationController(
            presentedViewController: presented,
            presenting: presenting
        )
    }
}

