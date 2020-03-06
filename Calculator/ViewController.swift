//
//  ViewController.swift
//  Calculator
//
//  Created by FelixP on 06.03.20.
//  Copyright © 2020 XU Exponential University. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var waitingForOperand = true
    var firstNumber: Double = 0
    var operand: Operator = .unset
    
    @IBOutlet weak var resultLabel: UILabel!
    
    
    enum Operator{
        case unset
        case addition
        case substraction
        case multiplication
        case division
        case percentage
    }
    
    @IBAction func numberButtonTapped(_ sender: UIButton) {
        if(resultLabel.text == "0" || waitingForOperand && String(firstNumber) == resultLabel.text){
            resultLabel.text = sender.title(for: .normal)!
        }else {
            resultLabel.text?.append(sender.title(for: .normal)!)
        }
        
        if(operand != .unset){
            waitingForOperand = false
        }
        
    }
    
    
    @IBAction func toggleMinusSign(_ sender: UIButton) {
        if(operand != .unset){
            let s = resultLabel.text
            let index = s!.index(s!.startIndex, offsetBy: 1, limitedBy: s!.endIndex)
            if((resultLabel.text?.contains("-"))!){
                if(operand == .substraction){
                    resultLabel.text?.remove(at: resultLabel.text!.startIndex)
                    resultLabel.text = "+" + resultLabel.text!
                    operand = .addition
                }else{
                    resultLabel.text?.remove(at: index!)
                }
            }else{
                if(operand == .substraction){
                    resultLabel.text = "-" + resultLabel.text!
                    operand = .substraction
                }else{
                    resultLabel.text?.insert("-", at: index!)
                }
            }
        }else{
            if((resultLabel.text?.contains("-"))!){
                resultLabel.text?.remove(at: resultLabel.text!.startIndex)
            }else{
                resultLabel.text = "-" + resultLabel.text!
            }
        }
    }
    
    @IBAction func operatorButtonTapped(_ sender: UIButton) {
        
        if waitingForOperand {
            firstNumber = (resultLabel.text! as NSString).doubleValue
            
            switch sender.tag{
            case 101:
                resultLabel.text = "+"
                operand = .addition
                break
                
            case 102:
                resultLabel.text = "-"
                operand = .substraction
                break
                
            case 103:
                resultLabel.text = "x"
                operand = .multiplication
                break
                
            case 104:
                resultLabel.text = "/"
                operand = .division
                break
                
            default:
                print("function called without button input")
            }
        }
    }
    
    @IBAction func clear(_ sender: UIButton) {
        waitingForOperand = true
        firstNumber = 0
        resultLabel.text = "0"
        operand = .unset
    }
    
    
    @IBAction func resultButtonTapped(_ sender: Any) {
        
        if(resultLabel.text!.count > 1){
            resultLabel.text?.remove(at: resultLabel.text!.startIndex)
        }
        
        switch operand {
        case .unset:
            break
            
        case .addition:
            resultLabel.text = "\(firstNumber + (resultLabel.text! as NSString).doubleValue)"
            break
            
        case .substraction:
            resultLabel.text = "\(firstNumber - (resultLabel.text! as NSString).doubleValue)"
            break
            
        case .multiplication:
            resultLabel.text = "\(firstNumber * (resultLabel.text! as NSString).doubleValue)"
            break
            
        case .division:
            resultLabel.text = "\(firstNumber / (resultLabel.text! as NSString).doubleValue)"
            
            break
            
        case .percentage:
            break
        }
        
        waitingForOperand = true
        operand = .unset
        firstNumber = (resultLabel.text! as NSString).doubleValue
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultLabel.text = "0"
        // Do any additional setup after loading the view.
        
        
    }
    
    
}

