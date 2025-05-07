//
//  HomeRepositoryProtocol.swift
//  manu
//
//  Created by Erick Valdez on 2/05/25.
//

protocol HomeRepositoryProtocol: AnyObject {
    func getUserData() async -> Result<UserInfoResponseDTO, Error>
    func getAllMonthlyPayment() async -> Result<[MonthlyPaymentResponseDTO], Error>
}
