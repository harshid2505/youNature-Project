//
//  StartPage.swift
//  youNature Project
//
//  Created by HARSHID PATEL on 28/08/23.
//

import UIKit

class StartPage: UIViewController {

    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var progress: UIProgressView!
    @IBOutlet weak var descriptionLb: UILabel!
    @IBOutlet weak var waitLb: UILabel!
    
    var time = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        nextButton.layer.cornerRadius = 8
        nextButton.layer.masksToBounds = true
        progress.progress = 0.0
        descriptionLb.isHidden = true
        waitLb.isHidden = true
    }
    
    func progresBar(){
        var a : Float = 0.0
        self.progress.progress = a
        time = Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true, block: { Timer in
            a+=0.01
            self.progress.progress = a
            if self.progress.progress == 1.0{
                self.navigate()
                self.time.invalidate()
                self.progress.progress = 0.0
            }
        })
    }
    
    func navigate(){
        let navigate = storyboard?.instantiateViewController(identifier: "ListMainPage") as! ListMainPage
        navigationController?.pushViewController(navigate, animated: true)
    }
    
    @IBAction func nextButtonAction(_ sender: UIButton) {
        descriptionLb.isHidden = false
        waitLb.isHidden = false
         progresBar()
    }
    
}


