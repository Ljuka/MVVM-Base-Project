//
//  AnotherRx.swift
//  MVVM base project
//
//  Created Ljubo Maricevic on 02/11/2020.
//  Copyright © 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class AnotherRx: ViewModelBindable {

    weak var vc: AnotherVC?
    var viewModel: AnotherVM!
    typealias ViewModelType = AnotherVM

    private let disposeBag = DisposeBag()
    
    init(vc: AnotherVC?) {
        self.vc = vc
    }
    
    func bindViewModel() {
        self.vc?.clsBttn.rx.tap.subscribe(onNext:{[weak self] _ in
            self?.viewModel.cls()
        }).disposed(by: disposeBag)
        
        self.vc?.nextBttn.rx.tap.subscribe(onNext:{[weak self] _ in
            self?.viewModel.next()
        }).disposed(by: disposeBag)
    }
    
}
