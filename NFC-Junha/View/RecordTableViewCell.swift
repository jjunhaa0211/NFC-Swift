import UIKit
import SnapKit
import Then

class RecordTableViewCell: UITableViewCell {
    private let typeLabel: UILabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
    }
    private let identifierLabel: UILabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 16, weight: .medium)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.layout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        backgroundColor = .white
        
        self.addSubview(identifierLabel)
        
        identifierLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-32)
        }
        
        self.addSubview(typeLabel)
        
        typeLabel.snp.makeConstraints {
            $0.top.equalTo(self.identifierLabel.snp.bottom).offset(8)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-32)
            $0.bottom.equalToSuperview().offset(-8)
        }
                
        self.accessoryType = .disclosureIndicator
    }
}

extension RecordTableViewCell {
    func configure(identifier: String?, type: String?) {
        self.identifierLabel.text = "식별자: \(identifier ?? "")"
        self.typeLabel.text = "타입: \(type ?? "")"
    }
}
