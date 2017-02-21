//
//  DetailViewController.swift
//  homework5
//
//  Created by Carlos Lemus on 2/21/17.
//  Copyright © 2017 Carlos Lemus. All rights reserved.
//

import UIKit
import AVFoundation

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!

    @IBOutlet weak var image: UIImageView!
    
    
    let synthesizer = AVSpeechSynthesizer()

    func configureView() {
        // Update the user interface for the detail item.
        if let detail = self.detailItem {
            if let label = self.detailDescriptionLabel {
                label.text = detail.description
                
                //Prepare Speech
                let speaker = AVSpeechUtterance(string: label.text!)
                
                //Select Speaker
                speaker.voice = AVSpeechSynthesisVoice(language: "en-US")
                speaker.rate = 0.5
                
                //Speak
                synthesizer.speak(speaker)
            }
            if let imageView = self.image {
                imageView.image = detail.foodImage()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var detailItem: Foods? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }


}

