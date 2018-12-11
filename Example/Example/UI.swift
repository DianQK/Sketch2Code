import UIKit

class GuideViewController : UIViewController {

    class TitleLabel : UILabel {

        required init() {
            super.init(frame: CGRect.zero)
            self.numberOfLines = 0
            self.text = Optional("What happens if I don’t renew my license?")
            self.font = UIFont(name: "SFProText-Semibold", size: 17.0) ?? UIFont.systemFont(ofSize: 17.0)
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
        contentTextLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 52.0).isActive = true
        nextButtonView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 15.0).isActive = true
        nextButtonView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -15.0).isActive = true
        nextButtonView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20.0).isActive = true
        nextButtonView.heightAnchor.constraint(equalToConstant: 50.0).isActive = true

    }

}
