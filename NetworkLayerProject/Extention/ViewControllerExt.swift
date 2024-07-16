//
//  ViewControllerExt.swift
//  NetworkLayerProject
//
//  Created by Mayank Barnwal on 16/07/24.
//

import UIKit

extension UIViewController{
    func showWaitingView(){
        hideWaitingView()
        let waitingView = WaitingView.init(frame: self.view.bounds)
        waitingView.tag = 500
        waitingView.animationView.startAnimating()
        view.addSubview(waitingView)
    }
    
    func hideWaitingView(){
        for v in self.view.subviews{
            if v.tag == 500{
                if let waitingView = v as? WaitingView{
                    waitingView.animationView.stopAnimating()
                    v.removeFromSuperview()
                }
            }
        }
    }
}
