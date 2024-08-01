import UIKit

extension CGFloat {

    /// Создание модификаторов числа меняющихся в зависимости от размеров экрана

    var fitW: CGFloat {
        return self * screenSize.width / designSize.width
    }

    var fitH: CGFloat {
        return self * screenSize.height / designSize.height
    }

    private var screenSize: CGSize { UIScreen.main.bounds.size }
    private var designSize: CGSize { CGSize(width: 375, height: 812) }
}
