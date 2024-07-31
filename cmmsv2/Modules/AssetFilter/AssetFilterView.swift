//
//  AssetFilterView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 25/07/24.
//

import UIKit
import SkeletonView

class AssetFilterView: BaseViewController {
    
    @IBOutlet weak var backButton: UIImageView!
    @IBOutlet weak var containerTextFieldStackView: UIStackView!
    @IBOutlet weak var containerContentStackView: UIStackView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var closeButton: UIImageView!
    @IBOutlet weak var containerHistoryStackView: UIStackView!
    @IBOutlet weak var historyTitleLabel: UILabel!
    @IBOutlet weak var deleteHistoryButton: UILabel!
    @IBOutlet weak var historyTableView: UITableView!
    @IBOutlet weak var containerAssetListStackView: UIStackView!
    @IBOutlet weak var countItemLabel: UILabel!
    @IBOutlet weak var assetCollectionView: UICollectionView!
    @IBOutlet weak var actionBarView: ActionBarView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var presenter: AssetFilterPresenter?
    var historyData: [AssetFilterEntity] = []
    var assetData: [Equipment] = []
    var selectedHistory: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupBody()
        self.validateUser()
        self.configureKeyboard()
    }
    
}

extension AssetFilterView {
    
    private func setupBody() {
        setupView()
        setupAction()
        bindingData()
        setupDelegate()
        fetchInitData()
        setupTextField()
        setupTableView()
        setupCollectionView()
        configureHistoryData()
    }
    
    private func setupView() {
        containerTextFieldStackView.makeCornerRadius(8)
        containerContentStackView.addShadow(0.6)
        containerTextFieldStackView.addShadow(0.6)
        actionBarView.configure(
            firstIcon: "square.and.arrow.down",
            firstTitle: "Instalasi",
            secondIcon: "wrench.and.screwdriver",
            secondTitle: "Kondisi",
            thirdIcon: "circle.grid.2x2",
            thirdTitle: "Kategori",
            fourthIcon: "arrow.up.arrow.down.square",
            fourthTitle: "Urutkan")
    }
    
    private func setupAction() {
        backButton.gesture()
            .sink { [weak self] _ in
                guard let self, let navigation = self.navigationController else { return }
                navigation.popViewController(animated: true)
            }
            .store(in: &anyCancellable)
        
        deleteHistoryButton.gesture()
            .sink { [weak self] _ in
                guard let self else { return }
                AppManager.clearAllSearchHistory()
                self.configureHistoryData()
            }
            .store(in: &anyCancellable)
    }
    
    private func setupDelegate() {
        self.actionBarView.delegate = self
    }
    
    private func fetchInitData() {
        guard let presenter else { return }
        presenter.fetchInstallationList()
    }
    
    private func bindingData() {
        guard let presenter else { return }
        presenter.$equipmentData
            .receive(on: DispatchQueue.main)
            .sink { [weak self] data in
                guard let self,
                      let equipment = data,
                      let reff = equipment.reff,
                      let count = reff.totalItem
                else { return }
                
                self.hideLoadingPopup()
                self.reloadCollectionViewWithAnimation(self.assetCollectionView)
                
                if Int(count) == .zero {
                    self.countItemLabel.text = "Tidak dapat menemukan item"
                } else {
                    self.countItemLabel.text = "Berhasil menemukan \(count) item"
                }
            }
            .store(in: &anyCancellable)
        
        presenter.$equipment
            .receive(on: DispatchQueue.main)
            .sink { [weak self] data in
                guard let self
                else {
                    self?.showSpinner(false)
                    return
                }
                self.assetData = data
                self.hideLoadingPopup()
                self.reloadCollectionViewWithAnimation(self.assetCollectionView)
                self.showSpinner(false)
                
                if let text = self.searchTextField.text, !text.isEmpty || self.selectedHistory != nil {
                    self.containerHistoryStackView.isHidden = true
                    self.containerAssetListStackView.isHidden = false
                    self.actionBarView.isHidden = false
                } else {
                    self.containerHistoryStackView.isHidden = false
                    self.containerAssetListStackView.isHidden = true
                    self.actionBarView.isHidden = true
                }
            }
            .store(in: &anyCancellable)
    }
    
    private func setupTextField() {
        self.searchTextField.delegate = self
        self.searchTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingDidEnd)
    }
    
    @objc private func textFieldDidChange() {
        guard let text = searchTextField.text, let presenter else { return }
        if !text.isEmpty {
            let data = AssetFilterEntity(title: text)
            AppManager.setSearchHistory(data)
            self.configureHistoryData()
            presenter.fetchInitData(search: text)
            self.showLoadingPopup()
        }
    }
    
    private func setupTableView() {
        historyTableView.dataSource = self
        historyTableView.delegate = self
        historyTableView.register(SearchHistoryCell.nib, forCellReuseIdentifier: SearchHistoryCell.identifier)
        historyTableView.separatorStyle = .none
        historyTableView.showsVerticalScrollIndicator = false
        historyTableView.showsHorizontalScrollIndicator = false
        historyTableView.isScrollEnabled = true
        historyTableView.isUserInteractionEnabled = true
    }
    
    private func setupCollectionView() {
        assetCollectionView.dataSource = self
        assetCollectionView.delegate = self
        assetCollectionView.register(AssetCVC.nib, forCellWithReuseIdentifier: AssetCVC.identifier)
        assetCollectionView.isSkeletonable = true
        assetCollectionView.showAnimatedGradientSkeleton()
        assetCollectionView.isScrollEnabled = true
        assetCollectionView.isUserInteractionEnabled = true
    }
    
    func configureHistoryData() {
        self.historyData = AppManager.getSearchHistory() ?? []
        self.reloadTableViewWithAnimation(self.historyTableView)
    }
    
    func showSpinner(_ isShow: Bool) {
        self.spinner.isHidden = !isShow
        isShow ? self.spinner.startAnimating() : self.spinner.stopAnimating()
    }
    
}

extension AssetFilterView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
