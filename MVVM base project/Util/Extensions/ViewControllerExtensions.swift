//
//  ViewControllerExtensions.swift
//  remoney2-ios-shops
//
//  Created by Ljubo Maricevic on 15/05/2019.
//  Copyright © 2019 Ljubo Maricevic. All rights reserved.
//

import Foundation
import UIKit
import UINavigationItem_Margin
import PopupDialog
import SwiftMessages

extension UIViewController {
    
    enum ToastGravity {
        case top
        case bottom
    }
    
    func showToast(message : String, gravity: ToastGravity) {
        var y: CGFloat
        switch gravity {
        case .top:
            y = 100
        case .bottom:
            y = self.view.frame.size.height-100
        }
        let toastLabel = UILabel(frame: CGRect(x: CGFloat(self.view.frame.size.width - CGFloat(message.count * 10))/2, y: y, width: CGFloat(message.count * 10), height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Helvetica", size: 14.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 2.0, delay: 3, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }

}

extension UIViewController{
  
      func startLoader(){
//        add blur effect
        let blurEffect = UIBlurEffect(style: .prominent)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.tag = 22

        let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: blurEffectView.frame.width / 2 - 25, y: blurEffectView.frame.height / 2 - 25, width: 50, height: 50)) as UIActivityIndicatorView
        loadingIndicator.tag = 23
        if #available(iOS 13.0, *) {
            loadingIndicator.style = .large
        } else {
            loadingIndicator.style = .gray
        }
        loadingIndicator.color = .buttonText
        loadingIndicator.startAnimating()

//        UIApplication.shared.keyWindow umjesto self.view kako bi loader isao preko navigacije...na view ako ga kacimo navigacija ostaje vidljiva
        UIApplication.shared.keyWindow?.addSubview(blurEffectView)
        UIApplication.shared.keyWindow?.addSubview(loadingIndicator)
          
      }
      
      func stopLoader(){
          if let blurView = UIApplication.shared.keyWindow?.viewWithTag(22){
              blurView.removeFromSuperview()
          }
          
          if let loadingView = UIApplication.shared.keyWindow?.viewWithTag(23){
              loadingView.removeFromSuperview()
          }
      }
    
