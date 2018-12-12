import UIKit

class GuideViewController : UIViewController {

    class TitleLabel : UILabel {

        required init() {
            super.init(frame: CGRect.zero)
            self.numberOfLines = 0
            self.text = Optional("What happens if I don’t renew my license?")
            self.font = UIFont(name: "PingFangSC-Semibold", size: 17.0) ?? UIFont.systemFont(ofSize: 17.0)
        }

        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

    }

    let titleLabel: TitleLabel = TitleLabel()

    class ContentTextLabel : UILabel {

        required init() {
            super.init(frame: CGRect.zero)
            self.numberOfLines = 0
            self.text = Optional("If you don’t want to renew your license after it expires, you can continue to use the version of Sketch that you have, for as long as you want, but you won’t be able to receive any further updates. You will no longer be able to upload new documents to Sketch Cloud but you can still sign in to Sketch Cloud to view, comment on, and download documents. Any documents you previously uploaded will stay on Cloud until you choose to remove them. If you decide you want to renew at a later date, that’s fine — you’re welcome back at any time.")
            self.font = UIFont(name: "Helvetica", size: 12.0) ?? UIFont.systemFont(ofSize: 12.0)
        }

        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

    }

    let contentTextLabel: ContentTextLabel = ContentTextLabel()

    class NextButtonView : UIView {

        required init() {
            super.init(frame: CGRect.zero)
        }

        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

    }

    let nextButtonView: NextButtonView = NextButtonView()

    override func viewDidLoad () {
        super.viewDidLoad()
        view.backgroundColor = .white

        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(contentTextLabel)
        contentTextLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nextButtonView)
        nextButtonView.translatesAutoresizingMaskIntoConstraints = false

        titleLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 15.0).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -15.0).isActive = true
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20.0).isActive = true
        contentTextLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 15.0).isActive = true
        contentTextLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -15.0).isActive = true
        contentTextLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10.0).isActive = true
        nextButtonView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 15.0).isActive = true
        nextButtonView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -15.0).isActive = true
        nextButtonView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20.0).isActive = true
        nextButtonView.heightAnchor.constraint(equalToConstant: 50.0).isActive = true

    }

}

class LayoutViewController : UIViewController {

    class Rectangle6View : UIView {

        required init() {
            super.init(frame: CGRect.zero)
            self.backgroundColor = UIColor(red: 0.0, green: 0.5333333333333333, blue: 0.5686274509803921, alpha: 1.0)
        }

        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

    }

    let rectangle6View: Rectangle6View = Rectangle6View()

    class Rectangle5View : UIView {

        required init() {
            super.init(frame: CGRect.zero)
            self.backgroundColor = UIColor(red: 0.7450980392156863, green: 0.2156862745098039, blue: 0.2156862745098039, alpha: 1.0)
        }

        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

    }

    let rectangle5View: Rectangle5View = Rectangle5View()

    class Rectangle4View : UIView {

        required init() {
            super.init(frame: CGRect.zero)
            self.backgroundColor = UIColor(red: 0.5411764705882353, green: 0.4745098039215686, blue: 0.6862745098039216, alpha: 1.0)
        }

        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

    }

    let rectangle4View: Rectangle4View = Rectangle4View()

    class Rectangle3View : UIView {

        required init() {
            super.init(frame: CGRect.zero)
            self.backgroundColor = UIColor(red: 0.8274509803921568, green: 0.5490196078431373, blue: 0.6784313725490195, alpha: 1.0)
        }

        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

    }

    let rectangle3View: Rectangle3View = Rectangle3View()

    class Rectangle2View : UIView {

        required init() {
            super.init(frame: CGRect.zero)
            self.backgroundColor = UIColor(red: 1.0, green: 0.8235294117647058, blue: 0.6470588235294118, alpha: 1.0)
        }

        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

    }

    let rectangle2View: Rectangle2View = Rectangle2View()

    class Rectangle1View : UIView {

        required init() {
            super.init(frame: CGRect.zero)
            self.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 0.7568627450980392, alpha: 1.0)
        }

        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

    }

    let rectangle1View: Rectangle1View = Rectangle1View()

    override func viewDidLoad () {
        super.viewDidLoad()
        view.backgroundColor = .white

        view.addSubview(rectangle6View)
        rectangle6View.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(rectangle5View)
        rectangle5View.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(rectangle4View)
        rectangle4View.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(rectangle3View)
        rectangle3View.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(rectangle2View)
        rectangle2View.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(rectangle1View)
        rectangle1View.translatesAutoresizingMaskIntoConstraints = false

        rectangle6View.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 258.0).isActive = true
        rectangle6View.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20.0).isActive = true
        rectangle6View.topAnchor.constraint(equalTo: rectangle3View.bottomAnchor, constant: 20.0).isActive = true
        rectangle6View.heightAnchor.constraint(equalToConstant: 163.0).isActive = true
        rectangle5View.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 139.0).isActive = true
        rectangle5View.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20.0).isActive = true
        rectangle5View.topAnchor.constraint(equalTo: rectangle6View.bottomAnchor, constant: 20.0).isActive = true
        rectangle5View.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20.0).isActive = true
        rectangle4View.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 139.0).isActive = true
        rectangle4View.topAnchor.constraint(equalTo: rectangle3View.bottomAnchor, constant: 20.0).isActive = true
        rectangle4View.widthAnchor.constraint(equalToConstant: 99.0).isActive = true
        rectangle4View.heightAnchor.constraint(equalToConstant: 94.0).isActive = true
        rectangle3View.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 140.0).isActive = true
        rectangle3View.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -19.0).isActive = true
        rectangle3View.topAnchor.constraint(equalTo: rectangle1View.bottomAnchor, constant: 20.0).isActive = true
        rectangle3View.heightAnchor.constraint(equalToConstant: 94.0).isActive = true
        rectangle2View.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20.0).isActive = true
        rectangle2View.topAnchor.constraint(equalTo: rectangle1View.bottomAnchor, constant: 20.0).isActive = true
        rectangle2View.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20.0).isActive = true
        rectangle2View.widthAnchor.constraint(equalToConstant: 99.0).isActive = true
        rectangle1View.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20.0).isActive = true
        rectangle1View.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20.0).isActive = true
        rectangle1View.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20.0).isActive = true
        rectangle1View.heightAnchor.constraint(equalToConstant: 90.0).isActive = true

    }

}

