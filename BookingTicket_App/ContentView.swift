//
//  ContentView.swift
//  BookingTicket_App
//
//  Created by Li-Len on 6/19/21.
//  Copyright © 2021 Li-Len. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Lobby().preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Home: View{
    var body: some View{
        VStack(spacing: 15){
            HStack{
                VStack(alignment: .leading, spacing: 15){
                    Text("Browse").font(.largeTitle)
                    Button(action: {
                        
                    }) {
                        HStack(spacing: 8){
                            Text("Movies In New York")
                            Image(systemName: "chevron.down").font(.body)
                        }
                    }.foregroundColor(.black)
                }
                Spacer()
                Button(action: {
                    
                }){
                    Image("icons8-menu-48").renderingMode(.original)
                }
            }
            SearchView().padding(.vertical,15)
            
        }.padding()
    }
}

struct SearchView : View {
    @State var txt = ""
    var body : some View{
        HStack(spacing: 15){
            Image(systemName: "magnifyingglass").font(.body)
            TextField("Search Movies", text: $txt)
            }.padding().foregroundColor(.black).background(Color("Color"))
    }
}

struct Lobby : View {
    
    @State var index = 0
    
    var body: some View{
        GeometryReader{_ in
            VStack{
                Image("icons8-movie-ticket-64").resizable().frame(width: 60, height: 60)
                
                ZStack{
                    SignUp(index: self.$index).zIndex(Double(self.index))
                    Login(index: self.$index)
                }
                
            }
        }.background(Color("Color").edgesIgnoringSafeArea(.all))
}
}

struct CShape: Shape {
    func path(in rect: CGRect) -> Path {
        return Path{path in
            
            path.move(to: CGPoint(x: rect.width, y:100))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: 0,y: rect.height))
            path.addLine(to: CGPoint(x:0, y:0))
        }
    }
    
}
struct CShape1: Shape {
    func path(in rect: CGRect) -> Path {
        return Path{path in
            
            path.move(to: CGPoint(x: 0, y:100))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width,y: rect.height))
            path.addLine(to: CGPoint(x:rect.width, y:0))
        }
    }
    
}

struct Login: View{
    @State var email = ""
    @State var pass = ""
    @Binding var index : Int
    
    var body: some View{
        ZStack(alignment: .bottom){
            VStack{
                HStack{
                    VStack(spacing: 10){
                        Text("Login").foregroundColor(self.index == 0 ? .white : .gray).font(.title).fontWeight(.bold)
                        Capsule().fill(self.index == 0 ? Color.blue : Color.clear).frame(width: 100, height: 5)
                    }
                    Spacer(minLength: 0)
                }.padding(.top,40)
                
                VStack{
                    HStack(spacing: 15){
                        Image(systemName: "envelope.fill").foregroundColor(Color("Color-1"))
                        TextField("email Address", text: self.$email)
                    }
                    
                    Divider().background(Color.white.opacity(0.5))
                }.padding(.horizontal).padding(.top,40)
                
                VStack{
                    HStack(spacing: 15){
                        Image(systemName: "eye.slash.fill").foregroundColor(Color("Color-1"))
                        SecureField("Password", text: self.$pass)
                    }
                    
                    Divider().background(Color.white.opacity(0.5))
                }.padding(.horizontal).padding(.top,30)
                
                HStack{
                    Spacer(minLength: 0)
                    Button(action: {
                        
                    }){
                        Text("forget Password?").foregroundColor(Color.white.opacity(0.6))
                    }
                }
                
            }.padding().padding(.bottom, 65).background(Color("Color-2")).clipShape(CShape()).contentShape(CShape()).shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: -5).onTapGesture {
                self.index = 0
            }.cornerRadius(35).padding(.horizontal,20)
            
            Button(action: {
                
            }){
                Text("Login").foregroundColor(.white).fontWeight(.bold).padding(.vertical).padding(.horizontal, 50).background(Color("Color-1")).clipShape(Capsule()).shadow(color: Color.white.opacity(0.1), radius: 5, x: 0, y: 5)
            }.offset(y:25).opacity(self.index == 0 ? 1 : 0)
            
        }
    }
}

struct SignUp: View{
    @State var email = ""
    @State var pass = ""
    @State var Repass = ""
    @Binding var index : Int
    
    var body: some View{
        ZStack(alignment: .bottom){
            VStack{
                HStack{
                    Spacer(minLength: 0)
                    VStack(spacing: 10){
                        
                        Text("SignUp").foregroundColor(self.index == 1 ? .white : .gray).font(.title).fontWeight(.bold)
                        Capsule().fill(self.index == 1 ? Color.blue : Color.clear).frame(width: 100, height: 5)
                    }
                }.padding(.top,30)
                
                VStack{
                    HStack(spacing: 15){
                        Image(systemName: "envelope.fill").foregroundColor(Color("Color-1"))
                        TextField("email Address", text: self.$email)
                    }
                    
                    Divider().background(Color.white.opacity(0.5))
                }.padding(.horizontal).padding(.top,40)
                
                VStack{
                    HStack(spacing: 15){
                        Image(systemName: "eye.slash.fill").foregroundColor(Color("Color-1"))
                        SecureField("Password", text: self.$pass)
                    }
                    
                    Divider().background(Color.white.opacity(0.5))
                }.padding(.horizontal).padding(.top,30)
                
                VStack{
                    HStack(spacing: 15){
                        Image(systemName: "eye.slash.fill").foregroundColor(Color("Color-1"))
                        SecureField("Re_password", text: self.$Repass)
                    }
                    
                    Divider().background(Color.white.opacity(0.5))
                }.padding(.horizontal).padding(.top,30)
                
            }.padding().padding(.bottom, 65).background(Color("Color-2")).clipShape(CShape1()).contentShape(CShape1()).shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: -5).onTapGesture {
                self.index = 1
            }.cornerRadius(35).padding(.horizontal,20)
            
            Button(action: {
                
            }){
                Text("Sign Up").foregroundColor(.white).fontWeight(.bold).padding(.vertical).padding(.horizontal, 50).background(Color("Color-1")).clipShape(Capsule()).shadow(color: Color.white.opacity(0.1), radius: 5, x: 0, y: 5)
            }.offset(y:25).opacity(self.index == 1 ? 1 : 0)
            
        }
    }
}
