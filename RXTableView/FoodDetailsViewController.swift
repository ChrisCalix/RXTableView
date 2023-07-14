//
//  FoodDetailsViewController.swift
//  RXTableView
//
//  Created by Sonic on 13/7/23.
//

import UIKit
import RxSwift
import RxCocoa

final class FoodDetailsViewController: UIViewController {
    @IBOutlet weak var foodImage: UIImageView!
    
    let imageName: BehaviorRelay = BehaviorRelay<String>(value: "")
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        imageName
            .map { UIImage(systemName: $0) }
            .bind(to: foodImage
                .rx
                .image)
            .disposed(by: bag)
            
    }
}
