//
//  ViewController.swift
//  Dice Game
//
//  Created by user237607 on 2/25/23.
//

import UIKit


class ViewController: UIViewController {
    
    @IBOutlet weak var diceGameTitle: UILabel!
    
    @IBOutlet weak var PlayButton: UIButton!
    
    @IBOutlet weak var Player1_Dice_1: UIImageView!
    
    @IBOutlet weak var Player1_Dice_2: UIImageView!
    
    @IBOutlet weak var Player2_Dice_1: UIImageView!
    
    @IBOutlet weak var Player2_Dice_2: UIImageView!
    
    @IBOutlet weak var StepperRound: UIStackView!
    
    @IBOutlet weak var Score_player1: UILabel!
    
    @IBOutlet weak var SetTarget: UILabel!
    
    @IBOutlet weak var Score_player2: UILabel!
    
    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var Stepper: UIStepper!
    @IBOutlet weak var StepperRoundText: UILabel!
    @IBOutlet weak var RoundsLabel: UILabel!
    
    
    
    
    // Variable Declarations
    var images = ["dice_1","dice_2","dice_3","dice_4","dice_5","dice_6"]
    var score_player1 = 0 // score of player 1
    var score_player2 = 0 // score of player 2
    var targetScore = 0 // target score set by the player before starting the game
    var bonus_points = 2 // add bonus in certain situation
    var round = 0 // current round
    var setround = 0 // set the targeted round
    let magic_combinations = [[4,2],[3,5],[3,4],[1,3],[2,0],[0,4]]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return.portrait
    }
    
    
    @IBAction func PlayButton(_ sender: UIButton) {
        
        
        
        //       Calling the set functions to set the rounds and target score
        setTargetScore()
        setStepperRound()
        
        
        Stepper.isEnabled = false
        slider.isEnabled = false
        
        
        
        // UpdateRounds
        updateRounds()
        
        
        // Rolling the Dice
        PlayButton.setTitle("Roll", for: .normal)
        let a = Int.random(in: 0...5)
        let b = Int.random(in: 0...5)
        let c = Int.random(in: 0...5)
        let d = Int.random(in: 0...5)
        Player1_Dice_1.image = UIImage(named: images[a])
        Player1_Dice_2.image = UIImage(named: images[b])
        Player2_Dice_1.image = UIImage(named: images[c])
        Player2_Dice_2.image = UIImage(named: images[d])
        
        // Rules:
        // 1. If 1 and 1 occures on both the dice of any player then that player automatically wins the game
        
        if(a == 0 && b == 0){
            
            player_1_wins()
        }
        else if (c == 0 && d == 0){
            
            player_2_wins()
        }
        
        // 2. if the dice get the numbers from the magic combination then that player wil get a bonus of 5 points
        if ( a == b || c == d)
        {
            if (c == d && a == b)
            {
                score_player1 += 5
                score_player2 += 5
            }
            else if (c == d)
            {
                score_player2 += 5
            }
            
            else
            {
                score_player1 += 5
            }
        }
        
        // 3. If the oth the dice of a player include certain combinations then that player will get extra points
        if (magic_combinations.contains([a,b]) || magic_combinations.contains([c,d]))
        {
            if (magic_combinations.contains([a,b]) && magic_combinations.contains([c,d]))
            {
                score_player1 += 3
                score_player2 += 3
            }
            else if (magic_combinations.contains([a,b]))
            {
                score_player1 += 3
            }
            
            else{
                score_player2 += 3
            }
        }
        
        // Update scores of players after rolling:
        
        if(round == 0)
        {
            score_player1 = 0
            score_player2 = 0
        }
        else
        {
            score_player1 = score_player1 + a + 1 + b + 1
            score_player2 = score_player2 + c + 1 + d + 1
        }
        
        Score_player1.text = "Score: \(score_player1) / \(targetScore)"
        Score_player2.text = "Score: \(score_player2) / \(targetScore)"
        
        
        // who wins the game
        if(score_player1 >= targetScore || score_player2 >= targetScore)
        {
            who_wins_the_game()
        }
        
    }
    
    func dont_start(){
        let alert = UIAlertController(title: "Sorry!", message:"Please set Rounds and Targetted Score", preferredStyle: .alert)
        let backtogame = UIAlertAction(title: "Ok",   style: .default)
        alert.addAction(backtogame)
        self.present(alert,animated: true, completion: nil)
    }
    // Update number of Rounds
    func updateRounds()
    {
        if (round < setround){
            round += 1
            RoundsLabel.text = "Round: \(round)"
        }
        else {
            no_of_rounds_complete_alert()
            
        }
    }
    
    
    //    set target score using slider
    func setTargetScore() {
        SetTarget.text = "Set Target Score: \(targetScore)"
    }
    
    //  Set target Score function
    @IBAction func targetSlider(_ sender : UISlider)
    {
        targetScore = Int(sender.value)
        setTargetScore()
    }
    
    
    
    
    // set rounds using the stepper
    func setStepperRound(){
        StepperRoundText.text = "Set Number of Rounds: \(setround)"
        
    }
    // set number of rounds using a Stepper
    @IBAction func RoundStepper(_ sender : UIStepper)
    {
        setround = Int(sender.value)
        setStepperRound()
        
    }
    
    
    
    // cant update alert:
    func cant_update_alert(){
        let alert = UIAlertController(title: "Soory!", message:"You cannot change the number of rounds or target score during the game!", preferredStyle: .alert)
        let backtogame = UIAlertAction(title: "Ok",   style: .default)
        alert.addAction(backtogame)
        self.present(alert,animated: true, completion: nil)
    }
    
    
    
    // Restart Button: After clicking the restart button an alert will show up which will ask the players whether they want to continue the game or restart it
    
    @IBAction func ReplayButton(_ sender: UIButton) {
        let alert = UIAlertController(title: "Are you sure you want to restart?", message: "", preferredStyle: .alert)
        //      By clicking the Yes button, the game will start fresh
        let action = UIAlertAction(title: "Yes", style: .default, handler: {(action) -> Void in self.start_new_game()})
        //      By clicking the No button, the game will continue from where it was left
        let cancelaction = UIAlertAction(title: "Quit", style: .default){ _ in
            exit(0)
        }
        alert.addAction(action)
        alert.addAction(cancelaction)
        present(alert, animated: true, completion: nil)
    }
    
    func start_new_game(){
        score_player1 = 0
        score_player2 = 0
        targetScore = 10
        round = 0
        setround = 0 // set the targeted round
        updateScoreSlidder()
        updatetargetScoreLabel()
        updateroundslabel()
        setStepperRound()
        Stepper.isEnabled = true
        slider.isEnabled = true
    }
    
    
    // Update the Rounds label after restarting the game
    func updateroundslabel()
    {
        Score_player1.text = String("Score: \(score_player1)" )
        Score_player2.text = String("Score: \(score_player2)")
        RoundsLabel.text = String("Rounds \(round)")
    }
    // Update the target score label after restarting the game
    func updatetargetScoreLabel()
    {
        SetTarget.text = String("Set target Score : ")
    }
    
    // Update the target score label after restarting the game
    func updatestepperroundLabel()
    {
        StepperRoundText.text = String("Set Number of Rounds: ")
    }
    
    // Update the Scores label after restarting the game
    func updateScoreSlidder()
    {
        slider.value = 10
    }
    
    //Update stepper label after restarting the game
    func updateroundStepperLabel()
    {
        slider.value = 0
    }
    
    
    func who_wins_the_game(){
        if(score_player1 >= targetScore && score_player1 > score_player2)
        {
            player_1_wins()
        }
        
        else if (score_player1 >= targetScore && score_player2 >= targetScore)
        {
            its_a_tie()
        }
        
        else{
            player_2_wins()
        }
    }
    
    func player_1_wins()
    {
        let alert = UIAlertController(title: "Congratulations", message: "Player 1 Won the Game\n Do you want to restart?", preferredStyle: .alert)
        let action = UIAlertAction(title: "Yes", style: .default, handler: {(action) -> Void in self.start_new_game()})
        //      By clicking the No button, the game will continue from where it was left
        let cancelaction = UIAlertAction(title: "Quit", style: .default){ _ in
            exit(0)
        }
        alert.addAction(action)
        alert.addAction(cancelaction)
        present(alert, animated: true, completion: nil)
    }
    
    func player_2_wins()
    {
        let alert = UIAlertController(title: "Congratulations", message: "Player 2 Won the Game\n Do you want to restart?", preferredStyle: .alert)
        let action = UIAlertAction(title: "Yes", style: .default, handler: {(action) -> Void in self.start_new_game()})
        //      By clicking the No button, the game will continue from where it was left
        let cancelaction = UIAlertAction(title: "Quit", style: .default){ _ in
            exit(0)
        }
        alert.addAction(action)
        alert.addAction(cancelaction)
        present(alert, animated: true, completion: nil)
    }
    
    func its_a_tie()
    {
        let alert = UIAlertController(title: "Yayyyy!", message: "It's a Tie\nDo you want to restart?", preferredStyle: .alert)
        let action = UIAlertAction(title: "Yes", style: .default, handler: {(action) -> Void in self.start_new_game()})
        //      By clicking the No button, the game will continue from where it was left
        let cancelaction = UIAlertAction(title: "Quit", style: .default){ _ in
            exit(0)
        }
        alert.addAction(action)
        alert.addAction(cancelaction)
        present(alert, animated: true, completion: nil)
    }
    
    func no_of_rounds_complete_alert()
    {
        let alert = UIAlertController(title: "Opps! Number of rounds completed", message: "Would you like to Restart the Game? ", preferredStyle: .alert)
        //      By clicking the Yes button, the game will start fresh
        let action = UIAlertAction(title: "Yes", style: .default, handler: {(action) -> Void in self.start_new_game()})
        //      By clicking the No button, the game will continue from where it was left
        let cancelaction = UIAlertAction(title: "Quit", style: .default){ _ in
            exit(0)
        }
        alert.addAction(action)
        alert.addAction(cancelaction)
        present(alert, animated: true, completion: nil)
    }
    
    
}




