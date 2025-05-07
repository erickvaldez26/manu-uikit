//
//  HomeUseCase.swift
//  manu
//
//  Created by Erick Valdez on 2/05/25.
//

import FirebaseFirestore

protocol HomeUseCasesProtocol: AnyObject {
    func getUserData() async -> Result<UserInfo, MNRequestError>
    func getAllMonthlyPayment() async -> Result<[MonthlyPayment], MNRequestError>
}

class HomeUseCases: HomeUseCasesProtocol {
    private let repository: HomeRepositoryProtocol
    
    init(repository: HomeRepositoryProtocol) {
        self.repository = repository
    }
    
    func getUserData() async -> Result<UserInfo, MNRequestError> {
        let result = await repository.getUserData()
        
        switch result {
        case .success(let data):
            let user = UserInfo(
                email: data.email,
                name: data.name,
                totalBalance: data.totalBalance
            )
            return .success(user)
        case .failure(let error):
            return .failure(MNRequestError(from: error))
        }
    }
    
    func getAllMonthlyPayment() async -> Result<[MonthlyPayment], MNRequestError> {
        let result = await repository.getAllMonthlyPayment()
        
        switch result {
        case .success(let data):
            var dataConvert: [MonthlyPayment] = []
            let _ = data.map {
                let model = MonthlyPayment(
                    amount: $0.amount,
                    endDate: $0.endDate,
                    imageRef: $0.imageRef,
                    nameService: $0.nameService,
                    paymentDate: $0.paymentDate,
                    quotas: $0.quotas,
                    startDate: $0.startDate,
                    typeService: $0.typeService
                )
                dataConvert.append(model)
            }
            return .success(dataConvert)
        case .failure(let error):
            return .failure(MNRequestError(from: error))
        }
    }
}
