//
//  AnotherVC.swift
//  MVVM base project
//
//  Created Ljubo Maricevic on 02/11/2020.
//  Copyright © 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class AnotherVC: UIViewController, RxBindable {

    
    var rxViewController: AnotherRx!
    typealias ViewControllerType = AnotherRx
    private let disposeBag = DisposeBag()
    
    @IBOutlet weak var clsBttn: UIButton!
    @IBOutlet weak var nextBttn: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationBarSetup(navTitle: "MAP", titleColor: .black, backBttnColor: .red, barBackgroundColor: .white, isTransparent: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
