//
//  RulesPageViewController.swift
//  Dice Game
//
//  Created by Kavya Nirmal Shah on 3/1/23.
//

import UIKit

class RulesPageViewController: UIViewController {

    @IBOutlet weak var ClosedButtonTappedRules: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return.portrait
    }
    
    @IBAction func closeButtonTappedRules(_ sender: UIButton) {
        // Dismiss the current view controller
        dismiss(animated: true, completion: nil)
    }
    
}
