//
//  LoginScreenFactory.swift
//  manu
//
//  Created by Erick Valdez on 26/04/25.
//

struct LoginScreenFactory {
    static func createViewController(coordinator: AuthenticationCoordinator) -> AuthLoginViewController {
        AuthLoginViewController(viewModel: createViewModel(), coordinator: coordinator)
    }
    
    private static func createViewModel() -> AuthLoginViewModel {
        AuthLoginViewModel(useCase: createUseCase())
    }
    
    private static func createUseCase() -> LoginUseCasesImpl {
        LoginUseCasesImpl(repository: createRepository())
    }
    
    private static func createRepository() -> LoginRepositoryImpl {
        LoginRepositoryImpl(dataSource: createDateSource())
    }
    
    private static func createDateSource() -> LoginDataSourceImpl {
        LoginDataSourceImpl()
    }
}
