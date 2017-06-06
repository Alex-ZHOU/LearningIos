//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by AlexZHOU on 04/06/2017.
//  Copyright © 2017 AlexZHOU. All rights reserved.
//

import Foundation

class CalculatorBrain{
    
    private enum Op: CustomStringConvertible {
        case Operand(Double)
        case UnaryOperation(String, (Double) -> Double)
        case BinaryOperation(String, (Double, Double) -> Double)
        
        var description: String {
            get{
                switch self {
                case .Operand(let operand):
                    return "\(operand)"
                case .UnaryOperation(let symbol, _):
                    return symbol
                case .BinaryOperation(let symbol, _):
                    return symbol
                }
            }
        }
    }
    
    private var opStack = [Op]()
    // 完全相同，只是语法不同
    // var opStack = Array<Op>()
    
    private var knownOps = [String:Op]()
    // 完全相同，只是语法不同
    // var knownOps = Dictionary<String, Op>()
    
    public init() {
        knownOps["×"] = Op.BinaryOperation("×", { $0 * $1 })
        knownOps["÷"] = Op.BinaryOperation("÷", { $1 / $0 })
        knownOps["+"] = Op.BinaryOperation("+", +)
        knownOps["−"] = Op.BinaryOperation("−") { $1 - $0 }
        knownOps["√"] = Op.UnaryOperation("√", sqrt)
        // 完全相同，只是语法不同
        // knownOps["√"] = Op.UnaryOperation("√"){ sqrt($0) }
    }
    
    private func evaluate(ops: [Op]) -> (result: Double?, remainingOps: [Op]) {
        var remainingOps = ops
        let op = remainingOps.removeLast()
        switch op {
        case .Operand(let operand):
            return (operand, remainingOps)
        case .UnaryOperation(_, let operation):
            let operandEvaluate = evaluate(ops: remainingOps)
            if let operand = operandEvaluate.result {
                return (operation(operand), operandEvaluate.remainingOps)
            }
        case .BinaryOperation(_, let operation):
            let operandEvaluate1 = evaluate(ops: remainingOps)
            
            if let operand1 =  operandEvaluate1.result {
                let operandEvaluate2 = evaluate(ops: operandEvaluate1.remainingOps)
                if let operand2 = operandEvaluate2.result {
                    return (operation(operand1, operand2),operandEvaluate2.remainingOps)
                }
            }
        }
        return (nil, ops)
    }
    
    public func evaluate() -> Double? {
        print(opStack)
        let (result, _) = evaluate(ops: opStack)
        return result
    }
    
    public func pushOperand(operand: Double) -> Double? {
        opStack.append(Op.Operand(operand))
        return evaluate()
    }
    
    public func performOperation(symbol: String) -> Double? {
        if let operation = knownOps[symbol] {
            opStack.append(operation)
        }
        return evaluate()
    }
    
}
