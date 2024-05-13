//
//  FavoriteBodyViewControllerDelegate.swift
//  YeonBa
//
//  Created by jin on 4/10/24.
//

import UIKit
import SnapKit
import Then

import Foundation
import UIKit

final class FavoriteBodyViewControllerDelegate: NSObject, UIViewControllerTransitioningDelegate {
    
    func presentationController(forPresented presented: UIViewController,
                                presenting: UIViewController?,
                                source: UIViewController) -> UIPresentationController? {
        return FavoriteBodyPresentationController(
            presentedViewController: presented,
            presenting: presenting
        )
    }
}

