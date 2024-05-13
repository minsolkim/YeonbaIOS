//
//  FavoriteAgeDelegate.swift
//  YeonBa
//
//  Created by jin on 4/11/24.
//

import Foundation
import Foundation
import UIKit

final class FavoriteAgeDelegate: NSObject, UIViewControllerTransitioningDelegate {
    
    func presentationController(forPresented presented: UIViewController,
                                presenting: UIViewController?,
                                source: UIViewController) -> UIPresentationController? {
        return FavoriteAgePresentationController(
            presentedViewController: presented,
            presenting: presenting
        )
    }
}

