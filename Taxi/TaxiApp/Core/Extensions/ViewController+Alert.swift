//
//  ViewController+Alert.swift
//  TaxiApp
//
//  Created by Kabir Khan on 07.12.20.
//

import Foundation
import UIKit

extension UIViewController {
    
    @discardableResult
    func showAlert(title: String?, message: String?, handler: ((UIAlertAction) -> Void)? = nil) -> UIAlertController? {
        let title = title ?? ""
        let message = message ?? ""
        
        guard title.count > 0 || message.count > 0 else {
            return nil
        }
        
        let okActionInfo: [UIAlertAction.Style: String] = [.default : NSLocalizedString("ok", comment: "")]
        let cancelActionInfo: [UIAlertAction.Style: String] = [.cancel : NSLocalizedString("cancel", comment: "")]
        
        let actions = handler == nil ?  [okActionInfo] : [okActionInfo, cancelActionInfo]
        
        return self.showAlert(title: title, message: message, options: actions, preferredStyle: .alert, handler: handler)
        
    }
    
    // MARK: Alert
    
    @discardableResult
    func showAlert(title: String?, message: String?, options: [[UIAlertAction.Style: String]], preferredStyle: UIAlertController.Style, handler: ((UIAlertAction) -> Void)?) -> UIAlertController {
        
        let alertController = UIAlertController.init(title: title, message: message, preferredStyle: preferredStyle)
        
        for option in options {
            for (key, action) in option {
                let alertAction = UIAlertAction(title: action, style: key, handler: handler)
                alertController.addAction(alertAction)
            }
        }
        
        self.present(alertController, animated: true)

        return alertController
    }


}
