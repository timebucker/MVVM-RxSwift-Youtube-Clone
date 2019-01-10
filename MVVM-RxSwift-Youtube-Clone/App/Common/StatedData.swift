//
//  StateData.swift
//  MVVM-RxSwift-Youtube-Clone
//
//  Created by Nguyen D.Nhan on 1/10/19.
//  Copyright © 2019 Nguyen D.Nhan. All rights reserved.
//

enum StatedData<T, E, O> {
    /// default state
    case uninitialized
    /// no data to show
    case empty
    /// failed to request API because of networking
    case noNetwork(hasData: Bool)
    /// new data available
    case data(T)
    /// an error has been occurred
    case error(E)
    /// user-defined state
    case other(O)
}
