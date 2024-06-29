//
//  GeneratePalletVC.swift
//  palletpreview
//
//  Created by Udaya Niroshana on 6/29/24.
//

import UIKit

class GeneratePalletVC: UIViewController{
    
    
    @IBOutlet weak var smallBoxTextField: UITextField!
    @IBOutlet weak var mediumBoxTextField: UITextField!
    @IBOutlet weak var largeBoxTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let palletVC = segue.destination as? PalletVC{
            
            let allBoxes = sender as? (small: Int, medium: Int, large: Int)
            palletVC.allBoxes = allBoxes
        }
    }
    
    @IBAction func generateButtonTapped(_ sender: Any) {
        
        guard let smallBoxCount = Int(smallBoxTextField.text ?? ""),
              let mediumBoxCount = Int(mediumBoxTextField.text ?? ""),
              let largeBoxCount = Int(largeBoxTextField.text ?? "") else {
            Alert.showError(msg: "Inavlid inputs", on: self)
            return
        }
        view.endEditing(true)
        let boxRation = (small: smallBoxCount, medium: mediumBoxCount, large: largeBoxCount)
        performSegue(withIdentifier: "palletpreviewsegue", sender: boxRation)
    }
}
