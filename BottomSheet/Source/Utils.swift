//
//  Utils.swift
//  BottomSheet
//
//  Created by farhad jebelli on 2/16/19.
//  Copyright © 2019 farhad jebelli. All rights reserved.
//

import Foundation

func clamp<T: Comparable>(value: T, min minv: T, max maxv: T) -> T {
    return min(max(value, minv), maxv)
}
