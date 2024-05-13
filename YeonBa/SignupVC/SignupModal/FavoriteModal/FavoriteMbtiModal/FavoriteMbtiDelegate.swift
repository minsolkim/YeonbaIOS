//
//  FavoriteMbtiDelegate.swift
//  YeonBa
//
//  Created by jin on 4/11/24.
//

import Foundation
import UIKit

final class FavoriteMbtiDelegate: NSObject, UIViewControllerTransitioningDelegate {
    
    func presentationController(forPresented presented: UIViewController,
                                presenting: UIViewController?,
                                source: UIViewController) -> UIPresentationController? {
        return FavoriteMbtiPresentationController(
            presentedViewController: presented,
            presenting: presenting
        )
    }
}

