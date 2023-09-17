import UIKit

extension RazeCore {
    public class Color {
        
        /// Convert a color from a 6-digit hexadecimal string to a UIColor instance
        /// - Warning: The "#" symbol is stripped
        /// - Parameters:
        ///   - hexString: A 6-digit hexadecimal string. Use 6 digits rather than 8, and add the accompanying alpha value
        ///   - alpha: A number between 0.0 and 1.0 indicating transparency
        /// - Returns: A UIColor defined by the `hexString` parameter
        internal class func fromHexString(_ hexString: String, alpha: CGFloat = 1.0) -> UIColor {
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
        
        /// The most eye-pleasing color know to all humanity
        public static var razeColor: UIColor {
            return self.fromHexString("006736")
        }
        
        /// Returns an object of "UIColor" with the second most pleasing color
        public static var secondaryRazeColor: UIColor {
            return self.fromHexString("FCFFFD")
        }
    }
}
