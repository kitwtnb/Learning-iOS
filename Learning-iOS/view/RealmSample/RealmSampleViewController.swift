//
//  RealmSampleViewController.swift
//  Learning-iOS
//
//  Created by Keita Watanabe on 2019/05/08.
//  Copyright © 2019 Keita Watanabe. All rights reserved.
//

import RealmSwift
import UIKit

class Record: Object {
    @objc dynamic var title = ""
}

class RealmSampleViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var inputText: UITextField!

    private var records: [Record] = []
    private var notificationToken: NotificationToken? = nil

    deinit {
        notificationToken?.invalidate()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let realm = try! Realm()
        let results = realm.objects(Record.self)
        notificationToken = results.observe { [weak self] changes in
            switch changes {
            case .initial(results): fallthrough
            case .update(results, _, _, _):
                self?.records = Array(results)
                self?.tableView.reloadData()
            default: break
            }
        }
    }

    @IBAction func onTappedSave(_ sender: Any) {
        guard let text = inputText.text, !text.isEmpty else { return }
        inputText.text = ""

        let record = Record()
        record.title = text

        let realm = try! Realm()
        try! realm.write {
            realm.add(record)
        }
    }
}

extension RealmSampleViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return records.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = records[indexPath.row].title

        return cell
    }
}
