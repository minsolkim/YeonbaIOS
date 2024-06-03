import Foundation
import UIKit

final class VoiceEditDelegate: NSObject, UIViewControllerTransitioningDelegate {
    
    func presentationController(forPresented presented: UIViewController,
                                presenting: UIViewController?,
                                source: UIViewController) -> UIPresentationController? {
        return VoicePresentationController(
            presentedViewController: presented,
            presenting: presenting
        )
    }
}

