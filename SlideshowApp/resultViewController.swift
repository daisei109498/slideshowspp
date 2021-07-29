//
//  resultViewController.swift
//  SlideshowApp
//
//  Created by dslog sys on 2021/07/25.
//

import UIKit

class resultViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    var image: UIImage!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = image
        imageView.contentMode = UIView.ContentMode.scaleAspectFit
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // segueから遷移先のViewControllerを取得する
        let ViewController:ViewController = segue.destination as! ViewController
        // 遷移先のViewControllerへ渡す
        ViewController.image = image
        
        ViewController.nextButton.isEnabled = true
        ViewController.backButton.isEnabled = true
    }
    
}
