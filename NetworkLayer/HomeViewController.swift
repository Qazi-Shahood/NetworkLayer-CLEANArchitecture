//
//  HomeViewController.swift
//  NetworkLayer
//
//  Created by Q.M.S on 10/11/2021.
//

import UIKit

class HomeViewController: UIViewController {

    var viewModel: HomeViewModel! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
        guard viewModel != nil else {
            fatalError("View Model not found") // crash app when viewModel not found
        }
        viewModel.getTeamsData()
        viewModel.teamsFetched = { result in
            switch result {
            case .success(let teams):
                print(teams)
                self.view.backgroundColor = .green
            case .failure(let err):
                if let error = err as? AppError {
                    print(error.description)
                } else {
                    print(err.localizedDescription)
                }
            }
        }
    }
    
    public class func fromNib() -> HomeViewController {
        let vc = HomeViewController(nibName: "HomeViewController", bundle: nil)
        return vc
    }

}
