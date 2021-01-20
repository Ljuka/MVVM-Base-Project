//
//  SplashVC.swift
//  ZRKB
//
//  Created Ljubo Maricevic on 19/08/2020.
//  Copyright © 2020 Ljubo Maricevic. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Localize_Swift
import RxGesture

class SplashVC: UIViewController, RxBindable {

    var rxViewController: SplashRx!
    typealias ViewControllerType = SplashRx
    
    @IBOutlet weak var loginBttn: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
  
}
