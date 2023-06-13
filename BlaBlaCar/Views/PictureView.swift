//
//  PictureView.swift
//  BlaBlaCar
//
//  Created by Paulina Gnas on 09/06/2023.
//

import SwiftUI

struct PictureView: View {
    
    let driver: Driver
    @State private var imageScale: CGFloat = 1
    @State private var imageOffset: CGSize = .zero
    
    func resetImageState() {
        return withAnimation(.spring()) {
            imageScale = 1
            imageOffset = .zero
        }
    }
    
    var body: some View {
        Image(driver.image!)
            .resizable()
            .scaleEffect(imageScale)
            .scaledToFit()
            .offset(x: imageOffset.width, y: imageOffset.height)
        
        //MARK: - 1. TAP GESTURE
            .onTapGesture(count: 2, perform: {
                if imageScale == 1 {
                    withAnimation(.spring()) {
                        imageScale = 5
                    }
                } else {
                    resetImageState()
                }
            })
        
        //MARK: - 2. DRAG GESTURE
            .gesture(
                DragGesture()
                    .onChanged({ value in
                        withAnimation(.linear(duration: 1)) {
                            imageOffset = value.translation
                        }
                    })
                    .onEnded({ _ in
                        if imageScale <= 1 {
                            resetImageState()
                        }
                    })
            )
        
        //MARK: - 3. MAGNIFICATION
            .gesture(
                MagnificationGesture()
                    .onChanged({ value in
                        withAnimation(.linear(duration: 1)) {
                            if imageScale >= 1 && imageScale <= 5 {
                                imageScale = value
                            } else if imageScale > 5 {
                                imageScale = 5
                            }
                        }
                    })
                    .onEnded({ _ in
                        if imageScale > 5 {
                            imageScale = 5
                        } else if imageScale <= 1 {
                            resetImageState()
                        }
                    })
            )
    }
}
