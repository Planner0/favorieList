//
//  ViewController.swift
//  favoriteList
//
//  Created by ALEKSANDR POZDNIKIN on 04.09.2022.
//

import UIKit

final class ViewController: UIViewController {
    
    var movieArray: [Movie] = [first, second]
    
    //MARK: Properties
    private lazy var titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Title"
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.cornerRadius = 7
        textField.layer.backgroundColor = UIColor.white.cgColor
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.systemGray.cgColor
    return textField
    }()
    
    private lazy var yearTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Year"
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.cornerRadius = 7
        textField.layer.backgroundColor = UIColor.white.cgColor
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.systemGray.cgColor
        textField.keyboardType = .numberPad
    return textField
    }()
    
    private lazy var addButton: UIButton = {
        let button = UIButton()
        button.configuration = .filled()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Add", for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var favoriteMovieTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setup()
    }
    
    //MARK: Methods
    private func setup() {
        
        self.view.addSubview(titleTextField)
        self.view.addSubview(yearTextField)
        self.view.addSubview(addButton)
        self.view.addSubview(favoriteMovieTableView)
        
        NSLayoutConstraint.activate([
            
            self.titleTextField.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 30),
            self.titleTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.titleTextField.heightAnchor.constraint(equalToConstant: 40),
            self.titleTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            
            self.yearTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.yearTextField.topAnchor.constraint(equalTo: self.titleTextField.bottomAnchor, constant: 16),
            self.yearTextField.heightAnchor.constraint(equalToConstant: 40),
            self.yearTextField.widthAnchor.constraint(equalTo: self.titleTextField.widthAnchor),
            
            self.addButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.addButton.topAnchor.constraint(equalTo: self.yearTextField.bottomAnchor, constant: 16),
            self.addButton.heightAnchor.constraint(equalToConstant: 40),
            self.addButton.widthAnchor.constraint(equalToConstant: 70),
            
            self.favoriteMovieTableView.topAnchor.constraint(equalTo: self.addButton.bottomAnchor, constant: 30),
            self.favoriteMovieTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.favoriteMovieTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.favoriteMovieTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    @objc func buttonTapped() {
        
        guard let title = self.titleTextField.text, let year = self.yearTextField.text, !year.isEmpty, !title.isEmpty, Int(year) != nil else {
            let alert = customAlert(message: "Wrong data")
            self.present(alert, animated: true, completion: nil)
            print("error: Wrong data")
            return }
        
        self.titleTextField.text = ""
        self.yearTextField.text = ""
        print("Not empty")
        
        guard (self.movieArray.firstIndex(where: {$0.title == title}) == nil) else {
            let alert = customAlert(message: "You have this movie in favorite list")
            self.present(alert, animated: true, completion: nil)
            print("error: You have this movie in favorite list")
            return }
        let movie = Movie(title: title, year: Int(year) ?? 0)
        self.movieArray.append(movie)
        print(movieArray)
        self.favoriteMovieTableView.reloadData()
        
    }
}
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = "\(self.movieArray[indexPath.row].title) \(self.movieArray[indexPath.row].year)"
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let contextItem = UIContextualAction(style: .destructive, title: "Delete") { (action, view, success) in
            print("delete")
            self.movieArray.remove(at: indexPath.row)
            self.favoriteMovieTableView.deleteRows(at: [indexPath], with: .automatic)
        }
        contextItem.image = UIImage(systemName: "multiply.circle.fill")
        let swipeActions = UISwipeActionsConfiguration(actions: [contextItem])

        return swipeActions
    }
}

func customAlert(message: String) -> UIAlertController {
    let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
    let actionOk = UIAlertAction(title: "OK", style: .cancel) { actionOk in
        print("Tap Ok")
    }
    alert.addAction(actionOk)
    return alert
}
