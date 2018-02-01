//
//  MyTestClass.swift
//  TestApp
//
//  Created by Vanita on 1/2/18.
//  Copyright © 2018 Tixdo. All rights reserved.
//

import Foundation

class MacBook {
    
}


class Person {
    //var mac: MacBook
    
    static let sharedInstance: Person = Person()
    
    var t1: String
    var t2: String
    
    private init() {
        t1 = ""
        t2 = ""
    }
    
    convenience init(t1: String) {
        self.init()
        self.t1 = t1
    }
}


class MyTestClass {
    func myFunc() {
        let p = Person.sharedInstance

    }
    
    fileprivate func myFilePrivateFunc() {
        
    }
    
    private func myPrivateFunc() {
        
    }
    
    open func myOpenFUnc() {
        
    }
    
    public func myPublicFunc() {
        
    }
    
    class func myClassFunc() {
        
    }
    
    static func myStaticFunc() {
        
    }
    
    //overload
    func add(a: Int, b: Int) -> Int {
        return 2
    }
    
    func add(a: Double, b: Double) -> Int {
        return 3
    }

}

class AnotherClass {
    let obj = MyTestClass()
    
    func test() {
        MyTestClass.myStaticFunc()
    }
}

class MyTestChildClass: MyTestClass {
    override func myFunc() {
        print("overriden myFunc")
    }
    
    override func myFilePrivateFunc() {
        
    }
    
    override func myOpenFUnc() {
            }
    
    override func myPublicFunc() {
        
    }
    
    func fetchSuperClassFunction() {
        MyTestClass.myClassFunc()
        MyTestClass.myStaticFunc()
        print(super.add(a: 2.0, b: 2.0))
        print(super.add(a: 2, b: 2))

    }
}
