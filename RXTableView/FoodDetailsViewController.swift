//
//  FoodDetailsViewController.swift
//  RXTableView
//
//  Created by Sonic on 13/7/23.
//

import UIKit

final class FoodDetailsViewController: UIViewController {
    @IBOutlet weak var foodImage: UIImageView!
    
    public var imageName: String?
    
    override func viewDidLoad() {
        guard let imageName else {
            return
        }
        foodImage.image = UIImage(systemName: imageName)
    }
}
