
import UIKit

final class MainScreenCell: UICollectionViewCell{
    struct Info {
        let title: String
        let description: String
    }
    var data: Info? {
        didSet {
            guard let data else { return }
            titleLabel.text = data.title
            descriptionLabel.text = data.description
        }
    }

    private let  titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()

    static let identifier = "MainScreenCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupConstraints()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setupUI()
    }
}

private extension MainScreenCell {
     func addSubviews() {
         contentView.addSubview(descriptionLabel)
         titleLabel.translatesAutoresizingMaskIntoConstraints = false
         descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
         contentView.addSubview(titleLabel)
    }
    func setupUI(){
        layer.cornerRadius = 16
        clipsToBounds = true
        layer.masksToBounds  = true
        contentView.backgroundColor = .white
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 7),

            descriptionLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            descriptionLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
}
