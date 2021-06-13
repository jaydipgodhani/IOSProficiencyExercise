//
//  TblFactsCell.swift
//  IOSProficiencyExercise
//
//  Created by Jaydip Godhani on 13/06/21.
//

import UIKit

let factsCellIdentifier = "TblFactsCell"

class TblFactsCell: UITableViewCell {

    //MARK:- Views
    lazy var factsImage: UIImageView = {
        let icon = UIImageView()
        icon.contentMode = .scaleAspectFill
        icon.layer.cornerRadius = 8
        icon.layer.masksToBounds = true
        icon.backgroundColor = .lightGray
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }()
    lazy var factsTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 1
        label.text = "title"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var factsDescription: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .lightGray
        label.textAlignment = .left
        label.numberOfLines = 0
        label.text = "Description"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK:- Start
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    // MARK: - Start
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.backgroundColor = .white
        self.contentView.addSubview(factsImage)
        self.contentView.addSubview(factsTitle)
        self.contentView.addSubview(factsDescription)
        
        setupUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        setupUI()
    }
    
    //MARK:- Setup UI with auto layout programatically
    private func setupUI() {
        NSLayoutConstraint.activate([
            factsImage.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16),
            factsImage.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 16),
            factsImage.heightAnchor.constraint(equalToConstant: 50),
            factsImage.widthAnchor.constraint(equalToConstant: 50),
            
            factsTitle.leftAnchor.constraint(equalTo: factsImage.rightAnchor, constant: 16),
            factsTitle.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -16),
            factsTitle.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16),
            factsTitle.heightAnchor.constraint(equalToConstant: 22),
            
            factsDescription.leftAnchor.constraint(equalTo: factsImage.rightAnchor, constant: 16),
            factsDescription.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -16),
            factsDescription.topAnchor.constraint(equalTo: factsTitle.bottomAnchor, constant: 4),
            factsDescription.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant:  -8),
            
        ])
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    
    //// Set the variable
    var facts: Facts! {
        didSet {
            factsTitle.text = facts.title ?? "-"
            factsDescription.text = facts.rowDescription ?? "-"
            
            //// Some images are not load so just show the blank image
            if let strImage = facts.imageHref {
                factsImage.imageFromServerURL(strImage, placeHolder: UIImage())
            } else {
                factsImage.image = UIImage()
            }
        }
    }
}

//// Extension for displaying image
//// Load image from url using `URLSession`
let imageCache = NSCache<NSString, UIImage>()
extension UIImageView {
    func imageFromServerURL(_ URLString: String, placeHolder: UIImage?) {
        self.image = nil
        let imageServerUrl = URLString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        if let cachedImage = imageCache.object(forKey: NSString(string: imageServerUrl)) {
            self.image = cachedImage
            return
        }
        if let url = URL(string: imageServerUrl) {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                if error != nil {
                    DispatchQueue.main.async {
                        self.image = placeHolder
                    }
                    return
                }
                DispatchQueue.main.async {
                    if let data = data {
                        if let downloadedImage = UIImage(data: data) {
                            imageCache.setObject(downloadedImage, forKey: NSString(string: imageServerUrl))
                            self.image = downloadedImage
                        }
                    }
                }
            }).resume()
        }
    }
}
