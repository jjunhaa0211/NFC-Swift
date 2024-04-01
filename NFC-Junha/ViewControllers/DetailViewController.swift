import UIKit
import SnapKit
import Then
import CoreNFC

class DetailViewController: UIViewController {
    private let record: NFCNDEFPayload
    
    private let typeNameFormatLabel: UILabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        $0.numberOfLines = 0
    }
    private let typeLabel: UILabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        $0.numberOfLines = 0
    }
    
    private let identifierLabel: UILabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        $0.numberOfLines = 0
    }
    private let payloadLabel: UILabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        $0.numberOfLines = 0
    }
    
    private let typeNameFormatHeaderLabel = UILabel().then {
        $0.text = "타입 이름 포맷"
        $0.font = UIFont.systemFont(ofSize: 24, weight: .bold)
    }
    
    private let scrollView: UIScrollView = UIScrollView()
    private let mainView: UIView = UIView()
    
    init(record: NFCNDEFPayload) {
        self.record = record
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        self.setUpSubviews()
    }
    
    private func setUpSubviews() {
        self.setUpScrollView()
        self.setUpTypeNameFormatLabels()
        self.setUpTypeLabels()
        self.setUpIdentifierLabels()
        self.setUpPayloadLabels()
        
        self.typeNameFormatLabel.text = self.record.typeNameFormatString()
        self.typeLabel.text = self.record.typeString()
        self.identifierLabel.text = self.record.identifierString()
        self.payloadLabel.text = self.record.payloadString()
    }
    
    private func setUpTypeNameFormatLabels() {
        
        mainView.addSubview(typeNameFormatHeaderLabel)
        
        typeNameFormatHeaderLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(16)
            $0.top.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset( -16)
        }
        
        mainView.addSubview(self.typeNameFormatLabel)
        
        typeNameFormatLabel.snp.makeConstraints {
            $0.top.equalTo(typeNameFormatHeaderLabel.snp.bottom).offset(8)
            $0.left.equalToSuperview().offset(32)
            $0.right.equalToSuperview().offset(-16)
        }
    }
    
    private func setUpTypeLabels() {
        let typeHeaderLabel = UILabel().then {
            $0.text = "타입"
            $0.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        }
        
        mainView.addSubview(typeHeaderLabel)
        
        typeHeaderLabel.snp.makeConstraints {
            $0.top.equalTo(typeNameFormatLabel.snp.bottom).offset(16)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset( -16)
        }
        
        mainView.addSubview(typeLabel)
        
        typeLabel.snp.makeConstraints {
            $0.top.equalTo(typeHeaderLabel.snp.bottom).offset(8)
            $0.left.equalToSuperview().offset(32)
            $0.right.equalToSuperview().offset(-16)
        }
    }
    
    private func setUpIdentifierLabels() {
        let identifierHeaderLabel = UILabel().then {
            $0.text = "식별자"
            $0.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        }
        
        mainView.addSubview(identifierHeaderLabel)
        
        identifierHeaderLabel.snp.makeConstraints {
            $0.top.equalTo(typeLabel.snp.bottom).offset(16)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset( -16)
        }
        
        mainView.addSubview(identifierLabel)
        
        identifierLabel.snp.makeConstraints {
            $0.top.equalTo(identifierHeaderLabel.snp.bottom).offset(8)
            $0.left.equalToSuperview().offset(32)
            $0.right.equalToSuperview().offset(-16)
        }
    }
    
    private func setUpPayloadLabels() {
        let payloadHeaderLabel = UILabel().then {
            $0.text = "페이로드"
            $0.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        }
        
        self.mainView.addSubview(payloadHeaderLabel)
        
        payloadHeaderLabel.snp.makeConstraints {
            $0.top.equalTo(identifierLabel.snp.bottom).offset(16)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset( -16)
        }
        self.mainView.addSubview(payloadLabel)
        
        self.payloadLabel.snp.makeConstraints {
            $0.top.equalTo(payloadHeaderLabel.snp.bottom).offset(8)
            $0.left.equalToSuperview().offset(32)
            $0.right.equalToSuperview().offset(-16)
            $0.bottom.equalToSuperview().offset(-16)
        }
    }
    
    private func setUpScrollView() {
        self.view.addSubview(scrollView)
        
        self.scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        self.scrollView.addSubview(mainView)
        
        self.mainView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(view.snp.width)
        }
    }
}
