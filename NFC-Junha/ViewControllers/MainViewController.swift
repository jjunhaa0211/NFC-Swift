import UIKit
import CoreNFC
import SnapKit
import Then

class MainViewController: UIViewController {
    private var manager: NFCManager?
    private let tableView = UITableView().then {
        $0.register(RecordTableViewCell.self, forCellReuseIdentifier: "RecordCell")
    }
    
    private var messages: [NFCNDEFMessage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavigationBar()
        setUpUI()
        
        manager = NFCManager(didDetectTag: { [unowned self] m in
            addNewMessage(message: m)
            }, didInvalidateWithError: { err in
                print("Error: \(err)")
        })
    }
    
    private func addNewMessage(message: NFCNDEFMessage) {
        self.messages.append(message)
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    private func setUpNavigationBar() {
        self.title = "NFC 태그"
        
        _ = UIBarButtonItem(image: UIImage(systemName: "barcode.viewfinder"), style: .plain, target: self, action: #selector(refresh)).then {
            self.navigationItem.rightBarButtonItem = $0
        }
        _ = UIBarButtonItem(image: UIImage(systemName: "arrow.triangle.2.circlepath"), style: .plain, target: self, action: #selector(clean)).then {
            self.navigationItem.leftBarButtonItem = $0
        }
                
        self.navigationController?.navigationBar.tintColor = .black
    }
    
    @objc private func refresh() {
        self.manager?.startLookingForTag()
    }
    
    private func setUpUI() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension MainViewController {
    @objc private func clean() {
        messages.removeAll()
        tableView.reloadData()
    }
}

extension MainViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages[section].records.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecordCell", for: indexPath) as? RecordTableViewCell else {
            fatalError("Cannot dequeue record cell!")
        }
        
        let record = messages[indexPath.section].records[indexPath.row]
        
        cell.configure(identifier: record.identifierString(), type: record.typeString())
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return SectionHeaderView(section: section)
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let detailViewController = DetailViewController(record: self.messages[indexPath.section].records[indexPath.row])
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}
