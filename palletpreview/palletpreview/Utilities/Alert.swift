//
//  Alert.swift
//  palletpreview
//
//  Created by Udaya Niroshana on 6/29/24.
//

import Foundation
import UIKit

struct Alert{
    
    private static let DEFAULT_ERROR_MESSAGE_TITLE = "Error"
    
    private static func showBasicAlert(on vc:UIViewController, with title: String, message: String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        DispatchQueue.main.async { vc.present(alert, animated: true, completion: nil) }
    }
    
    static func showError(msg: String,on vc:UIViewController){
        
        showBasicAlert(on: vc, with: DEFAULT_ERROR_MESSAGE_TITLE, message: msg)
    }
}
