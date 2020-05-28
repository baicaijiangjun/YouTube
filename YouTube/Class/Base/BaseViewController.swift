//
//  BaseViewController.swift
//  YouTube
//
//  Created by Turbo on 2020/5/26.
//  Copyright © 2020 turbo. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    func setLeftImageNamed(name: String, action: Selector) {
        let image = UIImage(named: name)
        let backItem = UIBarButtonItem.init(image: image, style: UIBarButtonItem.Style.plain, target: self, action: action)
        self.navigationItem.leftBarButtonItem = backItem
        
        // 自定义返回按钮恢复返回手势
        if (navigationController?.viewControllers.count ?? 0) > 1 {
            navigationController?.interactivePopGestureRecognizer?.delegate = self as? UIGestureRecognizerDelegate
        }
    }
    
    func setNavigationBarBackgroundImage(image: UIImage, tintColor: UIColor, textColor: UIColor, style: UIStatusBarStyle) {
        
    }
    
    @objc func popBackController() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func showDetailHint(hint: String) {
        let view = UIApplication.shared.delegate?.window
        let hud = MBProgressHUD.showAdded(to:view!!, animated: true)
        hud.isUserInteractionEnabled = false
        hud.mode = MBProgressHUDMode.text
        hud.detailsLabel.text = hint
        hud.margin = 9.0
        hud.detailsLabel.font = UIFont.systemFont(ofSize: 14.0)
        hud.offset = CGPoint(x: 0, y: 44)
        hud.removeFromSuperViewOnHide = true
        hud.hide(animated: true, afterDelay: 2.0)
    }
}
