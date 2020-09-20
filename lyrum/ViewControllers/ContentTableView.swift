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
    
    var object:PFObject!
    var song:Song!
    
    var artwork: UIImageView!
    var title: BoldLabel!
    var author: DetailLabel!
    var tagLabel: TagLabel!
    
    var likeButton: ToolbarButton!
    var commentButton: ToolbarButton!
    var playButton: ToolbarButton!
    
    var infoLabel: SubDetailLabel!
    
    var spacer: UIView!
    
    var liked:Bool = false
    
    var num_likes:Int = 0
    var num_comments:Int = 0
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
        self.snap()
        self.backgroundColor = .white
        let bg = UIView()
        bg.backgroundColor = UIColor.init(white: 0.95, alpha: 1)
        self.selectedBackgroundView = bg
        
        self.likeButton.onTap {
            self.likeButton.released()
            
            if self.liked {
                self.likeButton.imageView?.tintColor = UIColor(white: 0.8, alpha: 1.0)
                unlikePost(obj: self.object)
                self.num_likes -= 1
            }else{
                self.num_likes += 1
                self.likeButton.imageView?.tintColor = .flatRed()
                likePost(obj: self.object)
            }
            
            self.liked = !self.liked
            
            self.infoLabel.text = "\(self.num_likes) likes | \(self.num_comments) comments"
        }
        
        self.playButton.onTap {
            self.playButton.released()
            SpotifyPlayer.playSong(song: self.song)
            print("Trying to play song..")
            self.playButton.setImage(UIImage(named: "PlayButton")?.withRenderingMode(.alwaysTemplate), for: .normal)
            self.playButton.imageView?.tintColor = .systemYellow            
        }
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
            make.left.equalTo(self.artwork.snp.right).offset(10)
            make.right.equalToSuperview().offset(10)
            make.height.lessThanOrEqualToSuperview()
        }
        
        self.tagLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.author.snp.bottom).offset(10)
            make.left.equalTo(self.artwork.snp.right).offset(10)
//            make.width.equalTo(self.tagLabel.intrinsicContentSize.width+25)
            make.width.lessThanOrEqualToSuperview()
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
            make.bottom.left.right.equalToSuperview().inset(20)
        }
    }
}


protocol RefreshDelegate {
    func didRefresh(identifier:String)
}


class ContentTableView : UITableView, UITableViewDelegate, UITableViewDataSource {
    
    var identifier:String!
    var objects:[PFObject] = []
    var refreshDelegate:RefreshDelegate?
    
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
        
        self.allowsSelection = false
    
        refreshControl = UIRefreshControl()
        refreshControl?.tintColor = .systemPink
        refreshControl?.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.addSubview(refreshControl!)
        refreshControl?.on(.valueChanged, handler: { (control, event) in
            self.refreshDelegate?.didRefresh(identifier: self.identifier)
        })
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let obj = self.objects[indexPath.row]
        let song = pfobj_to_song(obj: obj)
                                
        let cell = tableView.dequeueReusableCell(withIdentifier: self.identifier, for: indexPath) as! ContentCell
        
        cell.song = song
        cell.object = obj
        cell.setArtwork(url: song.artwork)
        cell.title.text = song.title + " By " + song.artist
        cell.author.text = "@" + (PFUser.current()!.object(forKey: "name") as! String).lowercased().replacingOccurrences(of: " ", with: "")
        cell.tagLabel.text = "   "+song.tag+"   "
        
        cell.playButton.setImage(UIImage(named: "PlayOutline")?.withRenderingMode(.alwaysTemplate), for: .normal)
        cell.playButton.imageView?.tintColor = UIColor(white: 0.8, alpha: 1.0)
        
//        cell.snap()
        
        cell.liked = false
        
        let likes = obj.object(forKey: "likes") as! [String]
        cell.num_likes = likes.count
        cell.num_comments = obj.object(forKey: "numComments") as! Int
        cell.infoLabel.text = "\(likes.count) likes | \(cell.num_comments) comments"
        
        let uid = PFUser.current()!.objectId!
        if likes.contains(uid) {
            cell.liked = true
            cell.likeButton.imageView?.tintColor = .flatRed()
        }else{
            cell.liked = false
            cell.likeButton.imageView?.tintColor = UIColor(white: 0.8, alpha: 1.0)
        }
        
        obj.fetchIfNeededInBackground { (obj, err) in
            let likes = obj!.object(forKey: "likes") as! [String]
            let uid = PFUser.current()!.objectId!
            if likes.contains(uid) {
                cell.liked = true
                cell.likeButton.imageView?.tintColor = .flatRed()
            }else{
                cell.liked = false
                cell.likeButton.imageView?.tintColor = UIColor(white: 0.8, alpha: 1.0)
            }
            
            // Update likes again
            let num_likes:Int = (obj!.object(forKey: "likes") as! [String]).count
            cell.num_likes = num_likes
            cell.num_comments = obj!.object(forKey: "numComments") as! Int
            cell.infoLabel.text = "\(num_likes) likes | \(cell.num_comments) comments"
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
