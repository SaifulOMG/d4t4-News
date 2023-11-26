//
//  TableView.swift
//  d4t4 News
//
//  Created by Briteyellow on 26/11/2023.
//

import SwiftUI
import UIKit

struct TableView: UIViewControllerRepresentable {
    typealias UIViewControllerType = UITableViewController

    @Binding var items: [ArticleDetail]
    @Binding var selectedItem: ArticleDetail?

    func makeUIViewController(context: Context) -> UITableViewController {
        let tableViewController = UITableViewController()
        tableViewController.tableView.delegate = context.coordinator
        tableViewController.tableView.dataSource = context.coordinator
        return tableViewController
    }

    func updateUIViewController(_ uiViewController: UITableViewController, context: Context) {
        context.coordinator.items = items
        uiViewController.tableView.reloadData()
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UITableViewDelegate, UITableViewDataSource {
        var parent: TableView
        var items: [ArticleDetail] = []

        init(_ tableView: TableView) {
            self.parent = tableView
        }

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            items.count
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            cell.textLabel?.text = items[indexPath.row].title
            return cell
        }

        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            parent.selectedItem = items[indexPath.row]
        }
    }
}