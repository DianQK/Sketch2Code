import UIKit

class GuideViewController : UIViewController {

    class TitleLabelView : UILabel {

        required init() {
            super.init(frame: CGRect.zero)
            self.frame = CGRect(x: 20, y: 20, width: 20, height: 20)
            self.backgroundColor = .black
        }

        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

    }

    let titleLabelView: TitleLabelView = TitleLabelView()

    class ContentTextView : UILabel {

        required init() {
            super.init(frame: CGRect.zero)
            self.frame = CGRect(x: 20, y: 20, width: 20, height: 20)
            self.backgroundColor = .black
        }

        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

    }

    let contentTextView: ContentTextView = ContentTextView()

    class NextButtonView : UIView {

    }

    let nextButtonView: NextButtonView = NextButtonView()

    override func viewDidLoad () {
        super.viewDidLoad()
        view.backgroundColor = .white

        view.addSubview(titleLabelView)
        titleLabelView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(contentTextView)
        contentTextView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nextButtonView)
        nextButtonView.translatesAutoresizingMaskIntoConstraints = false

    }

}
