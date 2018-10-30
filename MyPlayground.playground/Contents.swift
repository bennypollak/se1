import UIKit

var string = "my car reg 1 - DD11 AAA  my car reg 2 - AA22 BBB"
var pattern = "([A-HK-PRSVWY][A-HJ-PR-Y])\\s?([0][2-9]|[1-9][0-9])\\s?[A-HJ-PR-Z]{3}"

string = "http://www.amazon.com/Mathematica-Cookbook-Building-Science-Engineering/dp/0596520999/ref=mp_s_a_1_1?ie=UTF8&qid=1540661026&sr=8-17&pi=AC_SX236_SY340_QL65&keywords=mathematica&dpPl=1&dpID=51VOw%2BIWKRL&ref=plSrch"
string = "http://www.amazon.com/"
pattern = "(https?://.*)\\?.*$"
pattern = "(https?://)[^.]*[^/]*).*$"
pattern = "(https?://[^/]*).*$"
//pattern = "car"
let regex = try! NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options.caseInsensitive)
let range = NSMakeRange(0, string.count)
let modString = regex.stringByReplacingMatches(in: string, options: [], range: range, withTemplate: "$1")
print(modString)

var items = Set<String>()
items.insert("a")
let a="a"
if items.contains(a) {
    print("hi")
}
