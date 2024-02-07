//
//  ProfileViewController.swift
//  Bambook
//
//  Created by Диас Сайынов on 10.01.2024.
//

import UIKit
import SnapKit

enum Sections: Int {
    case ForYou = 0
    case Popular = 1
    case Trending = 2
    case TopRated = 3
}

final class FeedViewController: UIViewController, FeedViewProtocol, UISearchBarDelegate {
    var presenter: FeedPresenterProtocol?
    var books: [BookData]?
    private var filteredBooks: [BookData] = []
    let sectionTitles: [String] = ["For you", "Popular", "Trending", "Top rated"]
    
    private var searchBar: UISearchBar?
    private var tapGestureRecognizer: UITapGestureRecognizer?
    private var isSearching = false
    
    private var isBestseller = false
    private var bestsellers: [BookData] = []
    
    private var isNew = false
    private var new: [BookData] = []
    
    private lazy var bestsellersButton: CustomStyledButton = {
        let button = CustomStyledButton()
        button.setTitle("Bestsellers", for: .normal)
        button.addTarget(self, action: #selector(bestsellerButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var newButton: CustomStyledButton = {
        let button = CustomStyledButton()
        button.setTitle("New", for: .normal)
        button.addTarget(self, action: #selector(newButtonTapped), for: .touchUpInside)
        return button
    }()

    private let categoriesButton: CustomStyledButton = {
        let button = CustomStyledButton()
        button.setTitle("Categories", for: .normal)
        return button
    }()

    
    private let homeFeedTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        table.backgroundColor = UIColor(red: 0.18, green: 0.18, blue: 0.18, alpha: 1.00)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.18, green: 0.18, blue: 0.18, alpha: 1.00)
        presenter?.viewDidLoad()
        
        configureNavBar()
        setupButtons()
        
        view.addSubview(homeFeedTable)
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
                
        let headerView = HeaderUIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 400))
        headerView.presenter = presenter
        homeFeedTable.tableHeaderView = headerView
    }
    
    private func setupButtons() {
        view.addSubview(bestsellersButton)
        view.addSubview(newButton)
        view.addSubview(categoriesButton)

        bestsellersButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(100)
            $0.width.equalTo(100)
            $0.height.equalTo(30)
        }

        newButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(bestsellersButton.snp.bottom).offset(20)
            $0.width.equalTo(100)
            $0.height.equalTo(30)
        }

        categoriesButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(newButton.snp.bottom).offset(20)
            $0.width.equalTo(100)
            $0.height.equalTo(30)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavBar()
    }
    
    func reloadData() {
        homeFeedTable.reloadData()
    }
    
    private func configureNavBar() {
        searchBar?.delegate = self
        
        let bestsellersButtonItem = UIBarButtonItem(customView: bestsellersButton)
        let newButtonItem = UIBarButtonItem(customView: newButton)
        let categoriesButtonItem = UIBarButtonItem(customView: categoriesButton)
        navigationItem.leftBarButtonItems = [bestsellersButtonItem, newButtonItem, categoriesButtonItem]
            
        let searchButton = UIButton(type: .custom)
        
        searchButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)

        let rightBarButtonItem = UIBarButtonItem(customView: searchButton)
        navigationItem.rightBarButtonItem = rightBarButtonItem

        navigationController?.navigationBar.tintColor = .white
        
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapOutsideSearchBar))
        tapGestureRecognizer?.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGestureRecognizer!)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterBooks(with: searchText)
    }
    
    private func filterBooks(with searchText: String) {
        if searchText.isEmpty {
            isSearching = false
        } else {
            guard let booksToFilter = presenter?.getPopularBooks() else { return }
            filteredBooks = booksToFilter.filter { $0.title.lowercased().contains(searchText.lowercased()) }
            isSearching = true
        }
        if isSearching {
            homeFeedTable.tableHeaderView = nil
        } else {
            let headerView = HeaderUIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 400))
            headerView.presenter = presenter
            homeFeedTable.tableHeaderView = headerView
        }
        homeFeedTable.reloadData()
        view.setNeedsLayout()
        view.layoutIfNeeded()
    }
    
    @objc private func handleTapOutsideSearchBar() {
        guard let searchBar = searchBar, let tapGestureRecognizer = tapGestureRecognizer else {
            return
        }

        let tapLocation = tapGestureRecognizer.location(in: view)

        if !searchBar.frame.contains(tapLocation) {
            toggleSearchBarVisibility()
        }
    }
    
    @objc private func searchButtonTapped() {
        toggleSearchBarVisibility()
    }
    
    private func toggleSearchBarVisibility() {
        if searchBar == nil {
            navigationItem.leftBarButtonItems = nil
            navigationItem.rightBarButtonItem = nil

            searchBar = UISearchBar()
            searchBar?.placeholder = "Search"
            searchBar?.showsCancelButton = false
            searchBar?.delegate = self
            navigationItem.titleView = searchBar

            searchBar?.becomeFirstResponder()
        } else {
            searchBar?.removeFromSuperview()
            searchBar = nil
            isSearching = false
            homeFeedTable.reloadData()
            configureNavBar()
        }
    }
    
    @objc private func bestsellerButtonTapped() {
        isBestseller.toggle()
        if isNew{
            isNew.toggle()
            self.resetNewButton()
        }
        UIView.transition(with: homeFeedTable, duration: 0.3, options: .transitionCrossDissolve, animations: {
            if self.isBestseller {
                self.bestsellersButton.backgroundColor = .white
                self.bestsellersButton.setTitleColor(.black, for: .normal)
                
                self.homeFeedTable.tableHeaderView = nil
                self.bestsellers = self.presenter?.getPopularBooks() ?? []
                self.homeFeedTable.reloadData()
            } else {
                self.resetBestsellerButton()
            }
        }, completion: nil)
    }
    
    @objc private func newButtonTapped() {
        isNew.toggle()
        if isBestseller{
            isBestseller.toggle()
            self.resetBestsellerButton()
        }
        UIView.transition(with: homeFeedTable, duration: 0.3, options: .transitionCrossDissolve, animations: {
            if self.isNew {
                self.newButton.backgroundColor = .white
                self.newButton.setTitleColor(.black, for: .normal)
                
                self.homeFeedTable.tableHeaderView = nil
                self.new = self.presenter?.getPopularBooks() ?? []
                self.homeFeedTable.reloadData()
            } else {
                self.resetNewButton()
            }
        }, completion: nil)
    }
    
    private func resetBestsellerButton(){
        self.bestsellersButton.backgroundColor = .clear
        self.bestsellersButton.setTitleColor(.white, for: .normal)
        self.bestsellersButton.layer.borderColor = UIColor.white.cgColor
        
        let headerView = HeaderUIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 400))
        headerView.presenter = self.presenter
        self.homeFeedTable.tableHeaderView = headerView
        self.isBestseller = false
        self.homeFeedTable.reloadData()
    }
    
    private func resetNewButton(){
        self.newButton.backgroundColor = .clear
        self.newButton.setTitleColor(.white, for: .normal)
        self.newButton.layer.borderColor = UIColor.white.cgColor
        
        let headerView = HeaderUIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 400))
        headerView.presenter = self.presenter
        self.homeFeedTable.tableHeaderView = headerView
        self.isNew = false
        self.homeFeedTable.reloadData()
    }

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeFeedTable.frame = view.bounds
    }

}

extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if isSearching || isBestseller || isNew{
            return 1
        } else {
            return sectionTitles.count
        }
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell else {
            return UITableViewCell()
        }
        cell.presenter = presenter
        if isSearching{
            cell.configure(with: filteredBooks)
        } else if isBestseller {
            cell.configure(with: bestsellers)
        } else if isNew {
            cell.configure(with: new)
        } else {
            switch indexPath.section{
            case Sections.ForYou.rawValue:
                cell.configure(with: presenter?.getPopularBooks() ?? [])
            case Sections.Popular.rawValue:
                cell.configure(with: presenter?.getRecommendationBooks() ?? [])
            case Sections.Trending.rawValue:
                cell.configure(with: presenter?.getPopularBooks() ?? [])
            case Sections.TopRated.rawValue:
                cell.configure(with: presenter?.getPopularBooks() ?? [])
            default:
                return UITableViewCell()
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset
        
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {
            return
        }
        
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.origin.y, width: 100, height: header.bounds.height)
        header.textLabel?.textColor = .white
        header.textLabel?.text = header.textLabel?.text?.capitalized
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if isSearching {
            return "Search Results"
        } else if isBestseller {
            return "Bestsellers"
        } else if isNew {
            return "New"
        }else {
            return sectionTitles[section]
        }
    }
}
