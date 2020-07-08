//
//  Calculator.swift
//  mobile-app-dev-hw1
//
//  Created by Abbe♡ on 2020/4/24.
//  Copyright © 2020 NTNU. All rights reserved.
//

import Foundation

class Calculator
{
    private(set) var displayStr = "0"
    private var curNum:Double = 0.0
    private var preNum:Double = 0.0
    private var isPerformOp = false
    private var operation = ""
    
    private func performOp() {
        var result = curNum
        switch operation {
        case "+":
            result = preNum + curNum
        case "-":
            result = preNum - curNum
        case "X":
            result = preNum * curNum
        case "/":
            if curNum != 0.0 {
                result = preNum / curNum
            }
        case "%":
            result = curNum / 100
        case "+/-":
            result = -curNum
        default:
            break
        }
        curNum = result
        displayStr = String(curNum)
        operation = ""
    }
    
    func touch(btn btnText: String) {
        switch btnText {
        case "C":
            displayStr = "0"
            curNum = 0.0
            preNum = 0.0
            isPerformOp = false
            operation = ""
        case "+/-", "%":
            if curNum != 0 && curNum == Double(displayStr) {
                operation = btnText
                performOp()
            }
        case "+", "-", "X", "/":
            if displayStr != "" {
                if operation != "" {
                    performOp()
                }
                preNum = curNum
                operation = btnText
                displayStr = btnText
                isPerformOp = true
            }
        case "=":
            performOp()
        default: // numbers
            if isPerformOp {
                displayStr = btnText
                curNum = Double(btnText)!
                isPerformOp = false
            } else {
                if displayStr == "0" && btnText != "." {
                    displayStr = btnText
                } else {
                    displayStr += btnText
                }
                curNum = Double(displayStr)!
            }
        }
    }

    func PrintDbgInfo() {
        print("displayStr=", displayStr)
        print("curNum=", curNum)
        print("preNum=", preNum)
        print("isPerformOp=", isPerformOp)
        print("operation=", operation)
    }
    
}
