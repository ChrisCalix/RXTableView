//
//  ViewController.swift
//  RXTableView
//
//  Created by Sonic on 13/7/23.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class ViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private let tableViewItemsSectioned = BehaviorRelay(value: [
        SectionModel(header: "Main Courses", items: [
            Food(name: "Hamburguer", image: "square.and.arrow.up"),
            Food(name: "Pizza", image: "pencil.circle.fill"),
            Food(name: "Salmon", image: "lasso"),
            Food(name: "Spagueti", image: "trash"),
            Food(name: "Hamburguer", image: "square.and.arrow.up"),
            Food(name: "Pizza", image: "pencil.circle.fill"),
            Food(name: "Salmon", image: "lasso"),
            Food(name: "Spagueti", image: "trash"),
        ]),
        SectionModel(header: "Desserts", items: [
            Food(name: "Hamburguer", image: "square.and.arrow.up"),
            Food(name: "Pizza", image: "pencil.circle.fill"),
            Food(name: "Salmon", image: "lasso"),
            Food(name: "Spagueti", image: "trash")
        ])
    ])
    
    private let dataSource = RxTableViewSectionedReloadDataSource<SectionModel>(configureCell: { ds, tableView, indexPath, item in
        let cell: FoodTableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FoodTableViewCell
        cell.foodLabel.text = item.name
        cell.foodImageView.image = UIImage(systemName: item.image)
        return cell
    }, titleForHeaderInSection: { ds, index in
        return ds.sectionModels[index].header
    })
    
    let disposableBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        
        searchBar.rx.text.orEmpty
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .map { query in
                self.tableViewItemsSectioned.value.map { sectionModel in
                    SectionModel(header: sectionModel.header, items: sectionModel.items.filter { food in
                        query.isEmpty || food.name.lowercased().contains(query.lowercased())
                    })
                }
            }
            .bind(to: tableView
            .rx
            .items(dataSource: dataSource))
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

