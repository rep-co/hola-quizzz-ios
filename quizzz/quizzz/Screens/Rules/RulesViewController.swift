import UIKit

final class RulesViewController: UIViewController {
    private let pageControl = UIPageControl()
    private let nextButton = UIButton()
    private lazy var rulesCollectionView = UICollectionView(frame: .zero,
                                                       collectionViewLayout: collectionViewLayout)
    private let collectionViewLayout = UICollectionViewFlowLayout()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

private extension RulesViewController {
    func setupUI() {
        view.backgroundColor = .blue
        addSubviews()
        setupConstraints()
        setupNextButton()
        setupPageControl()
        setupCollectionViewLayout()
        setupCollectionView()
    }

    func addSubviews() {
        view.addSubview(nextButton)
        view.addSubview(pageControl)
        view.addSubview(rulesCollectionView)
    }

    func setupConstraints() {
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        rulesCollectionView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -34),
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50),
            nextButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50),

            pageControl.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -10),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50),
            pageControl.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50),

            rulesCollectionView.bottomAnchor.constraint(equalTo: pageControl.topAnchor),
            rulesCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            rulesCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            rulesCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
        ])
    }

    func setupNextButton() {
        nextButton.layer.cornerRadius = nextButton.frame.height / 2
        nextButton.setTitle(Const.buttonFirstTitle, for: .normal)
        nextButton.addTarget(
            self,
            action: #selector(buttonAction),
            for: .touchUpInside
        )
    }

    func setupPageControl() {
        pageControl.numberOfPages = Const.rules.count
    }

    func setupCollectionView() {
        rulesCollectionView.delegate = self
        rulesCollectionView.dataSource = self
        rulesCollectionView.register(RuleCollectionViewCell.self,
                                     forCellWithReuseIdentifier: RuleCollectionViewCell.identifier)
        rulesCollectionView.showsHorizontalScrollIndicator = false
        rulesCollectionView.isPagingEnabled = true
        rulesCollectionView.backgroundColor = .clear
    }
    
    func setupCollectionViewLayout() {
        collectionViewLayout.scrollDirection = .horizontal
    }

    @objc func buttonAction(_ sender: UIButton) {
        if pageControl.currentPage < Const.rules.count - 1 {
            Vibration.selection.vibrate()
            rulesCollectionView.scrollToItem(
                at: IndexPath(row: pageControl.currentPage + 1, section: 0),
                at: .centeredHorizontally, animated: true
            )
        } else {
            Vibration.light.vibrate()
            dismiss(animated: true)
        }
    }
}

// MARK: - UICollectionView Delegate & DataSource & FlowLayout
extension RulesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return Const.rules.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: RuleCollectionViewCell.identifier,
            for: indexPath) as? RuleCollectionViewCell
        else { return UICollectionViewCell() }
        
        cell.setup(with: Const.rules[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(
            width: view.frame.width,
            height: rulesCollectionView.frame.height
        )
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / view.frame.width)
        
        switch pageControl.currentPage {
        case 0..<Const.rules.count - 1:
            nextButton.setTitle(Const.buttonFirstTitle, for: .normal)
        case Const.rules.count - 1:
            nextButton.setTitle(Const.buttonLastTitle, for: .normal)
        default:
            break
        }
    }
}

extension RulesViewController {
    private struct Const {
        static let buttonFirstTitle = "Skip"
        static let buttonLastTitle = "Got it!"

        static let rules = [
            RuleView.Info(
                title: "TITLE",
                text: "LocalizeKeys.Rules.rule1Text.localized()",
                image: UIImage(named: "Logo")
            ),
            RuleView.Info(
                title: "TITLE",
                text: "LocalizeKeys.Rules.rule2Text.localized()",
                image: UIImage(named: "Logo")
            ),
            RuleView.Info(
                title: "TITLE",
                text: "LocalizeKeys.Rules.rule3Text.localized()",
                image: UIImage(named: "Logo")
            ),
            RuleView.Info(
                title: "TITLE",
                text: "LocalizeKeys.Rules.rule4Text.localized()",
                image: UIImage(named: "Logo")
            ),
            RuleView.Info(
                title: "TITLE",
                text: "LocalizeKeys.Rules.rule5Text.localized()",
                image: UIImage(named: "Logo")
            )
        ]
    }
}
