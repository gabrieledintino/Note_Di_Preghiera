//
//  Tile.swift
//  Canta e Cammina
//
//  Created by Gabriele D'Intino on 28/08/20.
//

import SwiftUI

struct TileView: View {
//
//    @Namespace private var animation
//    @State private var isZoomed = false
//
//    var frame: CGFloat {
//        isZoomed ? 300 : 44
//    }
//
//    var body: some View {
//        VStack {
//            Spacer()
//
//            VStack {
//                HStack {
//                    RoundedRectangle(cornerRadius: 10)
//                        .fill(Color.blue)
//                        .frame(width: frame, height: frame)
//                        .padding(.top, isZoomed ? 20 : 0)
//
//                    if isZoomed == false {
//                        Text("Taylor Swift – 1989")
//                            .matchedGeometryEffect(id: "AlbumTitle", in: animation)
//                            .font(.headline)
//                        Spacer()
//                    }
//                }
//
//                if isZoomed == true {
//                    Text("Taylor Swift – 1989")
//                        .matchedGeometryEffect(id: "AlbumTitle", in: animation)
//                        .font(.headline)
//                        .padding(.bottom, 60)
//                    Spacer()
//                }
//            }
//            .onTapGesture {
//                withAnimation(.spring()) {
//                    self.isZoomed.toggle()
//                }
//            }
//            .padding()
//            .frame(maxWidth: .infinity)
//            .frame(height: isZoomed ? 400 : 60)
//            .background(Color(white: 0.9))
//        }
//    }
    
    var name: String
    var fontStyle: Font = .title2

	var body: some View {
		ZStack {
			Rectangle()
                .cornerRadius(10)
            LinearGradient(gradient: Gradient(colors: [.yellow, .red]), startPoint: .top, endPoint: .bottom)
                .cornerRadius(10)
            Text(name)
                .foregroundColor(.white)
                .fontWeight(.bold)
                .font(fontStyle)
                .lineLimit(2)
                .allowsTightening(true)
		}
//        .padding(.leading, 10)
	}
}
//
struct TileView_Previews: PreviewProvider {
    static var previews: some View {
        TileView(name: "Test")
    }
}
