//
//  AuthorsPageViewController.swift
//  Dice Game
//
//  Created by Kavya Nirmal Shah on 3/1/23.
//

import UIKit

class AuthorsPageViewController: UIViewController {
    
    @IBOutlet weak var ShowAlert: UIButton!
    @IBOutlet weak var authorDesc: UITextView!
//    @IBOutlet weak var closeButtonTapped: UIButton!
    
    @IBOutlet weak var backbuttonTapped: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        authorDesc.layer.cornerRadius = 25
        authorDesc.clipsToBounds = true
        authorDesc.text = "Hello, and Welcome to my author's page!\n\nI am the creater of this app.\n I am currently pursuing a graduate degree in Computer Science.\n This is a fun and exciting dice game that's easy to play and perfect for all ages.\n The game consists of rolling two dice, and the goal is to accumulate the targetted number of points before the opponent does.\n As a deeloper of this game, I oversaw the app from start to finish and ensure that the app meets the requirements.\n Thank you for visiting my page and I hope you enjoy using the DICEEE APP:)"
        authorDesc.textColor = UIColor.init(red: 0.3843, green: 0,blue: 0.9333, alpha: 1.0)
        authorDesc.font = UIFont.preferredFont(forTextStyle: .body)
        authorDesc.textAlignment = .center
        authorDesc.adjustsFontForContentSizeCategory = true
		authorDesc.isEditable = false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return.portrait
    }
    
    @IBAction func ShowAlertButton(_ sender: UIButton) {
        let alert = UIAlertController(title: "Thank you for using this app!", message: " If you have any questions or feedback, please feel free to contact me at kshah28@syr.edu.Thank you for your support!", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func backbuttonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}
