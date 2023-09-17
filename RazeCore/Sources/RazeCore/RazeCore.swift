import UIKit

class RazeCore {
    class func colorFromHexString(_ hexString: String, alpha: CGFloat = 1.0) -> UIColor {
        let r, g, b: CGFloat // buffer variables
        // strip off "#"
        let offset = hexString.hasPrefix("#") ? 1 : 0
        let start = hexString.index(hexString.startIndex, offsetBy: offset)
        // variadic parameter with the hexcode
        let hexColor = String(hexString[start...])
        // scanner class strides across the string
        let scanner = Scanner(string: hexColor)
        var hexNumber: UInt64 = 0
        //extract rgb values with bitwise operation
        if scanner.scanHexInt64(&hexNumber) {
            r = CGFloat((hexNumber & 0xff0000) >> 16) / 255
            g = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
            b = CGFloat(hexNumber & 0x0000ff) / 255
            // only return if the scanner worked
            return UIColor(red: r, green: g, blue: b, alpha: alpha)
        }
        // otherwise return Black
        return UIColor(red: 0, green: 0, blue: 0, alpha: alpha)
    }
}
