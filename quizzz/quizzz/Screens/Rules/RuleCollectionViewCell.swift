import UIKit

final class RuleCollectionViewCell: UICollectionViewCell {
    static let identifier = "RuleCollectionViewCell"
    private let ruleView = RuleView()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    func setup(with model: RuleView.Info) {
        ruleView.setup(with: model)
    }
}

private extension RuleCollectionViewCell {
    func setupUI() {
        addSubviews()
        setupConstraints()
    }

    func addSubviews() {
        contentView.addSubview(ruleView)
    }

    func setupConstraints() {
        ruleView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            ruleView.topAnchor.constraint(equalTo: self.topAnchor),
            ruleView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            ruleView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            ruleView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
}