    func defaultPopup(title: String? = "error", msg: String? = ""){
        let alertController = UIAlertController(title: title?.localized(), message: msg?.localized(), preferredStyle: .alert)
        let okAcction = UIAlertAction(title: "ok".localized().uppercased(), style: .default)
        alertController.addAction(okAcction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showSuccessAction(message: String){
        
//        let view: MessageView?

        let view = MessageView.viewFromNib(layout: .cardView)
        view.configureContent(body: message.localized())
        (view.backgroundView as? CornerRoundingView)?.cornerRadius = 4
        view.layoutMarginAdditions = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
   
        var config = SwiftMessages.Config()
        config.presentationStyle = .bottom
        config.duration = .seconds(seconds: 4)
        view.titleLabel?.isHidden = true
        view.button?.isHidden = true
        view.iconImageView?.isHidden = false
        view.iconLabel?.isHidden = true
        view.configureTheme(backgroundColor: .azureBlue, foregroundColor: .white, iconImage: nil, iconText: nil)
        
        // Show the message.
        SwiftMessages.show(config: config, view: view)

    }
    
    func confirmationPopup(title: String? = "warning".localized().uppercased(), msg: String? = "confirmation_message".localized(), leftBttn: String = "yes".localized(), rightBttn: String = "no".localized(), completion: ((Bool) -> Void)? = nil){
        let alertController = UIAlertController(title: title?.localized(), message: msg?.localized(), preferredStyle: .alert)
        let okAcction = UIAlertAction(title: leftBttn.localized(), style: .default) { (_) -> Void in
            completion!(true)
        }
        let cancelAction = UIAlertAction(title: rightBttn.localized(), style: .default) { (_) -> Void in
            completion!(false)
        }
        
        alertController.view.tintColor = .buttonText
        alertController.view.backgroundColor = .white
        alertController.addAction(cancelAction)
        alertController.addAction(okAcction)
        self.present(alertController, animated: true, completion: nil)

    }
    
    func showErrorPopup(message: String){
//        let popupVC = ErrorPopup.storyboardInstance()
//        let popupDialog = PopupDialog(viewController: popupVC!, transitionStyle: .zoomIn, tapGestureDismissal: true, panGestureDismissal: true, completion: nil)
////        popupDialog.view.backgroundColor = .clear
//
//        popupVC?.msg = message.localized()
//        self.present(popupDialog, animated: true, completion: nil)
    }
    
   func navigationBarSetup(navTitle: String, titleColor: UIColor, backBttnColor: UIColor, barBackgroundColor: UIColor, isTransparent: Bool, hasCustomBackBttn: Bool? = false, target: AnyObject? = nil, action: Selector? = nil){
           self.navigationController?.navigationBar.isHidden = false
           self.navigationController?.navigationBar.topItem?.title = ""
           self.navigationItem.backBarButtonItem?.title = ""
           self.title = navTitle.localized()
           self.navigationItem.title = navTitle.localized()
           self.navigationController?.navigationBar.tintColor = backBttnColor
           self.navigationController?.navigationBar.barTintColor = barBackgroundColor
           self.navigationController?.navigationBar.backgroundColor = barBackgroundColor
           self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: titleColor, NSAttributedString.Key.font: Font.avenirBlack.of(size: 25.0)!, NSAttributedString.Key.kern: 8.4]
           self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
           self.navigationController?.navigationBar.shadowImage = UIImage()
           if isTransparent{
               self.navigationController?.navigationBar.transparentNavigationBar()
           }
           
           if hasCustomBackBttn!{
               let button = UIButton(type: .system)
               if #available(iOS 13.0, *) {
                   button.setImage(UIImage(systemName: "chevron.left", withConfiguration: UIImage.SymbolConfiguration(pointSize: 19, weight: .semibold)), for: .normal)
               } else {
                   button.setImage(#imageLiteral(resourceName: "ic_arrow_white").resizeImage(targetSize: CGSize(width: 20, height: 20)), for: .normal)
               }
               button.frame = CGRect(x: 0.0, y: 0.0, width: 44.0, height: 44.0)
               button.addTarget(target, action: action!, for: .touchUpInside)
               button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 15)
               self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
               self.navigationItem.leftMargin = 0 //iz biblioteke :)
               self.navigationItem.titleView?.layoutMargins = UIEdgeInsets(top: 40, left: 0, bottom: 0, right: 0)
           }
           
        }
    


}
//
//extension NVActivityIndicatorViewable where Self: UIViewController {
//    
//    func showClouds(){
//        let lijeviOblak = UIImageView(image: #imageLiteral(resourceName: "anim_left_oblak"))
//        lijeviOblak.frame.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
//        lijeviOblak.transform = CGAffineTransform(translationX: 0, y: 0)
//        self.view.addSubview(lijeviOblak)
//        lijeviOblak.isHidden = false
//        view.bringSubviewToFront(lijeviOblak)
//        lijeviOblak.tag = 9
//       
//        let desniOblak = UIImageView(image: #imageLiteral(resourceName: "anim_right_oblak"))
//        desniOblak.frame.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
//        desniOblak.transform = CGAffineTransform(translationX: 0, y: 0)
//        self.view.addSubview(desniOblak)
//        desniOblak.isHidden = false
//        view.bringSubviewToFront(desniOblak)
//        desniOblak.tag = 11
//    }
//    
//    func startShowingClouds(completion: ((Bool) -> Void)? = nil){
//        let lijeviOblak = UIImageView(image: #imageLiteral(resourceName: "anim_left_oblak"))
//        lijeviOblak.frame.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
//        lijeviOblak.transform = CGAffineTransform(translationX: -300, y: 0)
//        self.view.addSubview(lijeviOblak)
//        lijeviOblak.isHidden = false
//        view.bringSubviewToFront(lijeviOblak)
//        lijeviOblak.tag = 9
//        
//        let desniOblak = UIImageView(image: #imageLiteral(resourceName: "anim_right_oblak"))
//        desniOblak.frame.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
//        desniOblak.transform = CGAffineTransform(translationX: 300, y: 0)
//        self.view.addSubview(desniOblak)
//        desniOblak.isHidden = false
//        view.bringSubviewToFront(desniOblak)
//        desniOblak.tag = 11
//
//        UIView.animate(withDuration: 0.7, delay: 0, animations: {
//            lijeviOblak.transform = CGAffineTransform(translationX: 0, y: 0)
//        }, completion: nil)
//
//        UIView.animateKeyframes(withDuration: 0.7, delay: 0, animations: {
//            desniOblak.transform = CGAffineTransform(translationX: 0, y: 0)
//        }) { (_) in
//            completion?(true)
//        }
//        
//    }
//    
//    func hideClouds(){
//        let lijeviOblak = self.view.viewWithTag(9)
//        let desniOblak = self.view.viewWithTag(11)
//        
//        UIView.animate(withDuration: 0.7, delay: 0, animations: {
//            lijeviOblak?.transform = CGAffineTransform(translationX: -300, y: 0)
//        }, completion: { finished in
//            if finished{
//                lijeviOblak?.isHidden = true
//            }
//        })
//        
//        UIView.animate(withDuration: 0.7, delay: 0, animations: {
//            desniOblak?.transform = CGAffineTransform(translationX: 300, y: 0)
//        }, completion: { finished in
//            if finished{
//                desniOblak?.isHidden = true
//            }
//        })
//    }
////
////    func showLoading(){
////        NVActivityIndicatorView.DEFAULT_BLOCKER_SIZE = CGSize(width: 40, height: 40)
////        NVActivityIndicatorView.DEFAULT_BLOCKER_BACKGROUND_COLOR = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.6004922945)
////        NVActivityIndicatorView.DEFAULT_TYPE = .ballClipRotatePulse
//////        NVActivityIndicatorView.DEFAULT_COLOR = .mainBlue
////        self.startAnimating()
////    }
////
////    func hideLoading(){
////        self.stopAnimating()
////    }
//}
