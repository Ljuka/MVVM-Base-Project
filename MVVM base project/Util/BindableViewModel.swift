//
//  BindableViewModel.swift
//  xCoordinatorsTest
//
//  Created by Ljubo Maricevic on 19/02/2019.
//  Copyright © 2019 Ljubo Maricevic. All rights reserved.
//

import Foundation
import UIKit

protocol RxBindable: AnyObject {
    associatedtype ViewControllerType
    var rxViewController: ViewControllerType! { get set }
}

protocol ViewModelBindable: AnyObject {
    associatedtype ViewModelType
    var viewModel: ViewModelType! { get set }
    
    func bindViewModel()
}

extension RxBindable where Self: UIViewController {
    func bind(to rx: Self.ViewControllerType) {
        rxViewController = rx
        loadViewIfNeeded()
    }
}

extension ViewModelBindable where Self: AnyObject {
    func bind(to model: Self.ViewModelType) {
        viewModel = model
        self.bindViewModel()
    }
}





//extension ViewModelBindable where Self: UITableViewCell {
//    func bind(to model: Self.ViewModelType, rx: Self.ViewControllerType) {
//        viewModel = model
//        rxViewController = rx
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//            self.bindViewModel()
//        }
//    }
//}
//
//extension ViewModelBindable where Self: UICollectionViewCell {
//    func bind(to model: Self.ViewModelType, rx: Self.ViewControllerType) {
//        viewModel = model
//        rxViewController = rx
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//            self.bindViewModel()
//        }
//    }
//}
