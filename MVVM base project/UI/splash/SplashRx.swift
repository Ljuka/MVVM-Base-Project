//
//  SplashRx.swift
//  MVVM base project
//
//  Created by Ljubo Maricevic on 30/10/2020.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import Localize_Swift
import RxGesture

class SplashRx: ViewModelBindable {
    
    weak var vc: SplashVC?
    var viewModel: SplashVM!
    typealias ViewModelType = SplashVM

    private let disposeBag = DisposeBag()
        
    init(vc: SplashVC?) {
        self.vc = vc
    }

    func bindViewModel() {
        
        self.vc?.loginBttn.rx.tap.subscribe(onNext:{[weak self] _ in
            self?.viewModel.gotoAuth()
//            self?.vc?.view.backgroundColor = .random()
//            self?.viewModel.printWelcome()
        }).disposed(by: disposeBag)
        
        self.viewModel.obs.asObservable().filter { (filter) -> Bool in
            filter != ""
        }.subscribe(onNext:{ res in
            print("RES: ", res)
        }).disposed(by: disposeBag)
        
    }
    
    
}
extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}
extension UIColor {
    static func random() -> UIColor {
        return UIColor(
           red:   .random(),
           green: .random(),
           blue:  .random(),
           alpha: 1.0
        )
    }
}
