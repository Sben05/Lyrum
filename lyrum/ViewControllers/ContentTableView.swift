//
//  ContentTableView.swift
//  lyrum
//
//  Created by Josh Arnold on 9/19/20.
//

import UIKit
import Parse
import Kingfisher


class ContentCell: UITableViewCell {
    
    var artwork: UIImageView!
    var title: BoldLabel!
    var author: DetailLabel!
    var tagLabel: TagLabel!
    
    
    var likeButton: ToolbarButton!
    var commentButton: ToolbarButton!
    var playButton: ToolbarButton!
    
    var infoLabel: SubDetailLabel!
    
    var spacer: UIView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
        self.backgroundColor = .white
        let bg = UIView()
        bg.backgroundColor = UIColor.init(white: 0.95, alpha: 1)
        self.selectedBackgroundView = bg
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setArtwork(url:String) {
        artwork.kf.setImage(with: URL(string: url))
    }
    
}

extension ContentCell {
    func setupUI() {
        artwork = UIImageView()
        artwork.backgroundColor = UIColor.init(white: 0.97, alpha: 1)
        self.contentView.addSubview(artwork)
        
        title = BoldLabel()
        self.contentView.addSubview(title)
        
        self.author = DetailLabel()
        self.contentView.addSubview(self.author)
        
        self.tagLabel = TagLabel()
        self.contentView.addSubview(self.tagLabel)
        
        likeButton = ToolbarButton(name: "HeartFilled")
        self.contentView.addSubview(likeButton)
        
        commentButton = ToolbarButton(name: "Comment")
        self.contentView.addSubview(commentButton)
        
        playButton = ToolbarButton(name: "PlayOutline")
        self.contentView.addSubview(playButton)
        
        infoLabel = SubDetailLabel()
        self.contentView.addSubview(infoLabel)
        
        spacer = UIView()
        self.contentView.addSubview(spacer)
    }
    
    func snap() {
        artwork.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview()
            make.height.width.equalTo(80)
        }
        
        self.title.snp.makeConstraints { (make) in
            make.top.equalToSuperview()//.offset(5)
            make.left.equalTo(self.artwork.snp.right).offset(10)
            make.right.equalToSuperview().offset(10)
            make.height.lessThanOrEqualToSuperview()
        }
        
        self.author.snp.makeConstraints { (make) in
            make.top.equalTo(self.title.snp.bottom)
            make.left.equalTo(self.artwork.snp.right).offset(15)
            make.right.equalToSuperview().offset(10)
            make.height.lessThanOrEqualToSuperview()
        }
        
        self.tagLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.author.snp.bottom).offset(10)
            make.left.equalTo(self.artwork.snp.right).offset(10)
            make.width.equalTo(self.tagLabel.intrinsicContentSize.width+25)
            make.height.equalTo(25)
        }
        
        self.likeButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.tagLabel.snp.bottom).offset(15)
            make.left.equalTo(self.artwork.snp.right).offset(10)
            make.width.height.equalTo(20)
        }
        
        self.commentButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.tagLabel.snp.bottom).offset(15)
            make.left.equalTo(self.likeButton.snp.right).offset(10)
            make.width.height.equalTo(20)
        }
        
        self.playButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.tagLabel.snp.bottom).offset(15)
            make.left.equalTo(self.commentButton.snp.right).offset(10)
            make.width.height.equalTo(20)
        }
        
        self.infoLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.likeButton.snp.bottom).offset(15)
            make.left.equalTo(self.artwork.snp.right).offset(10)
            make.right.equalToSuperview()
            make.height.lessThanOrEqualToSuperview()
        }
        
        self.spacer.snp.makeConstraints { (make) in
            make.top.equalTo(infoLabel.snp.bottom)
            make.bottom.left.right.equalToSuperview().inset(80)
        }
    }
}


class ContentTableView : UITableView, UITableViewDelegate, UITableViewDataSource {
    
    var identifier:String!
    
    init(identifier:String) {
        super.init(frame: .zero, style: .plain)
        self.identifier = identifier
        self.register(ContentCell.self, forCellReuseIdentifier: identifier)
        self.delegate = self
        self.dataSource = self
        self.backgroundColor = .white
        self.separatorColor = .none
        self.separatorStyle = .none
        self.showsVerticalScrollIndicator = false
        self.alwaysBounceVertical = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.identifier, for: indexPath) as! ContentCell
        cell.setArtwork(url: "https://images.genius.com/3736dc67a26ac7a30d7db2255a32f7c1.500x500x1.jpg")
        cell.title.text = "2 am By Che Ecru"
        cell.author.text = "@jarnold97"
        cell.tagLabel.text = "chill"
        cell.tagLabel.setGradient()
        cell.infoLabel.text = "49 likes | 72 comments | 2.1K views"
        cell.snap()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
