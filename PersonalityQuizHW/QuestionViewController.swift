//
//  QuestionViewController.swift
//  PersonalityQuizHW
//
//  Created by Raymond on 05/05/21.
//

import UIKit

class QuestionViewController: UIViewController {

    var question_index = 0
    var answersChosen: [Answer] = []
    @IBOutlet weak var stack_button: UIStackView!
    @IBOutlet weak var stack_slider: UIStackView!
    @IBOutlet weak var stack_multi: UIStackView!
    
    @IBOutlet weak var btn_1: UIButton!
    @IBOutlet weak var btn_2: UIButton!
    @IBOutlet weak var btn_3: UIButton!
    @IBOutlet weak var btn_4: UIButton!
    
    @IBOutlet weak var multi_1: UILabel!
    @IBOutlet weak var multi_2: UILabel!
    @IBOutlet weak var multi_3: UILabel!
    @IBOutlet weak var multi_4: UILabel!
    
    @IBOutlet weak var switch_1: UISwitch!
    @IBOutlet weak var switch_2: UISwitch!
    @IBOutlet weak var switch_3: UISwitch!
    @IBOutlet weak var switch_4: UISwitch!
    
    
    @IBOutlet weak var slider_label_left: UILabel!
    @IBOutlet weak var slider_label_right: UILabel!
    @IBOutlet weak var slider_answer: UISlider!
    
    @IBOutlet weak var progress_bar: UIProgressView!
    
    @IBOutlet weak var question_label: UILabel!
    var questions: [Question] = [
        Question(text: "Which food do you like the most?",
                 type:.single,
                 answers: [
                    Answer(text: "Steak", type: .dog),
                    Answer(text: "Fish", type: .cat),
                    Answer(text: "Carrots", type: .rabbit),
                    Answer(text: "Corn", type: .turtle)
                ]),
        Question(text: "Which activities do you enjoy?",
                     type: .multiple,
                     answers: [
                        Answer(text: "Swimming", type: .turtle),
                        Answer(text: "Sleeping", type: .cat),
                        Answer(text: "Cuddling", type: .rabbit),
                        Answer(text: "Eating", type: .dog)
                    ]),
        Question(text: "How much do you enjoy car rides?",
                 type: .ranged,
                 answers: [
                    Answer(text: "I dislike them", type: .cat),
                    Answer(text: "I get a little nervous",
                          type: .rabbit),
                    Answer(text: "I barely notice them",
                          type: .turtle),
                    Answer(text: "I love them", type: .dog)
                ])
        ]
        

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()

        // Do any additional setup after loading the view.
    }
    
    func updateUI() {
        stack_button.isHidden = true
        stack_multi.isHidden = true
        stack_slider.isHidden = true
    
        navigationItem.title = "Question #\(question_index+1)"
    
        let currentQuestion = questions[question_index]
        let currentAnswers = currentQuestion.answers
        let totalProgress = Float(question_index) / Float(questions.count)

        navigationItem.title = "Question #\(question_index+1)"
        question_label.text = currentQuestion.text
        progress_bar.setProgress(totalProgress, animated:true)
        

        switch currentQuestion.type {
            case .single:
                print("\n\n\n\n GOTO SINGLE \n\n")
                updateSingleStack(using: currentAnswers)
            case .multiple:
                print("\n\n\n\n GOTO SINGLE \n\n")
                updateMultipleStack(using: currentAnswers)
            case .ranged:
                print("\n\n\n\n GOTO SINGLE \n\n")
                updateRangedStack(using: currentAnswers)

        }
        

    }
    
    func updateSingleStack(using answers: [Answer]) {
        stack_button.isHidden = false
        btn_1.setTitle(answers[0].text, for: .normal)
        btn_2.setTitle(answers[1].text, for: .normal)
        btn_3.setTitle(answers[2].text, for: .normal)
        btn_4.setTitle(answers[3].text, for: .normal)
    }
    
    func updateMultipleStack(using answers: [Answer]) {
        stack_multi.isHidden = false
        switch_1.isOn = false
        switch_2.isOn = false
        switch_3.isOn = false
        switch_4.isOn = false
        multi_1.text = answers[0].text
        multi_2.text = answers[1].text
        multi_3.text = answers[2].text
        multi_4.text = answers[3].text
    }
    
    func updateRangedStack(using answers: [Answer]) {
        stack_slider.isHidden = false
        slider_answer.setValue(0.5, animated: false)
        slider_label_left.text = answers.first?.text
        slider_label_right.text = answers.last?.text
    }
    
    @IBAction func singleAnswerButtonPressed(_ sender: UIButton) {
        let currentAnswers = questions[question_index].answers

        switch sender {
            case btn_1:
                answersChosen.append(currentAnswers[0])
            case btn_2:
                answersChosen.append(currentAnswers[1])
            case btn_3:
                answersChosen.append(currentAnswers[2])
            case btn_4:
                answersChosen.append(currentAnswers[3])
            default:
                break
        }
        nextQuestion()
    }
    
    @IBAction func switchPressed(_ sender: Any) {
        let currentAnswers = questions[question_index].answers
        
        if switch_1.isOn {
            answersChosen.append(currentAnswers[0])
        }
        if switch_2.isOn {
            answersChosen.append(currentAnswers[1])
        }
        if switch_3.isOn {
            answersChosen.append(currentAnswers[2])
        }
        if switch_4.isOn {
            answersChosen.append(currentAnswers[3])
        }
        
        nextQuestion()
        
    }
    
    
    @IBAction func submitSliderPressed(_ sender: Any) {
        let currentAnswers = questions[question_index].answers
        let index = Int(round(slider_answer.value * Float(currentAnswers.count - 1)))
        answersChosen.append(currentAnswers[index])
        nextQuestion()
    }
    
    func nextQuestion() {
        question_index += 1
        if question_index < questions.count {
            updateUI()
        } else {
          performSegue(withIdentifier: "ResultsSegue", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ResultsSegue" {
            let my_segue = segue.destination as! ResultsViewController
            my_segue.responses = answersChosen
            
        }
    }
    
    @IBAction func unwindToQeustionViewController(to: UIStoryboardSegue) {
        
    }
    
} //class closer
