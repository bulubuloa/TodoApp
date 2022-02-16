//
//  CallListViewModel.swift
//  TodoApp
//
//  Created by Omnimobile on 2/16/22.
//

import Foundation
import RxSwift
import RxRelay
import RxCocoa

class CallListViewModel: BaseViewModel {
    struct Input {
        let queryParameter: BehaviorRelay<CallRequestModel>
    }
    
    struct Output {
        let result: BehaviorRelay<[CallModel]>
        let loading: Driver<Bool>
    }
    
    func makeBinding(input: Input) -> Output {
        let queryResult = BehaviorRelay<[CallModel]>(value: [])
        let observableTrackingLoadingState = BehaviorRelay<Bool>(value: false)
        
        let observableQueryItems = input.queryParameter.flatMapLatest { [weak self]
            queryParameter -> Observable<[CallModel]> in
            if let self = self {
                let getItems: Single<[CallModel]> = self.todoService.getToCall(parameter: queryParameter).catchAndReturn([])
                return getItems.asObservable()
            } else {
                return Observable.just([])
            }
        }.share()
        
        observableQueryItems
             .bind(to: queryResult)
             .disposed(by: disposeBag)
        
        Observable.merge(
            input.queryParameter.map { _ in true },
            observableQueryItems.map { _ in false })
            .bind(to: observableTrackingLoadingState)
            .disposed(by: disposeBag)
        
        return Output(result: queryResult, loading: observableTrackingLoadingState.asDriver())
    }
}
