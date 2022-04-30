//
//  ViewOutput.swift
//  FINCH TAXI
//
//  Created by Marlowe Wind on 10.02.2022.
//

protocol ViewOutput {
    func viewIsReady()
    func viewWillAppear()
    func viewWillLayoutSubviews()
    func viewDidLayoutSubviews()
    func viewDidAppear()
    func viewWillDisappear()
    func viewDidDisappear ()
}

extension ViewOutput {
    func viewIsReady() { }
    func viewWillAppear() { }
    func viewWillLayoutSubviews() { }
    func viewDidLayoutSubviews() { }
    func viewDidAppear() { }
    func viewWillDisappear() { }
    func viewDidDisappear () { }
}

