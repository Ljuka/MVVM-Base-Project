//
//  LoginVC.swift
//  MVVM base project
//
//  Created Ljubo Maricevic on 02/11/2020.
//  Copyright © 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LoginVC: UIViewController, RxBindable {


    var rxViewController: LoginRx!
    typealias ViewControllerType = LoginRx
    private let disposeBag = DisposeBag()

    @IBOutlet weak var clsBttn: UIButton!
    @IBOutlet weak var nextBttn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()    
    }
    
}
