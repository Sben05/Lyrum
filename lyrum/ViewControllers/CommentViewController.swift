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
import InputBarAccessoryView


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
        self.keyboardDismissMode = .onDrag
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.objects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
        let obj = self.objects[indexPath.row]
                                        
        let cell = tableView.dequeueReusableCell(withIdentifier: self.identifier, for: indexPath) as! CommentCell
    
        let formatter1 = DateFormatter()
        formatter1.dateStyle = .short
        let date = formatter1.string(from: obj.createdAt!)
        
        let user = obj.object(forKey: "user") as! PFUser
        let name = user.object(forKey: "name") as! String
        
        cell.author.text = "@" + (name.lowercased().replacingOccurrences(of: " ", with: ""))
        cell.date.text = date
        cell.comment.text = obj.object(forKey: "text") as! String
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}



class CommentViewController: UIViewController, UITextViewDelegate {
    
    var post:PFObject!
    var comments:[PFObject] = []
    var toolbar:FacebookInputBar!
    
    var tableView:CommentTableView!
        
    override var inputAccessoryView: UIView? {
        return self.toolbar
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
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
        
        self.toolbar = FacebookInputBar.init(frame: CGRect.init(x: 0, y: 0, width: self.view.frame.width, height: 60))
        
        self.toolbar.sendButton.onTap {
            self.toolbar.sendButton.startAnimating()
            self.toolbar.sendButton.isUserInteractionEnabled = false
            self.toolbar.inputTextView.placeholder = "Posting..."
            let text = self.toolbar.inputTextView.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            self.toolbar.inputTextView.text = ""
            
            commentPost(post: self.post, text: text, user: PFUser.current()!) { (success) in
                
                self.toolbar.sendButton.isUserInteractionEnabled = true
                self.toolbar.inputTextView.placeholder = "Aa"
                self.toolbar.sendButton.stopAnimating()
                
                if !success {
                    self.showPopup()
                }else{
                    // query comments
                    self.query()
                }
            }
        }
        
        self.toolbar.inputTextView.delegate = self
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(CommentViewController.keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.query()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if self.comments.count > 4 {
            self.tableView.scrollToBottom()
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            if keyboardHeight > 10 {
                self.tableView.snp.remakeConstraints { (make) in
                    make.top.left.right.equalToSuperview()
                    make.height.equalTo(self.view.frame.height-keyboardHeight)
                }
                        
                UIView.animate(withDuration: 0.25, animations: {
                    self.view.layoutIfNeeded()
                }) { (done) in
                    
                }
            }
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
    
    func query() {
        query_comments(post: self.post) { (done, obj) in
            if !done {
                self.showPopup()
            }else{
                self.comments = obj
                self.tableView.objects = self.comments
                self.tableView.reloadData()
            }
        }
    }
}


class FacebookInputBar: InputBarAccessoryView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        self.backgroundColor = .white
        self.contentView.backgroundColor = .white
        self.backgroundView.backgroundColor = .white
        
        inputTextView.backgroundColor = UIColor.init(white: 0.95, alpha: 1)
        inputTextView.placeholderTextColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
        inputTextView.textContainerInset = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        inputTextView.placeholderLabelInsets = UIEdgeInsets(top: 8, left: 20, bottom: 8, right: 20)
        inputTextView.layer.borderColor = UIColor.clear.cgColor
        inputTextView.layer.borderWidth = 0.0
//        inputTextView.tintColor = .placeholderText
        inputTextView.font = UIFont.subDetail
        inputTextView.placeholderLabel.font = .detail
        inputTextView.layer.cornerRadius = 19.0
        inputTextView.layer.masksToBounds = true
        inputTextView.scrollIndicatorInsets = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        inputView?.tintColor = .systemPink
        inputTextView.textColor = .black
        
        self.sendButton.titleLabel?.font = .detail
        self.sendButton.setTitleColor(.systemPink, for: .normal)
    }
    
}

