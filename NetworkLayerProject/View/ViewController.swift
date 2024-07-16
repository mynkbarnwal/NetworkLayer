//
//  ViewController.swift
//  NetworkLayerProject
//
//  Created by Mayank Barnwal on 25/05/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var maxLabel: UILabel!
    @IBOutlet weak var minLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        maxLabel.text = ""
        minLabel.text = "Loading..."
        v.getData()
    }
    
    lazy var v = ViewModal(eventHandler: {[weak self] event in
        guard let self else{
            return
        }
        switch event {
        case .loading:
            showWaitingView()
        case .loaded:
            setData()
            hideWaitingView()
        case .errorInLoading:
            hideWaitingView()
            maxLabel.text = ""
            minLabel.text = "Error in getting data"
        }
    })
    
    func setData(){
        minLabel.text = "Min Temp = \(v.responseData.tempMin)"
        maxLabel.text = "Max Temp = \(v.responseData.tempMax)"
    }
}





