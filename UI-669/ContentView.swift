//
//  ContentView.swift
//  UI-669
//
//  Created by nyannyan0328 on 2022/09/16.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State var showContent : Bool = false
    @State var change : [Album] = albums
    var body: some View {
        ZStack{
            
            let regio = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 25.240, longitude: 55.2700), latitudinalMeters: 10000, longitudinalMeters: 10000)

            Map(coordinateRegion: .constant(regio))
                .ignoresSafeArea()
                .overlay(alignment: .topTrailing) {
                    
                    Button {
                        
                        showContent.toggle()
                        
                    } label: {
                     
                         Image(systemName: "gearshape.fill")
                            .padding(.trailing,20)
                        
                    }
                }
                .bottomSheet(presentationDentes: [.medium,.large,.height(60)], isPreseted: .constant(true), sheetCornerRadius: 10) {
                    
                    ScrollView(.vertical,showsIndicators: false){
                        
                        VStack{
                            ZStack{
                         
                                TextField("Seach", text: .constant(""))
                                    .textFieldStyle(.roundedBorder)
                                
                                Image(systemName: "magnifyingglass")
                                       .font(.title3)
                                       .foregroundColor(.gray)
                                  .frame(maxWidth: .infinity,alignment: .trailing)
                                  .padding(.trailing,25)
                                   
                            }
                            .padding(.top,35)
                            .padding(.leading,20)
                            .padding(.vertical,10)
                            
                            
                            SongList()
                        
                            
                        }
                        .padding(14)
                        
                        
                    }
                   
                    .background{
                     
                        Rectangle()
                            .fill(.ultraThinMaterial).ignoresSafeArea()
                    }
                    
                } onDissMiss: {
                    
                    
                }
             

            
           
        }
    }
    @ViewBuilder
    func SongList ()->some View{
        
        
        VStack(alignment:.leading,spacing: 10){
            
            
            ForEach($change){$change in
                
                HStack{
                    
                    Text("# \(getIndex(album:change) + 1)")
                    
                    Image(change.albumImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                         .frame(width: 50,height: 50)
                         .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                    
                    
                    Divider()
                    
                    VStack(alignment:.leading,spacing: 10){
                        
                     
                        Text(change.albumName)
                            .font(.title2)
                            .foregroundColor(.black)
                        
                        HStack(spacing:15){
                            
                         
                             Image(systemName: "beats.earphones")
                                .font(.title3)
                                
                              Text("3333,3333,333")
                                .font(.caption.bold())
                            
                            
                            
                        }
                         
                        
                    }
                    .frame(maxWidth: .infinity,alignment: .leading)
                    
                    
                    HStack{
                        
                        Button {
                            
                            withAnimation {
                                
                                change.isLiked.toggle()
                                
                                
                            }
                            
                        } label: {
                            
                             Image(systemName: "suit.heart.fill")
                                .foregroundColor(change.isLiked ? .red : .gray)
                            
                        }
                        
                        
                        Button {
                            
                        } label: {
                            
                             Image(systemName: "figure.elliptical")
                                .rotationEffect(.init(degrees: -10))
                            
                        }
                    }
                    
                    
                }
                
                Divider()
                    .padding(.horizontal,-15)
            }
            
            
        }
        
        
    }
    func getIndex(album : Album)->Int{
        
        return albums.firstIndex { CAL in
            CAL.id == album.id
        } ?? 0
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension View{
    
    @ViewBuilder
    func bottomSheet<Content : View> (
    
        presentationDentes : Set<PresentationDetent>,
        isPreseted : Binding<Bool>,
        dragIndicatior : Visibility = .visible,
        sheetCornerRadius : CGFloat?,
        lagestUndimiIdentifire : UISheetPresentationController.Detent.Identifier = .large,
        isTransparentBG : Bool = false,
        indteractedDisable : Bool = true,
        @ViewBuilder content : @escaping()->Content,
        onDissMiss : @escaping()->()
    
    
    
    
    
    )->some View{
        
        self
            .sheet(isPresented: isPreseted) {
                
                
                content()
                    .presentationDetents(presentationDentes)
                    .presentationDragIndicator(dragIndicatior)
                    .interactiveDismissDisabled(indteractedDisable)
                    .onAppear{
                        
                        guard let windows = UIApplication.shared.connectedScenes.first as? UIWindowScene else{
                            
                            return
                        }
                        
                        if let controller = windows.windows.first?.rootViewController?.presentedViewController,let sheet = controller.presentationController as? UISheetPresentationController{
                            
                            if isTransparentBG{
                                controller.view.backgroundColor = .red
                                
                            }
                            controller.presentedViewController?.view.tintAdjustmentMode = .normal
                            sheet.largestUndimmedDetentIdentifier = lagestUndimiIdentifire
                            sheet.preferredCornerRadius = sheetCornerRadius
                            
                        }
                    }
            }
        
    }
}
