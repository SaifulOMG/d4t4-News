//
//  TableView.swift
//  d4t4 News
//
//  Created by Briteyellow on 26/11/2023.
//

import SwiftUI
import UIKit

struct TableView: UIViewControllerRepresentable {
    @EnvironmentObject var viewModel: NewsViewModel
    var navigate: () -> ()
    
    func makeUIViewController(context: Context) -> UITableViewController {
        let tableViewController = UITableViewController()
        tableViewController.tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "CustomCell")
        tableViewController.tableView.delegate = context.coordinator
        tableViewController.tableView.dataSource = context.coordinator
        return tableViewController
    }

    func updateUIViewController(_ uiViewController: UITableViewController, context: Context) {
        context.coordinator.viewModel = viewModel
        uiViewController.tableView.reloadData()
    }

    func makeCoordinator() -> TableViewController {
        TableViewController(self, navigate: navigate)
    }

    class TableViewController: NSObject, UITableViewDelegate, UITableViewDataSource, CustomTableViewCellDelegate {
        var parent: TableView
        var viewModel: NewsViewModel
        var navigate: () -> ()
        
        init(_ tableView: TableView, navigate: @escaping () -> (Void)) {
            self.parent = tableView
            self.viewModel = tableView.viewModel
            self.navigate = navigate
        }

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            viewModel.articles.count
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomTableViewCell
            cell.delegate = self
            cell.configure(with: viewModel.articles[indexPath.row])
            return cell
        }

        func didTapSpeechButton(withText text: String) {
            viewModel.speakText(text)
        }

        func didTapViewButton(withURL url: String) {
            viewModel.selectedItemURL = url
            print(url)
            navigate()
        }
    }
}
