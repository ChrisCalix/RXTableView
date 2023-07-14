//
//  ViewController.swift
//  RXTableView
//
//  Created by Sonic on 13/7/23.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private let tableViewItems = Observable.just([
        Food(name: "Hamburguer", image: "square.and.arrow.up"),
        Food(name: "Pizza", image: "pencil.circle.fill"),
        Food(name: "Salmon", image: "lasso"),
        Food(name: "Spagueti", image: "trash")
    ])
    let disposableBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewItems.bind(to: tableView
            .rx
            .items(cellIdentifier: "Cell", cellType: FoodTableViewCell.self)) { tableView, items, cell in
                cell.foodLabel.text = items.name
                cell.foodImageView.image = UIImage(systemName: items.image)
            }
            .disposed(by: disposableBag)
        
        // Using model selected
        tableView
            .rx
            .modelSelected(Food.self)
            .subscribe(onNext: { object in
                print("working")
                let foodVC = self.storyboard?.instantiateViewController(withIdentifier: "FoodVC") as! FoodDetailsViewController
                foodVC.imageName.accept(object.image)
                self.navigationController?.pushViewController(foodVC, animated: true)
            })
            .disposed(by: disposableBag)
        
        // Using item selected get the indexPath
//        tableView
//            .rx
//            .itemSelected
//            .subscribe(onNext: { indexPath in
//
//            })
//            .disposed(by: disposableBag)
    }

    
}

