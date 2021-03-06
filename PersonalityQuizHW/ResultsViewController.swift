//
//  ResultsViewController.swift
//  PersonalityQuizHW
//
//  Created by Raymond on 09/05/21.
//

import UIKit

class ResultsViewController: UIViewController {
    var responses: [Answer]!
    @IBOutlet weak var resultAnswerLabel: UILabel!
    @IBOutlet weak var resultAnswerDesc: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        calculatePersonalityResult()
        navigationItem.hidesBackButton = true
        // Do any additional setup after loading the view.
    }
    
    func calculatePersonalityResult() {
        var frequencyOfAnswers: [AnimalType: Int] = [:]
        let responseTypes = responses.map {$0.type}
        
        for response in responseTypes {
            frequencyOfAnswers[response] = (frequencyOfAnswers[response] ?? 0) + 1
        }
        
        let frequentAnswersSorted = frequencyOfAnswers.sorted(by: { (pair1, pair2) -> Bool in
            return pair1.value > pair2.value
        })

        let mostCommonAnswer = frequentAnswersSorted.first!.key
        
        resultAnswerLabel.text = "You are a \(mostCommonAnswer.rawValue)!"
        resultAnswerDesc.text = mostCommonAnswer.definition
        
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
