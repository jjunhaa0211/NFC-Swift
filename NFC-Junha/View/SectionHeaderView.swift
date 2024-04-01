import UIKit
import SnapKit
import Then

class SectionHeaderView: UIView {
    
    let label = UILabel().then {
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 16, weight: .bold)
    }
    
    init(section: Int) {
        super.init(frame: .zero)
        
        self.label.text = "번호 \(section)"
        self.backgroundColor = .black
        self.addSubview(label)
        
        label.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.bottom.equalToSuperview().offset(-8)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
