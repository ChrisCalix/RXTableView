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

pSub.subscribe(onNext: { elem in
    print(elem)
})
pSub.onNext("PS example 2")

// Behavior Subject
print("\nBehavior Subject")

let bSub = BehaviorSubject<String>(value: "BS ex 1")
bSub.onNext("Bs ex 2")
bSub.subscribe(onNext: { elem in
    print(elem)
})
bSub.onNext("Bs ex 3")

// Replay Subject
print("\nReplay Subject")

let rSub = ReplaySubject<Int>.create(bufferSize: 2)
rSub.onNext(1)
rSub.onNext(2)
rSub.onNext(3)
rSub.map{ "Str \($0)" }.subscribe(onNext: { elem in
    print(elem)
})

// Async Subject
print("\nAsync Subject")

let aSub = AsyncSubject<String>()
aSub.onNext("As ex 1")
aSub.onNext("As ex 2")
aSub.onCompleted()
aSub.onNext("As ex 3")

aSub.subscribe(onNext: { elem in
    print(elem)
})
// Publish Relay
print("\nPublis Relay")

let pRel = PublishRelay<String>()
pRel.accept("pRel Ex 1")

pRel.subscribe(onNext: { elem in
    print(elem)
})

pRel.accept("pRel Ex 2")
pRel.accept("pRel Ex 3")

// Behavior Relay
print("\nBehavior Relay")
let bRel = BehaviorRelay<String>(value: "bRel ex 1")
bRel.accept("bRel ex 2")
bRel.accept("bRel ex 3")
bRel.subscribe(onNext: { elem in
    print(elem)
})
bRel.accept("bRel ex 4")

// Map Operator
