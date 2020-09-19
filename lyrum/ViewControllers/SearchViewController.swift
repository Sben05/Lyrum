//
//  SearchViewController.swift
//  lyrum
//
//  Created by Josh Arnold on 9/19/20.
//

import UIKit
import SkyFloatingLabelTextField
import SpringButton


protocol SongSearchDelegate {
    func foundSong(songId:String)
}


class SearchCell: UITableViewCell {
    
    var artwork: UIImageView!
    var title: BoldLabel!
    var artist: DetailLabel!
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


extension SearchCell {
    
    func setupUI() {
        artwork = UIImageView()
        artwork.backgroundColor = UIColor.init(white: 0.97, alpha: 1)
        self.contentView.addSubview(artwork)
        
        title = BoldLabel()
        self.contentView.addSubview(title)
        
        self.artist = DetailLabel()
        self.contentView.addSubview(self.artist)
        
        spacer = UIView()
        self.contentView.addSubview(spacer)
    }
    
    func snap() {
        artwork.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview()
            make.height.width.equalTo(50)
        }
        
        self.title.snp.makeConstraints { (make) in
            make.top.equalToSuperview()//.offset(5)
            make.left.equalTo(self.artwork.snp.right).offset(10)
            make.right.equalToSuperview().offset(10)
            make.height.lessThanOrEqualToSuperview()
        }
        
        self.artist.snp.makeConstraints { (make) in
            make.top.equalTo(self.title.snp.bottom)
            make.left.equalTo(self.artwork.snp.right).offset(10)
            make.right.equalToSuperview().offset(10)
            make.height.lessThanOrEqualToSuperview()
        }
        
        self.spacer.snp.makeConstraints { (make) in
            make.top.equalTo(artwork.snp.bottom)
            make.bottom.left.right.equalToSuperview().inset(2)
        }
    }
}



class SearchTableView : UITableView, UITableViewDelegate, UITableViewDataSource {
    
    var identifier:String!
    var results:[String] = ["test", "test", "test"]
    var searchDelegate: SongSearchDelegate?
    
    init(identifier:String) {
        super.init(frame: .zero, style: .plain)
        self.identifier = identifier
        self.register(SearchCell.self, forCellReuseIdentifier: identifier)
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
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.identifier, for: indexPath) as! SearchCell
        cell.setArtwork(url: "https://images.genius.com/3736dc67a26ac7a30d7db2255a32f7c1.500x500x1.jpg")
        cell.title.text = "2 am"
        cell.artist.text = "Che Ecru"
        cell.snap()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        searchDelegate?.foundSong(songId: "0001")
    }
}



class SearchViewController: UIViewController, SongSearchDelegate {
    
    var searchBar: SkyFloatingLabelTextFieldWithIcon!
    var resultsTableView: SearchTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.setupSearchBar()
        
        self.resultsTableView = SearchTableView(identifier: "searchTableView")
        self.resultsTableView.searchDelegate = self
        self.view.addSubview(self.resultsTableView)
        self.resultsTableView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalToSuperview().offset(20)
        }
        
        let cancel = SpringButton(style: .Minimal)
        cancel.setImage(UIImage(named: "Down")?.withRenderingMode(.alwaysTemplate), for: .normal)
        cancel.imageView?.tintColor = .systemPink
        cancel.color = .systemPink
        cancel.sizeToFit()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: cancel)
        
        cancel.onTap {
            cancel.released()
            self.dismiss(animated: true, completion: nil)
        }
        
        self.searchBar.onChange { (text) in
            if text == "" {
                self.searchBar.setTitleVisible(false, animated: true, animationCompletion: nil)
            }else{
                self.searchBar.setTitleVisible(true, animated: true, animationCompletion: nil)
            }
            
            self.searchForSongs(text: text)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.searchBar.becomeFirstResponder()
    }
    
    func searchForSongs(text:String) {
        print(text)
    }
    
    func foundSong(songId: String) {
        self.dismiss(animated: true, completion: nil)
    }
}


extension SearchViewController {
    func setupSearchBar() {
        searchBar = SkyFloatingLabelTextFieldWithIcon(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 0))
        searchBar.placeholder = "Search music"
        searchBar.title = "lyrum"
        searchBar.tintColor = .systemPink
        searchBar.selectedTitleColor = .systemPink
        searchBar.lineColor = .clear
        searchBar.selectedLineColor = .clear
        searchBar.font = UIFont.text
        searchBar.iconType = .image
        searchBar.iconColor = UIColor.systemPink
        searchBar.selectedIconColor = .systemPink
        searchBar.iconMarginBottom = -2.0
        searchBar.iconMarginLeft = 4.0
        searchBar.iconImage = UIImage(named: "Search")?.withRenderingMode(.alwaysTemplate)
        self.navigationItem.titleView = searchBar
    }
}
