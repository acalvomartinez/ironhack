import Foundation
import UIKit

var j: Float = 0.0

for i in 0...100 {
    j = (Float(i) * 2 * sin(Float(i)))
}

j

let url: NSURL? = NSURL(string: "http://www.telize.com/geoip/90.90.90.90")
let dataJSON = NSData(contentsOfURL: url!)

do {
    let json = try NSJSONSerialization.JSONObjectWithData(dataJSON!, options: NSJSONReadingOptions.AllowFragments)
} catch {
    error
}


let v: UIView = UIView(frame: CGRectMake(10, 10, 100, 100))
v.backgroundColor = UIColor.redColor()
v.layer.cornerRadius = 0.0
v

extension UIColor {
    static func 🐤() -> UIColor {
        return UIColor.yellowColor()
    }
}

let subview = UIView(frame: CGRectMake(10, 20, 50, 50))
subview.backgroundColor = UIColor.🐤()
subview.layer.cornerRadius = 0.0

v.addSubview(subview)
v

let subview2 = UIView(frame: CGRectMake(20, 20, 30, 30))
subview2.backgroundColor = UIColor.blueColor()


subview.addSubview(subview2)

v

import Switches_PageSources