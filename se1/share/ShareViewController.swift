//
//  ShareViewController.swift
//  share
//
//  Created by Benny Pollak on 10/26/18.
//  Copyright © 2018 Alben Software. All rights reserved.
//

import UIKit
import Social
private let reuseIdentifier = "ShareCollectionViewCell"

class ShareCollectionViewCell: UITableViewCell {
    @IBOutlet weak var t: UILabel!
    
}

class ShareViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var texts:[String] = []
    var patterns:[String:String] =  [ "(https?://.*)\\?.*$":"$1", "(https?://[^/]*).*$":"$1", "(https?://).*\\.([^.]*)\\.([^/.]*).*$":"$1$2.$3"]
    @IBOutlet weak var textLbl: UILabel!
    var urlString:String = ""
    fileprivate func cleanURL(_ pattern: String, _ string: String, _ template: String) -> String {
        //pattern = "car"
        let regex = try! NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options.caseInsensitive)
        let range = NSMakeRange(0, string.count)
        let modString = regex.stringByReplacingMatches(in: string, options: [], range: range, withTemplate: template)
        print(modString)
        return modString
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       table.delegate = self
        table.dataSource = self
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem?.title = "Save"
//        textView.isHidden = true
        let extensionItem = extensionContext?.inputItems[0] as! NSExtensionItem

        for item in extensionItem.attachments! {
            print("item: \(item)")
            for id in item.registeredTypeIdentifiers {
                print("id \(id)")
                texts.append(id)
            }
            var items = Set<String>()

            if item.hasItemConformingToTypeIdentifier("public.plain-text") {
                item.loadItem(forTypeIdentifier: "public.plain-text", options: nil, completionHandler: { (results, error) in
                    let text = results as! String?
                        print("\(text)")
                })
            } else if item.hasItemConformingToTypeIdentifier("public.url") {
                item.loadItem(forTypeIdentifier: "public.url", options: nil, completionHandler: { (results, error) in
                    let url = results as! URL?
                    self.urlString = url?.absoluteString ?? ""
//                    print("\(url?.absoluteString ?? "?")")
                    self.texts.append(self.urlString)
                    let string = self.urlString //"https://www.amazon.com/Mathematica-Cookbook-Building-Science-Engineering-ebook/dp/B0043EWVBU?keywords=mathematica&qid=1540843280&sr=8-24&ref=sr_1_24"
                    items.insert("https://www.carrentals.com/")
                    for  (pattern, template) in self.patterns {
                        let item = self.cleanURL(pattern, string, template)
                        if !items.contains(item) {
                            items.insert(item)
                            self.texts.append(item)
                        }
                    }
//                    UIPasteboard.general.string = self.urlString
                    self.UI {
                    self.table.reloadData()
                    }
                })
            }
        }
    }
//    override func isContentValid() -> Bool {
//        // Do validation of contentText and/or NSExtensionContext attachments here
//        return true
//    }

//    override func didSelectPost() {
//        // This is called after the user selects Post. Do the upload of contentText and/or NSExtensionContext attachments.
//
//        // Inform the host that we're done, so it un-blocks its UI. Note: Alternatively you could call super's -didSelectPost, which will similarly complete the extension context.
//        self.extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
//    }

//    override func configurationItems() -> [Any]! {
//        // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
//        return []
//    }

    // MARK: - Table

    @IBOutlet weak var table: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return texts.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier)
            as? ShareCollectionViewCell
        let i = indexPath.row
        ///
        cell?.t.text = texts[i]
        //"https://www.amazon.com/Mathematica-Cookbook-Building-Science-Engineering-ebook/dp/B0043EWVBU?keywords=mathematica&qid=1540653385&s=Books&sr=1-14&ref=sr_1_14"
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UIPasteboard.general.string = texts[indexPath.row]
        self.extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
        
    }
    // MARK: - Utils
    func UI(_ block: @escaping ()->Void) {
        DispatchQueue.main.async(execute: block)
    }
    func BG(_ block: @escaping ()->Void) {
        DispatchQueue.global(qos: .default).async(execute: block)
    }

}
