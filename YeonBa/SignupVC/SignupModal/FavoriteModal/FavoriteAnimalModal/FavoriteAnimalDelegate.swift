//
//  FavoriteAnimalDelegate.swift
//  YeonBa
//
//  Created by jin on 4/10/24.
//

import Foundation
import UIKit

final class FavoriteAnimalDelegate: NSObject, UIViewControllerTransitioningDelegate {
    
    func presentationController(forPresented presented: UIViewController,
                                presenting: UIViewController?,
                                source: UIViewController) -> UIPresentationController? {
        return FavoriteAnimalPresentationController(
            presentedViewController: presented,
            presenting: presenting
        )
    }
}

