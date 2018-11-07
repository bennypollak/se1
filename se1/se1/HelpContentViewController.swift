//
//  HelpContentViewController.swift
//  r2
//
//  Created by Benny Pollak on 6/7/18.
//  Copyright © 2018 Alben Software. All rights reserved.
//

import UIKit

class HelpContentViewController: UIViewController {
    var pageController:HelpViewController?
    @IBOutlet var titleLbl: UILabel!
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet var versionLbl: UILabel!
    @IBOutlet var mainImg: UIImageView!

    static let imageData = [
        UIImage(named: "mainshot-1.png")
        , UIImage(named: "mainshot-2.png")
        , UIImage(named: "mainshot-3.png")
        , UIImage(named: "mainshot-4.png")
        , UIImage(named: "mainshot-5.png")
        , UIImage(named: "mainshot-6.png")
    ]
    static let textData = [
        "This is a share extension that works on any app that accepts sharing. It is an enhanced version of the standard 'Copy' share button that gives you more options",
        "If you don't see it the first time tap 'More'",
        "Enable it",
        "Move it up if you want and tap 'Done'",
        "Now you see it and you can use instead of the 'Copy' button for expanded functionality",
        "It will give a choice of URLs to copy. Tap on the one you want to copy"
    ]
    static let pageCount = imageData.count
    public var itemIndex:Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        titleLbl.text = HelpContentViewController.textData[itemIndex]
        let info:String = "Clean copy"
        versionLbl.text = info
        mainImg.image = HelpContentViewController.imageData[itemIndex]//UIImage(named: "mainshot.png")
        if itemIndex == 0 {
            backBtn.isHidden = true
        } else if itemIndex >= HelpContentViewController.pageCount-1 {
            nextBtn.isHidden = true
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func next(_ sender: Any) {
        pageController?.flip(direction: 1)
    }
    
    @IBAction func back(_ sender: Any) {
        pageController?.flip(direction: -1)
    }
    
    @IBAction func gotIt(_ sender: Any) {
        guard let url = URL(string: "https://www.amazon.com/Mathematica-Cookbook-Building-Science-Engineering-ebook/dp/B0043EWVBU?keywords=mathematica&qid=1540843280&sr=8-24&ref=sr_1_24") else { return }
        UIApplication.shared.open(url)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
