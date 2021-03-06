//
//  5-1 Swift 2.0字符串之字符串基础
//  01-String-Basics.playground
//
//  Created by AlexZHOU on 21/05/2017.
//  Copyright © 2016年 AlexZHOU. All rights reserved.
//

import UIKit

var str = "01-String-Basics"
print(str)


// 空字符串
let emptyString  = ""
let emptyString2 = String()

// 使用String()初始化字符串
let str2 = String("Hello, swift")

// 判断空字符串
str.isEmpty
emptyString.isEmpty

// String的粘合
let mark = "!!!"
str + mark

// 常量String和变量String
str += mark
str
//str2 += mark


// 字符串插值
let name = "AlexZHOU"
let age  = 24
let height = 1.78
let s = "My name is \(name), I'm \(age) years old. I'm \(height) meters tall."
print(s)


// 特殊字符
let s2 = "\"hello\"\t\"hi\"\nbye!"
print(s2)
