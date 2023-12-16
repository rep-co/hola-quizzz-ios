import UIKit

final class RuleView: UIView {
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    func setup(with info: Info) {
        titleLabel.text = info.title
        subtitleLabel.text = info.text
        imageView.image = info.image
    }
}

private extension RuleView {
    func setupUI() {
        addSubviews()
        setupConstraints()
        setupTitle()
        setupSubtitle()
        setupImageView()
    }

    func addSubviews() {
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        addSubview(imageView)
    }
    
    func setupConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate ([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            titleLabel.heightAnchor.constraint(equalToConstant: 50),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            subtitleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            subtitleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),

            imageView.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 10),
            imageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            imageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
        ])
    }
    
    func setupTitle() {
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 1
        titleLabel.font = .systemFont(ofSize: 20)
    }
    
    func setupSubtitle() {
        subtitleLabel.textAlignment = .center
        subtitleLabel.numberOfLines = 0
        subtitleLabel.font = .systemFont(ofSize: 16)
    }
    
    func setupImageView() {
        imageView.contentMode = .scaleAspectFit
    }
}

extension RuleView {
    struct Info {
        let title: String
        let text: String
        let image: UIImage?
    }
}
