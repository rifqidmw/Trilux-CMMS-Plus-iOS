//
//  FloatingActionButton.swift
//  cmmsv2
//
//  Created by macbook  on 15/09/24.
//

import UIKit
import Combine

protocol FloatingActionButtonDelegate: AnyObject {
    func didTapActionItem(_ idx: Int)
}

class FloatingActionButton: UIView {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var initialHeightTableView: NSLayoutConstraint!
    @IBOutlet weak var openedAddButton: UIView!
    @IBOutlet weak var closedAddButton: UIView!
    
    var data: [FloatingActionEntity] = [] {
        didSet {
            self.setupTableView()
            self.calculateTotalHeight(for: self.tableView)
            self.tableView.reloadData()
        }
    }
    var isOpened: Bool = false {
        didSet {
            toggleButtons(isOpened)
        }
    }
    weak var delegate: FloatingActionButtonDelegate?
    @Published public var totalHeightTable: CGFloat = 0
    var anyCancellable = Set<AnyCancellable>()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        let view = loadNib()
        view.frame = self.bounds
        self.addSubview(view)
        self.configureSharedComponent()
        self.setupAction()
    }
    
}

extension FloatingActionButton {
    
    private func configureSharedComponent() {
        self.openedAddButton.layer.cornerRadius = self.openedAddButton.bounds.width / 1.6
        self.openedAddButton.clipsToBounds = true
        self.closedAddButton.layer.cornerRadius = self.closedAddButton.bounds.width / 2
        self.closedAddButton.clipsToBounds = true
        self.toggleButtons(isOpened, animated: false)
    }
    
    private func setupTableView() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(FloatingActionCell.nib, forCellReuseIdentifier: FloatingActionCell.identifier)
        self.tableView.separatorStyle = .none
        self.tableView.isHidden = true
        self.tableView.alpha = 0
    }
    
    private func setupAction() {
        self.openedAddButton.gesture()
            .sink { [weak self] _ in
                guard let self else { return }
                self.isOpened.toggle()
            }
            .store(in: &anyCancellable)
        
        self.closedAddButton.gesture()
            .sink { [weak self] _ in
                guard let self else { return }
                self.isOpened.toggle()
            }
            .store(in: &anyCancellable)
    }
    
    private func toggleButtons(_ isOpened: Bool, animated: Bool = true) {
        let duration: TimeInterval = animated ? 0.3 : 0
        
        UIView.animate(withDuration: duration, animations: {
            if isOpened {
                self.openedAddButton.alpha = 1
                self.closedAddButton.alpha = 0
                self.tableView.alpha = 1
                self.tableView.isHidden = false
            } else {
                self.openedAddButton.alpha = 0
                self.closedAddButton.alpha = 1
                self.tableView.alpha = 0
                self.tableView.isHidden = true
            }
        }) { _ in
            self.openedAddButton.isHidden = !isOpened
            self.closedAddButton.isHidden = isOpened
        }
    }
    
}

extension FloatingActionButton: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FloatingActionCell.identifier, for: indexPath) as? FloatingActionCell
        else {
            return UITableViewCell()
        }
        
        cell.setupCell(self.data[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        guard let delegate = self.delegate else { return }
        delegate.didTapActionItem(index)
    }
    
    func calculateTotalHeight(for tableView: UITableView) {
        var totalHeight: CGFloat = 0
        
        for row in 0..<tableView.numberOfRows(inSection: 0) {
            let indexPath = IndexPath(row: row, section: 0)
            totalHeight += tableView.rectForRow(at: indexPath).height
        }
        
        let maxHeight: CGFloat = 400
        if totalHeight > maxHeight {
            self.initialHeightTableView.constant = maxHeight
        } else {
            self.initialHeightTableView.constant = totalHeight
        }
        self.totalHeightTable = totalHeight
    }
    
}
