import UIKit
import SnapKit
import Then
import Contacts

class NomeetingViewController: UIViewController {
    
    // MARK: - UI Components
    private let infoLabel = UILabel().then {
        $0.text = "등록된 회원과 서로 추천되지 않습니다."
        $0.textAlignment = .center
        $0.numberOfLines = 0 
        $0.font = UIFont.pretendardSemiBold(size: 20)
    }
    
    private let fetchContactsButton = ActualGradientButton().then {
        $0.setTitle("연락처 불러오기", for: .normal)
        $0.backgroundColor = .systemPink
        $0.layer.cornerRadius = 20
        $0.titleLabel?.font = UIFont.pretendardSemiBold(size: 16)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
        self.layoutViews()
        fetchContactsButton.addTarget(self, action: #selector(fetchContacts), for: .touchUpInside)
    }

    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(infoLabel)
        view.addSubview(fetchContactsButton)
    }

    private func layoutViews() {
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(300)
            make.centerX.equalToSuperview()
            make.left.right.equalTo(view).inset(20)
        }
        
        fetchContactsButton.snp.makeConstraints { make in
            make.top.equalTo(infoLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(50)
        }
    }

    // MARK: - Actions
    @objc func fetchContacts() {
        let store = CNContactStore()
        store.requestAccess(for: .contacts) { (granted, error) in
            if granted {
                let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey] as [CNKeyDescriptor]
                let request = CNContactFetchRequest(keysToFetch: keys)
                do {
                    try store.enumerateContacts(with: request) { (contact, stop) in
                        // 연락처 정보 처리
                        print("Name: \(contact.givenName) \(contact.familyName)")
                        print("Phone: \(contact.phoneNumbers.first?.value.stringValue ?? "")")
                    }
                } catch {
                    print("Unable to fetch contacts.")
                }
            } else {
                print("Access Denied")
            }
        }
    }
}
