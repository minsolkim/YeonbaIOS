//
//  FavoriteVoiceDelegate.swift
//  YeonBa
//
//  Created by jin on 4/10/24.
//

import Foundation
import UIKit

final class FavoriteVoiceDelegate: NSObject, UIViewControllerTransitioningDelegate {
    
    func presentationController(forPresented presented: UIViewController,
                                presenting: UIViewController?,
                                source: UIViewController) -> UIPresentationController? {
        return FavoriteVoicePresentationController(
            presentedViewController: presented,
            presenting: presenting
        )
    }
}

