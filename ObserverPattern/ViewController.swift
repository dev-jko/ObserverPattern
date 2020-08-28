//
//  ViewController.swift
//  ObserverPattern
//
//  Created by Jaedoo Ko on 2020/08/28.
//  Copyright © 2020 jko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let observable: Observable<Int, Observer<Int>> = Observable()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let observer1 = Observer<Int>(num: 1)
        let observer2 = Observer<Int>(num: 2)
        observable.subscribe(observer: observer1)
        observable.subscribe(observer: observer2)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        observable.notify(value: 1)
        observable.notify(value: 3)
    }
}

protocol ObservableType {
    associatedtype Element
    associatedtype Observer
    func subscribe(observer: Observer)
}

protocol ObserverType {
    associatedtype Element
    func update(value: Element)
}

class Observable<Element, Observer: ObserverType>: ObservableType where Element == Observer.Element {
    var observers: [Observer] = []
    
    func subscribe(observer: Observer) {
        observers.append(observer)
    }
    
    func notify(value: Element) {
        observers.forEach { observer in observer.update(value: value) }
    }
}

class Observer<Element>: ObserverType {
    private let num: Int
    
    init(num: Int) {
        self.num = num
    }
    
    func update(value: Element) {
        print("observer\(num) : \(value)")
    }
}
