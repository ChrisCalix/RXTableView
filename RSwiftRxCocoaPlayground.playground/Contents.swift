import UIKit
import RxSwift
import RxCocoa
import RxRelay

/*
 RxSwift
 
 Observable (sequence) - emits events (notifications of change) asynchrnously
 Observer - subscribes to Observable in order to receive events
 
 Subject = Observable + Observer
    - PublishSubject - only emits new elements to subscribers.
    - BehaviorSubject - emits the last element to new subscribers.
    - ReplaySubject - emits a buffer size of elements to new subscribers.
    - AsyncSubject - emits only the last next event in the sequence, and only when the subject a completed event.
 
 Relays = Wrapers around Subjects that never complete
    - Publish Relay
    - BehavioerRelay
*/

// Pusblish Subject
print("\nPusblish Subject")

let pSub = PublishSubject<String>()
pSub.onNext("PS example 1")

let ob1 = pSub.subscribe(onNext: { elem in
    print(elem)
})
pSub.onNext("PS example 2")

// Behavior Subject
print("\nBehavior Subject")

let bSub = BehaviorSubject<String>(value: "BS ex 1")
bSub.onNext("Bs ex 2")
let ob2 = bSub.subscribe(onNext: { elem in
    print(elem)
})
bSub.onNext("Bs ex 3")

// Replay Subject
print("\nReplay Subject")

let rSub = ReplaySubject<String>.create(bufferSize: 2)
rSub.onNext("Rs ex 1")
rSub.onNext("Rs ex 2")
rSub.onNext("Rs ex 3")
let ob3 = rSub.subscribe(onNext: { elem in
    print(elem)
})

// Async Subject

// Publish Relay

// Behavior Relay
