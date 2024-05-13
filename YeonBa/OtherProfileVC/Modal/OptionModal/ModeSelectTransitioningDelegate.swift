//
//  ModeSelectTransitioningDelegate.swift
//  YeonBa
//
//  Created by 김민솔 on 3/28/24.
//

import Foundation
import UIKit

final class ModeSelectTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {
    
    func presentationController(forPresented presented: UIViewController,
                                presenting: UIViewController?,
                                source: UIViewController) -> UIPresentationController? {
        return ModeSelectPresentationController(
            presentedViewController: presented,
            presenting: presenting
        )
    }
}
