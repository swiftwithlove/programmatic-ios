//
//  main.swift
//  Memory
//
//  Created by Adam Dahan on 2019-02-07.
//  Copyright © 2019 Adam. All rights reserved.
//

import Foundation

func testRetainCycle() {
    class A {
        weak var b: B?
        deinit {
            print("Bye bye A")
        }
    }
    class B {
        weak var a: A?
        deinit {
            print("Bye bye B")
        }
    }
    let a = A()
    let b = B()
    
    a.b = b
    b.a = a
    
    /// a / b we're deallocted.
}
testRetainCycle()

