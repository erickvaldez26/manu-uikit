//
//  HomeRepositoryProtocol.swift
//  manu
//
//  Created by Erick Valdez on 2/05/25.
//

protocol HomeRepositoryProtocol: AnyObject {
    func getUserData() async throws -> UserInfo
    func getAllLoans() async throws -> [Loans]
    func getAllMonthlyPayment() async throws -> [MonthlyPayment]
}
