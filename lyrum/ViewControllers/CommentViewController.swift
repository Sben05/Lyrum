//
//  CommentViewController.swift
//  lyrum
//
//  Created by Josh Arnold on 9/19/20.
//

import UIKit
import Parse
import SnapKit
import ChameleonFramework


class CommentCell : UITableViewCell {
    
    var author:BoldLabel!
    var date:SubDetailLabel!
    var comment:DetailLabel!
    var spacer:UIView! = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .white
        
        author = BoldLabel()
        self.contentView.addSubview(author)
        
        date = SubDetailLabel()
        self.contentView.addSubview(date)
        
        comment = DetailLabel()
        self.contentView.addSubview(comment)
        
        self.contentView.addSubview(self.spacer)
        
        author.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().inset(10)
            make.width.lessThanOrEqualToSuperview()
            make.height.lessThanOrEqualToSuperview()
        }
        
        date.snp.makeConstraints { (make) in
            make.top.right.equalToSuperview().inset(10)
            make.width.lessThanOrEqualToSuperview()
            make.height.lessThanOrEqualToSuperview()
        }
        
        comment.snp.makeConstraints { (make) in
            make.top.equalTo(self.author.snp.bottom).offset(5)
            make.left.right.equalToSuperview().inset(10)
            make.height.lessThanOrEqualToSuperview()
        }
        
        spacer.snp.makeConstraints { (make) in
            make.top.equalTo(self.comment.snp.bottom).offset(5)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


class CommentTableView : UITableView, UITableViewDelegate, UITableViewDataSource {
    
    
    var identifier:String!
    var objects:[PFObject] = []
    
    init(identifier:String) {
        super.init(frame: .zero, style: .plain)
        self.identifier = identifier
        self.register(CommentCell.self, forCellReuseIdentifier: identifier)
        self.delegate = self
        self.dataSource = self
        self.backgroundColor = .white
        self.separatorColor = .none
        self.separatorStyle = .none
        self.showsVerticalScrollIndicator = false
        self.alwaysBounceVertical = true
        self.allowsSelection = false
        self.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
//        return objects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
//        let obj = self.objects[indexPath.row]
                                        
        let cell = tableView.dequeueReusableCell(withIdentifier: self.identifier, for: indexPath) as! CommentCell
    
        cell.author.text = "@jarnold"
        cell.date.text = "6:11PM"
        cell.comment.text = "This song is absolute fire!"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}



class CommentViewController: UIViewController {
    
    var post:PFObject!
    
    var tableView:CommentTableView!
    
    init(post:PFObject) {
        super.init(nibName: nil, bundle: nil)
        self.post = post
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setup()
        
        tableView = CommentTableView(identifier: "comments")
        self.view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}


extension CommentViewController {
    
    func setup() {
        
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.tintColor = .systemPink
        let yourBackImage = UIImage(named: "BackArrow")
        self.navigationController?.navigationBar.backIndicatorImage = yourBackImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = yourBackImage
        self.navigationController?.navigationBar.backItem?.title = ""
        
        let inst = CenterLabel()
        inst.text = "Comments"
        inst.sizeToFit()
        let pink = UIColor.init(red: 245/255, green: 0/255, blue: 155/255, alpha: 1.0)
        let yellow = UIColor.init(red: 255/255, green: 180/255, blue: 0, alpha: 1.0)
        let grad = UIColor.init(gradientStyle: UIGradientStyle.leftToRight, withFrame: CGRect(x: 0, y: 0, width: inst.intrinsicContentSize.width+25, height: inst.intrinsicContentSize.height), andColors: [pink, yellow])
        inst.textColor = grad
        self.navigationItem.titleView = inst
    }
}
