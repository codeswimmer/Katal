//
//  Katal.swift
//  KatalDesktop
//
//  Created by Keith Ermel on 10/5/14.
//  Copyright (c) 2014 Keith Ermel. All rights reserved.
//

import Foundation

// MARK: Global types
typealias SwiftClosure = ()->Void


// MARK: Generic Transformers
func transform<T>(input: T, operation: (T)->T) -> T {return operation(input)}

// where output == input (output is same type as input, but it may be changed)
protocol IdentityTransformer {
    typealias TransformationType
    func perform(TransformationType) -> TransformationType
}

// where output != input (output may not be same type as input, may be changed)
protocol MutatingTransformer {
    typealias InputType
    typealias OutputType
    func perform(InputType) -> OutputType
}



class Katal: IdentityTransformer {
    
    func perform(input: String) -> String {return transform(input, parseAndExecute)}
    
    private func parseAndExecute(input: String) -> String {
        println(">>>: \(input)")
        
        func foo(c: Character) {
            println(": \(c)")
            parser.perform(c)
        }
        
        parser.begin()
        
        let actionInput = (input, foo)
        let result = stringWalker.perform(actionInput)
        println("result: \(result)")
        
        return "parse.and.execute"
    }
    
    let stringWalker = StringWalker()
    let parser = Parser()
}

// immutable
class ParserState {
    
    init(_ value: String) {
        self.value = value
    }
    
    let value: String
    
//    class func with(string: String) -> ParserState {
//        if let v = Value(rawValue: string) {return ParserState(v)}
//        return ParserState(Value.unknown)
//    }
//    
//    class func with(value: Value) -> ParserState {return ParserState(value)}
//    
//    init(_ value: Value) {self.value = value}
//    
//    enum Value: String {
//        case begin = "begin"
//        case end = "end"
//        case unknown = "unknown"
//    }
//    
//    let value: Value
}

class ParserStateTransformer: MutatingTransformer {
    
    func perform(charIn: Character) -> ParserState {
        println("charIn: \(charIn)")
        var result = ParserState(Op.unknown.rawValue)
        
//        if let rule = rules[Op.transformerBegin.rawValue] as? ParserRule {
//            println("rule: \(rule)")
//            result = rule.perform(charIn)
//        }
        
        let x = rules[Op.begin.characterValue]
        return result
    }

    enum Op: String {
        case transformerBegin = "["
        case transformerEnd = "]"
        
        case inputPort = "{"
        case outputPort = "}"
        
        case begin = "\u{226B}"     // ≫
        case end = "\u{226A}"       // ≪
        
        case unknown = "\u{2205}"   // ∅
        
        var characterValue: Character {return Character(rawValue)}
    }
    
    
    func ruleA() -> ParserRule {
        func transformationBegin(c: Character)->ParserState {return ParserState(Op.unknown.rawValue)}
        return ParserRule(opCode: Character(Op.begin.rawValue), transformationBegin)
    }
    
    private var rules = [Op.begin.characterValue: ruleA]
}

class ParserRule: MutatingTransformer {
    
    func perform(c: Character) -> ParserState {return action(opCode)}
    
    init(opCode: Character, action: (Character)->ParserState) {
        self.opCode = opCode
        self.action = action
    }
    
    let opCode: Character
    let action: (Character)->ParserState
}


class Parser: MutatingTransformer {
    
    func begin() {_mutableState = ParserState(ParserStateTransformer.Op.begin.rawValue)}
    
    func perform(input: Character) -> ParserState {
        _mutableState = xformer.perform(input)
        return state
    }
    
    var state: ParserState {return _mutableState}
    private var _mutableState = ParserState(ParserStateTransformer.Op.unknown.rawValue)
    
    private var xformer = ParserStateTransformer()
}

class StringWalker: IdentityTransformer {

    func perform(input: (String, (Character)->Void)) -> (String, (Character)->Void) {
        for c: Character in input.0 {input.1(c)}
        return input
    }
}