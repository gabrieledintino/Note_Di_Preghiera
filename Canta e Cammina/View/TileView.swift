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

	var body: some View {
		ZStack {
			Rectangle()
//                .clipShape(RoundedRectangle(cornerRadius: 10))
                .cornerRadius(10)
            LinearGradient(gradient: Gradient(colors: [.yellow, .red]), startPoint: .top, endPoint: .bottom)
//				.clipShape(RoundedRectangle(cornerRadius: 10))
                .cornerRadius(10)
            Text(name)
                .foregroundColor(.white)
                .fontWeight(.bold)
                .font(.title2)
//			HStack {
//				VStack(alignment: .leading) {
//					Text("\(item.name)")
//						.font(.headline)
//						.foregroundColor(.white)
//					Text("\(item.description)")
//						.foregroundColor(.white)
//				}
//				.frame(maxWidth: 200, maxHeight: 100)
//				Spacer()
//				Text("Completed \(item.count) times")
//					.foregroundColor(.white)
//			}
		}
	}
}
//
//struct TileView_Previews: PreviewProvider {
//    static var previews: some View {
//        TileView(name: "Test")
//    }
//}
