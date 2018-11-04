import UIKit
var str = "Hello, playground"
var strings  = ["https://www.cnn.com/videos/politics/2018/11/02/dons-take-trump-immigration-ctn-vpx.cnn","https://www.amazon.com/Mathematica-Cookbook-Building-Science-Engineering-ebook/dp/B0043EWVBU?keywords=mathematica&qid=1540653385&s=Books&sr=1-14&ref=sr_1_14","https://www.cnn.com/videos/politics/2018/11/01/tapper-monologue-trump-immigration-speech-ebof-vpx.cnn"]
var patterns:[String:String] =  [ "(https?://.*)\\?.*$":"$1",
                                  "(https?://[^/]*).*$":"$1",
                                  "(https?://).*\\.([^/.]*)\\.([^/.]*).*$":"$1$2.$3"
]
func cleanURL(_ pattern: String, _ string: String, _ template: String) -> String {
    //pattern = "car"
    let regex = try! NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options.caseInsensitive)
    let range = NSMakeRange(0, string.count)
    let modString = regex.stringByReplacingMatches(in: string, options: [], range: range, withTemplate: template)
    return modString
}
for string in strings {
    for  (pattern, template) in patterns {
        let item = cleanURL(pattern, string, template)
        print("\(pattern) \(item)")
    }
}
