//
//  ViewController.swift
//  PersonalityQuizHW
//
//  Created by Raymond on 04/05/21.
//

import UIKit

class WelcomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func backToViewController(to: UIStoryboardSegue) {
        
    }
    
    @IBAction func startButtonPressed(_ sender: Any) {
        print("start")
        performSegue(withIdentifier: "goToQuestions", sender: nil)
    }
    
    
    
}

