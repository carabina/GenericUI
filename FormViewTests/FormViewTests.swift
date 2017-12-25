//
//  FormViewTests.swift
//  FormViewTests
//
//  Created by Thomas Lextrait on 12/22/17.
//  Copyright © 2017 Yelp. All rights reserved.
//

import XCTest
@testable import FormView

class FormViewTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    /**
     Tests building a form, filling it and recovering the data
    */
    func testForm() {
        
        class Person : NSObject, VoidInitializable {
            /*@objc */var firstname = ""
            /*@objc */var lastname = ""
            /*@objc */var age = 1
            
            required override init() {
            }
        }
        
        let form = UIQuickFormView<Person>()
        
        let firstnameField = UIActiveInput<String>()
        let lastnameField = UIActiveInput<String>()
        let ageField = UIActiveInput<Int>()
        
        let binding = form.bind(input: firstnameField) { (p: Person, input: UIActiveInput<String>) in
            guard let firstname = input.output else {
                return
            }
            p.firstname = firstname
        }
        form.addRow([binding])
        
        // Pretend typing stuff into the fields
        firstnameField.output = "John"
        lastnameField.output = "Smith"
        ageField.output = 26
        
        // Test string outputs
        XCTAssertEqual(firstnameField.text, "John")
        XCTAssertEqual(lastnameField.text, "Smith")
        XCTAssertEqual(ageField.text, "26")
        
        // Test generic outputs
        XCTAssertEqual(firstnameField.output, "John")
        XCTAssertEqual(lastnameField.output, "Smith")
        XCTAssertEqual(ageField.output, 26)
        
        // Ask the form to build the model
        let person = form.resolve()
        
        XCTAssertEqual(person.firstname, "John")
        XCTAssertEqual(person.lastname, "Smith")
        XCTAssertEqual(person.age, 26)
    }
    
}
