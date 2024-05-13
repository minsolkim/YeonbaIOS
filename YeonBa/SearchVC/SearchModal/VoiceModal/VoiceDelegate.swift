//
//  VoiceDelegate.swift
//  YeonBa
//
//  Created by 김민솔 on 3/30/24.
//

import Foundation
import UIKit

final class VoiceDelegate: NSObject, UIViewControllerTransitioningDelegate {
    
    func presentationController(forPresented presented: UIViewController,
                                presenting: UIViewController?,
                                source: UIViewController) -> UIPresentationController? {
        return VoicePresentationController(
            presentedViewController: presented,
            presenting: presenting
        )
    }
}

