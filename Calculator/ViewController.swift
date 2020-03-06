//
//  ViewController.swift
//  Calculator
//
//  Created by FelixP on 06.03.20.
//  Copyright © 2020 XU Exponential University. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //indicating first or second number input
    var waitingForOperand = true
    
    //first input
    var firstNumber: Double = 0
    
    //storing the current operation
    var operand: Operator = .unset
    
    //showing the result of the calculation
    @IBOutlet weak var resultLabel: UILabel!
    
    //enumarating all possible calculations
    enum Operator{
        case unset
        case addition
        case substraction
        case multiplication
        case division
        case percentage
    }
    
    //adding number to screen and replacing text if neccessary
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
    
    //switching between plus and minus
    @IBAction func toggleMinusSign(_ sender: UIButton) {
        //text in front or not?
        if(operand != .unset){
            
            //getting index at 1
            let s = resultLabel.text
            let index = s!.index(s!.startIndex, offsetBy: 1, limitedBy: s!.endIndex)
            
            
            //is currently minus?
            if((resultLabel.text?.contains("-"))!){
                //if minus is operation, switch to addition
                if(operand == .substraction){
                    resultLabel.text?.remove(at: resultLabel.text!.startIndex)
                    resultLabel.text = "+" + resultLabel.text!
                    operand = .addition
                    
                    //else just remove minus at index 1
                }else{
                    resultLabel.text?.remove(at: index!)
                }
                
                //adding minus sign to string
            }else{
                if(operand == .substraction){
                    resultLabel.text = "-" + resultLabel.text!
                }else{
                    resultLabel.text?.insert("-", at: index!)
                }
            }
            
            //no operation set just switching between minus and no minus
        }else{
            if((resultLabel.text?.contains("-"))!){
                resultLabel.text?.remove(at: resultLabel.text!.startIndex)
            }else{
                resultLabel.text = "-" + resultLabel.text!
            }
        }
    }
    
    
    //setting operation based on tag of button
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
    
    //clearing all values and text field
    @IBAction func clear(_ sender: UIButton) {
        waitingForOperand = true
        firstNumber = 0
        resultLabel.text = "0"
        operand = .unset
    }
    
    
    //calculating the result based on the current operation
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
        
        //setting text to 0 at beginning of calculations
        resultLabel.text = "0"
        
    }
    
    
}

